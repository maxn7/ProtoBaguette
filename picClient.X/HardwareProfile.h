 /*********************************************************************
 *
 *	Hardware specific definitions for:
 *    - PIC32 Starter Kit
 *    - PIC32MX360F512L
 *    - Ethernet PICtail Plus (ENC28J60)
 *
 *********************************************************************
 * FileName:        HardwareProfile.h
 * Dependencies:    Compiler.h
 * Processor:       PIC32
 * Compiler:        Microchip C32 v1.11 or higher
 * Company:         Microchip Technology, Inc.
 *
 * Software License Agreement
 *
 * Copyright (C) 2002-2010 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and
 * distribute:
 * (i)  the Software when embedded on a Microchip microcontroller or
 *      digital signal controller product ("Device") which is
 *      integrated into Licensee's product; or
 * (ii) ONLY the Software driver source files ENC28J60.c, ENC28J60.h,
 *		ENCX24J600.c and ENCX24J600.h ported to a non-Microchip device
 *		used in conjunction with a Microchip ethernet controller for
 *		the sole purpose of interfacing with the ethernet controller.
 *
 * You should refer to the license agreement accompanying this
 * Software for additional information regarding your rights and
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 *
 * Author               Date		Comment
 *~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 * Howard Schlunder		09/16/2010	Regenerated for specific boards
 ********************************************************************/
#ifndef HARDWARE_PROFILE_H
#define HARDWARE_PROFILE_H

#include "Compiler.h"


// Define a macro describing this hardware set up (used in other files)
#define PIC32_GP_SK_DM320001


// Clock frequency values
// These directly influence timed events using the Tick module.  They also are used for UART and SPI baud rate generation.
#define GetSystemClock()		(8000000ul)			// Hz
#define GetInstructionClock()	(GetSystemClock()/1)	// Normally GetSystemClock()/4 for PIC18, GetSystemClock()/2 for PIC24/dsPIC, and GetSystemClock()/1 for PIC32.  Might need changing if using Doze modes.
#define GetPeripheralClock()	(GetSystemClock()/1)	// Normally GetSystemClock()/4 for PIC18, GetSystemClock()/2 for PIC24/dsPIC, and GetSystemClock()/1 for PIC32.  Divisor may be different if using a PIC32 since it's configurable.


// Hardware I/O pin mappings

// LEDs
//#define LED0_TRIS			(TRISDbits.TRISD0)	// Ref LED1
//#define LED0_IO				(LATDbits.LATD0)
//#define LED1_TRIS			(TRISDbits.TRISD1)	// Ref LED2
//#define LED1_IO				(LATDbits.LATD1)
//#define LED2_TRIS			(TRISDbits.TRISD2)	// Ref LED3
//#define LED2_IO				(LATDbits.LATD2)
//#define LED3_TRIS			(LED2_TRIS)			// No such LED
//#define LED3_IO				(LATDbits.LATD6)
//#define LED4_TRIS			(LED2_TRIS)			// No such LED
//#define LED4_IO				(LATDbits.LATD6)
//#define LED5_TRIS			(LED2_TRIS)			// No such LED
//#define LED5_IO				(LATDbits.LATD6)
//#define LED6_TRIS			(LED2_TRIS)			// No such LED
//#define LED6_IO				(LATDbits.LATD6)
//#define LED7_TRIS			(LED2_TRIS)			// No such LED
//#define LED7_IO				(LATDbits.LATD6)
//#define LED_GET()			((unsigned char)LATD & 0x07)
//#define LED_PUT(a)			do{LATD = (LATD & 0xFFF8) | ((a)&0x07);}while(0)

// Momentary push buttons
//#define BUTTON0_TRIS		(TRISDbits.TRISD6)	// Ref SW1
//#define BUTTON0_IO			(PORTDbits.RD6)
//#define BUTTON1_TRIS		(TRISDbits.TRISD7)	// Ref SW2
//#define BUTTON1_IO			(PORTDbits.RD7)
//#define BUTTON2_TRIS		(TRISDbits.TRISD13)	// Ref SW3
//#define BUTTON2_IO			(PORTDbits.RD13)
//#define BUTTON3_TRIS		(TRISDbits.TRISD13)	// No BUTTON3 on this board
//#define BUTTON3_IO			(1)

// UART configuration (not too important since we don't have a UART
// connector attached normally, but needed to compile if the STACK_USE_UART
// or STACK_USE_UART2TCP_BRIDGE features are enabled.
#define UARTTX_TRIS			(TRISFbits.TRISF3)
#define UARTRX_TRIS			(TRISFbits.TRISF2)


// Specify which SPI to use for the ENC28J60 or ENC624J600.  SPI1 is
// the topmost slot with pin 1 on it.  SPI2 is the middle slot
// starting on pin 33.
#define ENC_IN_SPI1
//#define ENC_IN_SPI2

// Note that SPI1 cannot be used when using the PIC32 USB Starter
// Board or PIC32 USB Starter Kit II due to the USB peripheral pins
// mapping on top of the ordinary SPI1 pinout.
#if defined(ENC_IN_SPI1) && (defined(__32MX460F512L__) || defined(__32MX795F512L__))
	#undef ENC_IN_SPI1
	#define ENC_IN_SPI2
#endif


// ENC28J60 I/O pins
#define ENC_CS_TRIS			(TRISAbits.TRISA0)
#define ENC_CS_IO			(PORTAbits.RA0)
//#define ENC_RST_TRIS		(TRISDbits.TRISD15)	// Not connected by default.  It is okay to leave this pin completely unconnected, in which case this macro should simply be left undefined.
//#define ENC_RST_IO		(PORTDbits.RD15)

// SPI SCK, SDI, SDO pins are automatically controlled by the
#define ENC_SPI_IF		(IFS0bits.SPI1RXIF)
#define ENC_SSPBUF		(SPI1BUF)
#define ENC_SPICON1		(SPI1CON)
#define ENC_SPICON1bits		(SPI1CONbits)
#define ENC_SPIBRG		(SPI1BRG)
#define ENC_SPISTATbits		(SPI1STATbits)



#endif // #ifndef HARDWARE_PROFILE_H