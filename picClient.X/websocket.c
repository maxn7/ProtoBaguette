
#include "HardwareProfile.h"
#include "TCPIP.h"
#include "websocket.h"
#include "Helpers.h"
#include "user.h"



volatile BYTE tx_buffer[TX_BUFFER_LEN];
volatile BYTE rx_buffer[RX_BUFFER_LEN];

BYTE identifier[] = "ABCDEF:1234567890"; // TODO EEPROM variable

const ROM BYTE* ServerName = "hexabread.com"; // servername

WORD TCPMatch(TCP_SOCKET socket, BYTE *str) // Checks if the next bytes are as expected.
{
    int len = strlenpgm(str);
    return TCPFindArrayEx(socket, str, len, 0, len, TRUE);
}


BOOL WebsocketTask()
{
    static DWORD timer;
    static websocket_connexion_state state = WEBSOCKET_INIT;
    static websocket_frame_state uploading;
    static websocket_frame_state downloading;
    static TCP_SOCKET socket;
    static int close_expected;
    static int pong_expected;

    if(!TCPIsConnected(socket)
            && state != WEBSOCKET_INIT
            && state != WEBSOCKET_CONNECTING
            && state != WEBSOCKET_FAILURE
            && state != WEBSOCKET_RETRY
            && state != WEBSOCKET_FATAL) {
        DEBUG_UART("Unexpected disconnection");
        state = WEBSOCKET_FAILURE;
    }

    switch(state) {
        case WEBSOCKET_INIT:
            DEBUG_UART("Connecting...");
            socket = TCPOpen((DWORD)(PTR_BASE)&ServerName[0], TCP_OPEN_ROM_HOST, SERVER_PORT, TCP_PURPOSE_WEBSOCKET);

            if (socket == INVALID_SOCKET) {
                DEBUG_UART("Invalid socket");
                state = WEBSOCKET_FAILURE;
                break;
            }

            state = WEBSOCKET_CONNECTING;
            timer = TickGet();
            break;

        case WEBSOCKET_CONNECTING:
            // Wait for the remote server to accept our connection request
            if (!TCPIsConnected(socket)) {
                // Time out if too much time is spent in this state
                if (TickGet() - timer > 10ull * TICK_SECOND) {
                    DEBUG_UART("Socket connection timeout");
                    state = WEBSOCKET_FAILURE;
                }
                break;
            }

#ifdef WEBSOCKET_SECURE
            DEBUG_UART("Starting SSL...");
            if (!TCPStartSSLClient(socket, NULL)) {
                DEBUG_UART("Cannot start SSL");
                state = WEBSOCKET_FAILURE;
                break;
            }

            state = WEBSOCKET_SSL_HANDSHAKING;
            break;

        case WEBSOCKET_SSL_HANDSHAKING:
            if (TCPSSLIsHandshaking(socket)) {
                // Time out if too much time is spent in this state
                if (TickGet() - timer > 20ull * TICK_SECOND) {
                    DEBUG_UART("SSL time out");
                    state = WEBSOCKET_FAILURE;
                }
                break;
            }
#endif

            DEBUG_UART("Websocket handshake...");

            TCPPutROMString(socket, (ROM BYTE*)"GET /baguette/channel/");
            TCPPutROMString(socket, (ROM BYTE*)" HTTP/1.1\r\nHost: ");
            TCPPutROMString(socket, ServerName);
            TCPPutROMString(socket, (ROM BYTE*)"\r\nAuthorization: Basic ");
            BYTE auth[(sizeof(identifier) - 1) * 4 / 3 + 2]; // For size see Base64Encode() remarks
            int auth_len = Base64Encode(identifier, strlen(identifier), auth, sizeof(auth));
            TCPPutArray(socket, auth, auth_len);

            state = WEBSOCKET_SENDING_HANDSHAKE;
            break;

        case WEBSOCKET_SENDING_HANDSHAKE:
            DEBUG_UART("Websocket handshake...");

            // TODO check available room or merge with previous case
            TCPPutROMString(socket, (ROM BYTE*) "\r\n"
                "Upgrade: websocket\r\n"
                "Connection: Upgrade\r\n"
                "Sec-WebSocket-Protocol: baguette1.hexabread.com\r\n"
                "Sec-WebSocket-Version: 13\r\n"
                "Sec-WebSocket-Key: ");

            WORD nonce[8]; // 16 random bytes.
            int i;
            for(i = 0; i < sizeof(nonce); i++) {
                nonce[i] = LFSRRand();
            }
            BYTE key[sizeof(nonce) * 4 / 3 + 2];
            int key_len = Base64Encode((BYTE*)nonce, sizeof(nonce), key, sizeof(key));
            TCPPutArray(socket, key, key_len);

            TCPPutROMString(socket, (ROM BYTE*)"\r\n\r\n"); // End of headers.

            state = WEBSOCKET_HTTP_STATUS;
            break;

        case WEBSOCKET_HTTP_STATUS:
            DEBUG_UART("HTTP status reception...");

            // Verify the entire first line is in the FIFO
            int eol = TCPFind(socket, '\n', 0, FALSE);
            if (eol == 0xffff) {
                // First line isn't here yet
                if (TCPGetRxFIFOFree(socket) == 0) {
                    DEBUG_UART("Status overflow");
                    state = WEBSOCKET_FAILURE;
                }
                else if ((LONG)(TickGet() - timer) > 30ull * TICK_SECOND) {
                    DEBUG_UART("Status timeout");
                    state = WEBSOCKET_FAILURE;
                }
                break;
            }

            if (TCPMatch(socket, "HTTP/1.1 101 ") != 0) {
                DEBUG_UART("Wrong HTTP code");
                state = WEBSOCKET_FAILURE;
            }
            
            TCPGetArray(socket, NULL, eol + 1); // Discard first line.
            
            state = WEBSOCKET_HTTP_HEADERS;
            break;

        case WEBSOCKET_HTTP_HEADERS:
            DEBUG_UART("HTTP headers reception...");

            // Loop over all the headers
            while (1) {
                // Verify the entire first line is in the FIFO
                int eol = TCPFind(socket, '\n', 0, FALSE);
                if (eol == 0xffff) {
                    // First line isn't here yet
                    if (TCPGetRxFIFOFree(socket) == 0) {
                        DEBUG_UART("Header overflow");
                        state = WEBSOCKET_FAILURE;
                    }
                    else if ((LONG)(TickGet() - timer) > 35ull * TICK_SECOND) {
                        DEBUG_UART("Header timeout");
                        state = WEBSOCKET_FAILURE;
                    }
                    break;
                }

                // If a CRLF is immediate, then headers are done
                if (eol == 1) {
                    // Remove the CRLF and move to next state
                    TCPGetArray(socket, NULL, 2);
                    uploading = WEBSOCKET_FRAME_HEADER;
                    downloading = WEBSOCKET_FRAME_HEADER;
                    close_expected = 0;
                    pong_expected = 0;
                    DEBUG_UART("Frame reception...");
                    state = WEBSOCKET_ESTABLISHED;
                    NO_ERROR = 1;
                    break;
                }

                TCPGetArray(socket, NULL, eol + 1); // Discard header line.
            }
            break;

        case WEBSOCKET_ESTABLISHED:
            Nop();

            static LONGLONG expected_bytes; // Signed 64 bits, so not all frame size are valid.
            static BYTE *cur_tx_buffer;
            if (downloading == WEBSOCKET_FRAME_HEADER) {
                if (TCPIsGetReady(socket) >= 2) { // Header available
                    static websocket_frame receiving_frame;

                    TCPGetArray(socket, receiving_frame.raw_data, 2);

                    if (!receiving_frame.FIN) {
                        DEBUG_UART("No FIN flag");
                        state = WEBSOCKET_FAILURE;
                    }
                    else if (receiving_frame.mask) {
                        DEBUG_UART("MASK flag");
                        state = WEBSOCKET_FAILURE;
                    }
                    else if (receiving_frame.opcode == OPCODE_TEXT_FRAME || receiving_frame.opcode == OPCODE_BINARY_FRAME) {
                        expected_bytes = receiving_frame.payload_len;
                        cur_tx_buffer = (BYTE *)tx_buffer;
                        if (expected_bytes == 126 || expected_bytes == 127) {
                            downloading = WEBSOCKET_FRAME_HEADER_EXT;
                        }
                        else {
                            downloading = WEBSOCKET_FRAME_PAYLOAD;
                        }
                    }
                    else if (receiving_frame.opcode == OPCODE_CLOSE) {
                        close_expected = 1;
                    }
                    else if (receiving_frame.opcode == OPCODE_PING) {
                        if (receiving_frame.payload_len > 0) {
                            DEBUG_UART("Ping has payload"); // FIXME send this as a Close message instead.
                            state = WEBSOCKET_FAILURE;
                        }
                        else {
                            pong_expected = 1;
                        }
                    }
                    else {
                        DEBUG_UART("Unexpected frame type");
                        state = WEBSOCKET_FAILURE;
                    }
                }
            }
            else if (downloading == WEBSOCKET_FRAME_HEADER_EXT) { // Extended payload length extraction
                int len_bytes; // Number of bytes for the length.
                if (expected_bytes == 127)
                    len_bytes = 8;
                else
                    len_bytes = 2;
                // FIXME : unkown limitation between 300 and 800 bytes.
                if (TCPIsGetReady(socket) >= len_bytes) {
                    BYTE b;
                    expected_bytes = 0;
                    while (len_bytes-- && TCPGet(socket, &b)) { // Convert from big to little endian.
                        expected_bytes = (expected_bytes << 8) | b;
                    }
                    downloading = WEBSOCKET_FRAME_PAYLOAD;
                }
            }
            else if (downloading == WEBSOCKET_FRAME_PAYLOAD) {
                if (DmaChnGetEvFlags(TX_CHANNEL) & DMA_EV_BLOCK_DONE) { // No transfer running.
                    int available_bytes = min(min(TCPIsGetReady(socket), TX_BUFFER_LEN), expected_bytes);

                    int read = TCPGetArray(socket, (BYTE *)cur_tx_buffer, available_bytes);
                    if (read < available_bytes) {
                        DEBUG_UART("Disconnected");
                        state = WEBSOCKET_FAILURE;
                        break;
                    }
                    expected_bytes -= available_bytes;
                    cur_tx_buffer += available_bytes;

                    if (expected_bytes <= 0) { // Transfer ended.
                        DmaChnSetTxfer(TX_CHANNEL, (void *)tx_buffer, (void *)&U1TXREG, cur_tx_buffer - tx_buffer, 1, 1);
                        DmaChnEnable(TX_CHANNEL);

                        DEBUG_UART("Frame forwarded.");
                        downloading = WEBSOCKET_FRAME_HEADER;
                    }
                }
            }
            else {
                DEBUG_UART("Unexpected receiving state");
                state = WEBSOCKET_FAILURE;
            }


            static int remaining_payload;
            static BYTE *cur_rx_buffer;
            static unsigned long masking_key;
            if (uploading == WEBSOCKET_FRAME_HEADER) {
                if (TCPIsPutReady(socket) >= 2) { // Enough room for the header
                    websocket_frame sending_frame;
                    sending_frame.FIN = 1;
                    sending_frame.RSV = 0;
                    sending_frame.mask = 1;

                    if (close_expected) {
                        sending_frame.opcode = OPCODE_CLOSE;
                        sending_frame.payload_len = 0;
                        TCPPutArray(socket, sending_frame.raw_data, 6);

                        DEBUG_UART("Websocket closed");
                        state = WEBSOCKET_FAILURE;
                    }
                    else if (pong_expected) {
                        sending_frame.opcode = OPCODE_PONG;
                        sending_frame.payload_len = 0;
                        TCPPutArray(socket, sending_frame.raw_data, 6);

                        pong_expected = 0;
                    }
                    else {
                        DmaChnDisable(RX_CHANNEL);
                        if (DmaChnGetEvFlags(RX_CHANNEL) & DMA_EV_BLOCK_DONE) { // We reached the end of the buffer.
                            remaining_payload = RX_BUFFER_LEN;
                        }
                        else {
                            remaining_payload = DmaChnGetDstPnt(RX_CHANNEL);
                        }
                        DmaChnAbortTxfer(RX_CHANNEL);

                        if (remaining_payload) {
                            masking_key = ((DWORD)LFSRRand()) << 16 | LFSRRand();
                            int i;
                            for(i = 0; i < remaining_payload; i++) { // Masking.
                                rx_buffer[i] ^= ((BYTE*)&masking_key)[i % 4];
                            }

                            sending_frame.opcode = OPCODE_BINARY_FRAME;
                            sending_frame.masking_key = masking_key;
                            sending_frame.payload_len = remaining_payload;

                            TCPPutArray(socket, sending_frame.raw_data, 6);
                            cur_rx_buffer = (BYTE *)rx_buffer;

                            uploading = WEBSOCKET_FRAME_PAYLOAD;
                        }
                        else {
                            DmaChnEnable(RX_CHANNEL);
                        }
                    }
                }
            }
            else if (uploading == WEBSOCKET_FRAME_PAYLOAD) {
                int bytes_to_send = min(remaining_payload, TCPIsPutReady(socket));

                int written = TCPPutArray(socket, cur_rx_buffer, bytes_to_send);
                if (written < bytes_to_send) {
                    DEBUG_UART("Unable to send");
                    state = WEBSOCKET_FAILURE;
                    break;
                }
                cur_rx_buffer += bytes_to_send;
                remaining_payload -= bytes_to_send;

                if (remaining_payload == 0) {
                    OpenRxDma();
                    DEBUG_UART("Frame sent.");
                    uploading = WEBSOCKET_FRAME_HEADER;
                }
            }
            else {
                DEBUG_UART("Unexpected sending state");
                state = WEBSOCKET_FAILURE;
            }

            break;

        case WEBSOCKET_FAILURE:
            TCPDisconnect(socket);

            NO_ERROR = 0;
            DEBUG_UART("  retrying in 10s");
            state = WEBSOCKET_RETRY;
            timer = TickGet();
            break;

        case WEBSOCKET_RETRY:
            if (TickGet() - timer > 10ull * TICK_SECOND) {
                state = WEBSOCKET_INIT;
            }
            break;

        case WEBSOCKET_FATAL:
            DEBUG_UART("(unrecoverable error)");
            while(1);
            break;

        default:
            DEBUG_UART("Unexpected state");
            state = WEBSOCKET_FAILURE;
            break;
    }
}