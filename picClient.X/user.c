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

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

/* TODO Initialize User Ports/Peripherals/Project here */

void InitApp(void)
{

    /* Setup analog functionality and port direction */
    mPORTASetPinsDigitalOut(BIT_0);  // Test LED

    PPSInput (3,  U1RX, RPA4);
    mPORTASetPinsDigitalIn(BIT_4);

    PPSOutput(1,  RPB4, U1TX);
    mPORTBSetPinsDigitalOut(BIT_4);


    PPSInput (2,  SDI1, RPA1);
    mPORTASetPinsDigitalIn(BIT_1);
    
    PPSOutput(3, RPB13, SDO1);
    mPORTBSetPinsDigitalOut(BIT_13);


    /* Initialize peripherals */
    //OpenSPI1(SPI_MODE32_ON | SPI_SMP_ON | MASTER_ENABLE_ON | SEC_PRESCAL_1_1 | PRI_PRESCAL_1_1, SPI_ENABLE);

    OpenUART1(UART_EN | UART_BRGH_SIXTEEN,  UART_RX_ENABLE | UART_TX_ENABLE, // take care to idle state
            GetPeripheralClock()/(16*9600) - 1);
    
}
