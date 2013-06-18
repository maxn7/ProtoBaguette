
#include "HardwareProfile.h"
#include "TCPIP.h"
#include "websocket.h"
#include "Helpers.h"



volatile BYTE tx_buffer[TX_BUFFER_LEN];
volatile BYTE rx_buffer[RX_BUFFER_LEN];


const ROM BYTE* ServerName = "baguette.hexabread.com"; // servername

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

    if(!TCPIsConnected(socket)
            && state != WEBSOCKET_INIT
            && state != WEBSOCKET_CONNECTING) {
        DEBUG_UART("Unexpected disconnection");
        state = WEBSOCKET_ERROR;
    }

    switch(state) {
        case WEBSOCKET_INIT:
            DEBUG_UART("Connecting...");
            socket = TCPOpen((DWORD)(PTR_BASE)&ServerName[0], TCP_OPEN_ROM_HOST, SERVER_PORT, TCP_PURPOSE_WEBSOCKET);

            if (socket == INVALID_SOCKET) {
                DEBUG_UART("Invalid socket");
                state = WEBSOCKET_ERROR;
                break;
            }

            state = WEBSOCKET_CONNECTING;
            timer = TickGet();
            break;

        case WEBSOCKET_CONNECTING:
            // Wait for the remote server to accept our connection request
            if (!TCPIsConnected(socket)) {
                // Time out if too much time is spent in this state
                if (TickGet() - timer > 10 * TICK_SECOND) {
                    TCPDisconnect(socket);
                    socket = INVALID_SOCKET;
                    DEBUG_UART("Socket not connected");
                    state = WEBSOCKET_ERROR;
                }
                break;
            }

#ifdef WEBSOCKET_SECURE
            DEBUG_UART("Starting SSL...");
            if (!TCPStartSSLClient(socket, NULL)) {
                DEBUG_UART("Cannot start SSL");
                state = WEBSOCKET_ERROR;
                break;
            }

            state = WEBSOCKET_SSL_HANDSHAKING;
            break;

        case WEBSOCKET_SSL_HANDSHAKING:
            if (TCPSSLIsHandshaking(socket)) {
                // Time out if too much time is spent in this state
                if (TickGet() - timer > 20 * TICK_SECOND) {
                    DEBUG_UART("SSL time out");
                    state = WEBSOCKET_ERROR;
                }
                break;
            }
#endif

            DEBUG_UART("Websocket handshake...");

            TCPPutROMString(socket, (ROM BYTE*)"GET /channel/");
            TCPPutString(socket, "abc");
            TCPPutROMString(socket, (ROM BYTE*)" HTTP/1.1\r\n"
                "Host: ");
            TCPPutROMString(socket, ServerName);
            TCPPutROMString(socket, (ROM BYTE*)"\r\n"
                "Authorization: Basic ");
            TCPPutROMString(socket, "QWxhZGRpbjpvcGVuIHNlc2FtZQ==");
            TCPFlush(socket); // HACK? ou c'est juste le port pas au hasard

            state = WEBSOCKET_SENDING_HANDSHAKE;
            break;

        case WEBSOCKET_SENDING_HANDSHAKE:
            DEBUG_UART("Websocket handshake...");

            TCPPutROMString(socket, (ROM BYTE*) "\r\n"
                "Upgrade: websocket\r\n"
                "Connection: Upgrade\r\n"
                "Sec-WebSocket-Protocol: baguette1.hexabread.com\r\n"
                "Sec-WebSocket-Version: 13\r\n"
                "Sec-WebSocket-Key: ");
            TCPPutString(socket, "dGhlIHNhbXBsZSBub25jZQ==");
            TCPPutROMString(socket, (ROM BYTE*)"\r\n\r\n");

            TCPFlush(socket);

            state = WEBSOCKET_HTTP_STATUS;
            break;

        case WEBSOCKET_HTTP_STATUS:
            DEBUG_UART("HTTP status reception...");

            // Verify the entire first line is in the FIFO
            int eol = TCPFind(socket, '\n', 0, FALSE);
            if (eol == 0xffff) {
                // First line isn't here yet
                if (TCPGetRxFIFOFree(socket) == 0) {
                    DEBUG_UART("Overflow");
                    state = WEBSOCKET_ERROR;
                }
                else if ((LONG)(TickGet() - timer) > 30 * TICK_SECOND) {
                    DEBUG_UART("Timeout");
                    state = WEBSOCKET_ERROR;
                }
                break;
            }

            if (TCPMatch(socket, "HTTP/1.1 101 ") != 0) {
                DEBUG_UART("Wrong HTTP code");
                state = WEBSOCKET_ERROR;
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
                        DEBUG_UART("Overflow");
                        state = WEBSOCKET_ERROR;
                    }
                    else if ((LONG)(TickGet() - timer) > 35 * TICK_SECOND) {
                        DEBUG_UART("Timeout");
                        state = WEBSOCKET_ERROR;
                    }
                    break;
                }

                // If a CRLF is immediate, then headers are done
                if (eol == 1) {
                    // Remove the CRLF and move to next state
                    TCPGetArray(socket, NULL, 2);
                    uploading = WEBSOCKET_FRAME_HEADER;
                    downloading = WEBSOCKET_FRAME_HEADER;
                    DEBUG_UART("Frame reception...");
                    state = WEBSOCKET_ESTABLISHED;
                    break;
                }

                TCPGetArray(socket, NULL, eol + 1); // Discard header line.
            }
            break;

        case WEBSOCKET_ESTABLISHED:
            Nop();

            static int expected_bytes;
            static BYTE *cur_tx_buffer;
            if (downloading == WEBSOCKET_FRAME_HEADER) {
                if (TCPIsGetReady(socket) >= 2) { // Header available
                    static websocket_frame receiving_frame;

                    TCPGetArray(socket, receiving_frame.raw_data, 2);

                    if (receiving_frame.payload_len == 126 || receiving_frame.payload_len == 127) {
                        downloading = WEBSOCKET_FRAME_HEADER_EXT; // TODO larger DMA ?
                    }
                    else {
                        if (!receiving_frame.FIN) {
                            DEBUG_UART("No FIN flag");
                            state = WEBSOCKET_ERROR;
                        }
                        else if (receiving_frame.mask) {
                            DEBUG_UART("MASK flag");
                            state = WEBSOCKET_ERROR;
                        }
                        else if (receiving_frame.opcode == OPCODE_TEXT_FRAME || receiving_frame.opcode != OPCODE_BINARY_FRAME) {
                            expected_bytes = receiving_frame.payload_len;
                            cur_tx_buffer = (BYTE *)tx_buffer;
                            downloading = WEBSOCKET_FRAME_PAYLOAD;
                        }
                        else {
                            DEBUG_UART("Unexpected frame type"); // TODO ping etc
                            state = WEBSOCKET_ERROR;
                        }
                    }
                }
            }
            else if (downloading == WEBSOCKET_FRAME_PAYLOAD) {
                if (DmaChnGetEvFlags(TX_CHANNEL) & DMA_EV_BLOCK_DONE) { // No transfer running.
                    int available_bytes = min(min(TCPIsGetReady(socket), TX_BUFFER_LEN), expected_bytes);

                    int read = TCPGetArray(socket, (BYTE *)cur_tx_buffer, available_bytes);
                    if (read < available_bytes) {
                        DEBUG_UART("Disconnected");
                        state = WEBSOCKET_ERROR;
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
                state = WEBSOCKET_ERROR;
            }


            static int remaining_payload;
            static BYTE *cur_rx_buffer;
            if (uploading == WEBSOCKET_FRAME_HEADER) {
                if (TCPIsPutReady(socket) >= 2) { // Enough room for the header
                    DmaChnDisable(RX_CHANNEL);
                    if (DmaChnGetEvFlags(RX_CHANNEL) & DMA_EV_BLOCK_DONE) { // We reached the end of the buffer.
                        remaining_payload = RX_BUFFER_LEN;
                    }
                    else {
                        remaining_payload = DmaChnGetDstPnt(RX_CHANNEL);
                    }
                    DmaChnAbortTxfer(RX_CHANNEL);

                    if (remaining_payload) {
                        websocket_frame sending_frame;
                        sending_frame.FIN = 1;
                        sending_frame.RSV = 0;
                        sending_frame.mask = 1;
                        sending_frame.opcode = OPCODE_BINARY_FRAME;
                        sending_frame.masking_key = LFSRRand();
                        sending_frame.payload_len = remaining_payload;

                        TCPPutArray(socket, sending_frame.raw_data, 2);
                        cur_rx_buffer = (BYTE *)rx_buffer;

                        uploading = WEBSOCKET_FRAME_PAYLOAD;
                    }
                    else {
                        DmaChnEnable(RX_CHANNEL);
                    }
                }
            }
            else if (uploading == WEBSOCKET_FRAME_PAYLOAD) {
                int bytes_to_send = min(remaining_payload, TCPIsPutReady(socket));
                int written = TCPPutArray(socket, cur_rx_buffer, bytes_to_send);
                if (written < bytes_to_send) {
                    DEBUG_UART("Unable to send");
                    state = WEBSOCKET_ERROR;
                    break;
                }
                cur_rx_buffer += bytes_to_send;
                remaining_payload -= bytes_to_send;

                if (remaining_payload == 0) {
                    DmaChnEnable(RX_CHANNEL);
                    DEBUG_UART("Frame sent.");
                    uploading = WEBSOCKET_FRAME_HEADER;
                }
            }
            else {
                DEBUG_UART("Unexpected sending state");
                state = WEBSOCKET_ERROR;
            }

            break;

        case WEBSOCKET_ERROR:
            DEBUG_UART("(unrecoverable error)");
            while(1);
            break;

        default:
            DEBUG_UART("Unexpected state");
            state = WEBSOCKET_ERROR;
            break;
    }
}