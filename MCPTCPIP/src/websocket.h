#ifndef WEBSOCKET_H
#define	WEBSOCKET_H


#define DEBUG_UART(str)   putsUART1((ROM char*)str "\r\n")

//#define WEBSOCKET_SECURE

#ifdef WEBSOCKET_SECURE
    #define SERVER_PORT   443
#else
    #define SERVER_PORT   80
#endif


typedef enum
{
    WEBSOCKET_INIT,
    WEBSOCKET_CONNECTING,
    WEBSOCKET_SSL_HANDSHAKING,
    WEBSOCKET_SENDING_HANDSHAKE,
    WEBSOCKET_HTTP_STATUS,
    WEBSOCKET_HTTP_HEADERS,
    WEBSOCKET_WAITING_FRAME_HEADER,
    WEBSOCKET_WAITING_FRAME_EXT_LEN,
    WEBSOCKET_WAITING_FRAME_PAYLOAD,
    WEBSOCKET_ERROR
} websocket_state;


typedef enum
{
    OPCODE_FRAME_CONTINUATION = 0,
    OPCODE_TEXT_FRAME = 1,
    OPCODE_BINARY_FRAME = 2,

    OPCODE_CONNECTION_CLOSE = 8,
    OPCODE_PING = 9,
    OPCODE_PONG = 10
} websocket_opcode;


typedef struct
{
    unsigned char  raw_data[0];
    unsigned char  opcode:4;
    unsigned char  RSV:3;
    unsigned char  FIN:1;
    unsigned char  payload_len:7;
    unsigned char  mask:1;
    unsigned char  payload_data[0];
    unsigned short ext_payload_len;
    unsigned char  ext_payload_data[0];
    unsigned int   cont_ext_payload_len;
    unsigned char  cont_ext_payload_data[0];
} websocket_frame;


#endif	/* WEBSOCKET_H */
