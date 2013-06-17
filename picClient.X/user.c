/******************************************************************************/
/* Files to Include                                                           */
/******************************************************************************/

#ifdef __XC32
    #include <xc.h>          /* Defines special funciton registers, CP0 regs  */
#endif

#include <plib.h>            /* Include to use PIC32 peripheral libraries     */
#include <stdint.h>          /* For uint32_t definition                       */
#include <stdbool.h>         /* For true/false definition                     */
#include "user.h"            /* variables/params used by user.c               */
#include "HardwareProfile.h" /* For clock speed */
#include "websocket.h"


/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

void InitApp(void)
{
    /* Setup analog functionality and port direction */
    mPORTASetPinsDigitalOut(BIT_0);  // Test LED

    /* UART1 pin mapping */
    PPSInput (3,  U1RX, RPA4);
    mPORTASetPinsDigitalIn(BIT_4);
    PPSOutput(1,  RPB4, U1TX);
    mPORTBSetPinsDigitalOut(BIT_4);

    /* UART2 pin mapping */
    PPSInput (2,  U2RX, RPB8);
    mPORTBSetPinsDigitalIn(BIT_8);
    PPSOutput(4,  RPB9, U2TX);
    mPORTBSetPinsDigitalOut(BIT_9);

    /* SPI1 pin mapping */
    PPSInput (2,  SDI1, RPA1);
    mPORTASetPinsDigitalIn(BIT_1);
    PPSOutput(3, RPB13, SDO1);
    mPORTBSetPinsDigitalOut(BIT_13);
    // Note : SPI1 is initialized by TCPIP Library

    /* Initialize peripherals */
    OpenUART1(UART_EN | UART_BRGH_SIXTEEN,  UART_RX_ENABLE | UART_TX_ENABLE, // take care to idle state
            GetPeripheralClock()/(16*9600) - 1);
    OpenUART2(UART_EN | UART_BRGH_SIXTEEN,  UART_RX_ENABLE | UART_TX_ENABLE, // take care to idle state
            GetPeripheralClock()/(16*9600) - 1);

    putsUART1("\r\nUART1\r\n");
    putsUART2("\r\nUART2\r\n");

    DmaChnOpen(DMA_CHANNEL0, DMA_CHN_PRI0, DMA_OPEN_DEFAULT /*DMA_OPEN_AUTO*/);
    DmaChnSetEventControl(DMA_CHANNEL0, DMA_EV_START_IRQ_EN | DMA_EV_START_IRQ(_UART1_RX_IRQ));
    DmaChnSetTxfer(DMA_CHANNEL0, (void *)&U1RXREG, (void *)ul_buffer, 1, UL_BUFFER_LEN, 1);
    DmaChnEnable(DMA_CHANNEL0);

    DmaChnOpen(DMA_CHANNEL1, DMA_CHN_PRI0, DMA_OPEN_DEFAULT);
    DmaChnSetEventControl(DMA_CHANNEL1, DMA_EV_START_IRQ_EN | DMA_EV_START_IRQ(_UART2_TX_IRQ));
    //DmaChnSetEvEnableFlags(DMA_CHANNEL1, DMA_EV_BLOCK_DONE);
}
