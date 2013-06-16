#ifndef WEBSOCKET_H
#define	WEBSOCKET_H


#define DEBUG_UART(str)   putsUART2((ROM char*)str "\r\n")

#define WEBSOCKET_SECURE

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
    WEBSOCKET_ESTABLISHED,
    WEBSOCKET_ERROR
} websocket_connexion_state;


typedef enum
{
    WEBSOCKET_FRAME_HEADER,
    WEBSOCKET_FRAME_HEADER_EXT,
    WEBSOCKET_FRAME_PAYLOAD
} websocket_frame_state;


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
    unsigned short masking_key;
} websocket_frame;

#define DL_BUFFER_LEN   256
#define UL_BUFFER_LEN   256

extern char dl_buffer[DL_BUFFER_LEN];
extern int  dl_read_pos;
extern int  dl_write_pos;

extern char ul_buffer[UL_BUFFER_LEN];
extern int  ul_read_pos;
extern int  ul_write_pos;


#endif	/* WEBSOCKET_H */
