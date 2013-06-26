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
    WEBSOCKET_FAILURE,
    WEBSOCKET_RETRY,
    WEBSOCKET_FATAL
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

    OPCODE_CLOSE = 8,
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
    unsigned long  masking_key;
} websocket_frame;

#define TX_BUFFER_LEN   256
#define RX_BUFFER_LEN   256

#define TX_CHANNEL      DMA_CHANNEL0
#define RX_CHANNEL      DMA_CHANNEL1

extern volatile BYTE tx_buffer[TX_BUFFER_LEN];
extern volatile BYTE rx_buffer[RX_BUFFER_LEN];


#endif	/* WEBSOCKET_H */
