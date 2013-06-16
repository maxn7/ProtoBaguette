
#include "HardwareProfile.h"
#include "TCPIP.h"
#include "websocket.h"
#include "Helpers.h"



volatile char dl_buffer[DL_BUFFER_LEN];
int  dl_read_pos  = 0;
int  dl_write_pos = 0;

volatile char ul_buffer[UL_BUFFER_LEN];
int  ul_read_pos  = 0;
int  ul_write_pos = 0;


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
    static websocket_frame_state sending;
    static websocket_frame_state receiving;
    static TCP_SOCKET socket;
    static websocket_frame receiving_frame;
    static int remaining_bytes;

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
                    sending = WEBSOCKET_FRAME_HEADER;
                    receiving = WEBSOCKET_FRAME_HEADER;
                    DEBUG_UART("Frame reception...");
                    state = WEBSOCKET_ESTABLISHED;
                    break;
                }

                TCPGetArray(socket, NULL, eol + 1); // Discard header line.
            }
            break;

        case WEBSOCKET_ESTABLISHED:
            if (receiving == WEBSOCKET_FRAME_HEADER) {
                if (TCPIsGetReady(socket) >= 2) { // Header available

                    TCPGetArray(socket, receiving_frame.raw_data, 2);

                    if (receiving_frame.payload_len == 126 || receiving_frame.payload_len == 127) {
                        receiving = WEBSOCKET_FRAME_HEADER_EXT; // TODO
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
                            remaining_bytes = receiving_frame.payload_len;

                            DEBUG_UART("Payload reception...");
                            receiving = WEBSOCKET_FRAME_PAYLOAD;
                        }
                        else {
                            DEBUG_UART("Unexpected frame type"); // TODO
                            state = WEBSOCKET_ERROR;
                        }
                    }
                }
            }
            else if (receiving == WEBSOCKET_FRAME_PAYLOAD) {
                int available_bytes = TCPIsGetReady(socket);

                if (available_bytes >= remaining_bytes) {
                    available_bytes = remaining_bytes;
                    DEBUG_UART("Frame reception...");
                    receiving = WEBSOCKET_FRAME_HEADER;
                }

                while (available_bytes && !U1STAbits.UTXBF) { // UART TX Buffer not full
                    BYTE byte;
                    if(TCPGet(socket, &byte) == FALSE) {
                        DEBUG_UART("TCPGet error");
                        state = WEBSOCKET_ERROR;
                        break;
                    }
                    putcUART1(byte);
                    remaining_bytes--;
                    available_bytes--;
                }
            }
            else {
                DEBUG_UART("Unexpected receiving state");
                state = WEBSOCKET_ERROR;
            }


            if (sending == WEBSOCKET_FRAME_HEADER) {
                if (TCPIsPutReady(socket) >= 2) { // Enough room for header
                    websocket_frame sending_frame;
                    sending_frame.FIN = 1;
                    sending_frame.RSV = 0;
                    sending_frame.mask = 1;
                    sending_frame.opcode = OPCODE_BINARY_FRAME;
                    sending_frame.masking_key = LFSRRand();
                    sending_frame.payload_len = 0; // TODO

                    TCPPutArray(socket, sending_frame.raw_data, 2);

                    sending = WEBSOCKET_FRAME_PAYLOAD;
                }
            }
            else if (sending == WEBSOCKET_FRAME_PAYLOAD) {
                // TODO
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