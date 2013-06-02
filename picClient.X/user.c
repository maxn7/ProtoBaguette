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

/******************************************************************************/
/* User Functions                                                             */
/******************************************************************************/

/* TODO Initialize User Ports/Peripherals/Project here */

void InitApp(void)
{
    /* Setup analog functionality and port direction */
    U1RXR = 2; // RPA4w
    RPB4R = 1; // U1TX

    /* Initialize peripherals */
    OpenSPI1(SPI_MODE32_ON | SPI_SMP_ON | MASTER_ENABLE_ON
            | SEC_PRESCAL_1_1 | PRI_PRESCAL_1_1, SPI_ENABLE);

}
