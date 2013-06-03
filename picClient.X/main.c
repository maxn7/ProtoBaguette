/******************************************************************************/
/*  Files to Include                                                          */
/******************************************************************************/
#ifdef __XC32
    #include <xc.h>      /* Defines special funciton registers, CP0 regs  */
#endif

#include <plib.h>           /* Include to use PIC32 peripheral libraries      */
#include <stdint.h>         /* For uint32_t definition                        */
#include <stdbool.h>        /* For true/false definition                      */

#include "system.h"         /* System funct/params, like osc/periph config    */
#include "user.h"           /* User funct/params, such as InitApp             */

//TCPIP stack 
#include "HardwareProfile.h"
#include "TCPIP.h"

static void BakeBaguette(void);
static void InitAppConfig(void);

/******************************************************************************/
/* Global Variable Declaration                                                */
/******************************************************************************/
APP_CONFIG AppConfig;
/* i.e. uint32_t <variable_name>; */

/******************************************************************************/
/* Main Program                                                               */
/******************************************************************************/

int32_t main(void)
{


    /*Refer to the C32 peripheral library documentation for more
    information on the SYTEMConfig function.
    
    This function sets the PB divider, the Flash Wait States, and the DRM
    /wait states to the optimum value.  It also enables the cacheability for
    the K0 segment.  It could has side effects of possibly alter the pre-fetch
    buffer and cache.  It sets the RAM wait states to 0.  Other than
    the SYS_FREQ, this takes these parameters.  The top 3 may be '|'ed
    together:
    
    SYS_CFG_WAIT_STATES (configures flash wait states from system clock)
    SYS_CFG_PB_BUS (configures the PB bus from the system clock)
    SYS_CFG_PCACHE (configures the pCache if used)
    SYS_CFG_ALL (configures the flash wait states, PB bus, and pCache)*/

    /* TODO Add user clock/system configuration code if appropriate.  */
    SYSTEMConfig(SYS_FREQ, SYS_CFG_ALL); 

    /* Initialize I/O and Peripherals for application */
    InitApp();
    InitAppConfig();

    /*Configure Multivector Interrupt Mode.  Using Single Vector Mode
    is expensive from a timing perspective, so most applications
    should probably not use a Single Vector Mode*/
    INTConfigureSystem(INT_SYSTEM_CONFIG_MULT_VECTOR);


    StackInit();

    // Now that all items are initialized, begin the co-operative
    // multitasking loop.  This infinite loop will continuously
    // execute all stack-related tasks, as well as your own
    // application's functions.  Custom functions should be added
    // at the end of this loop.
    // Note that this is a "co-operative mult-tasking" mechanism
    // where every task performs its tasks (whether all in one shot
    // or part of it) and returns so that other tasks can do their
    // job.
    // If a task needs very long time to do its job, it must be broken
    // down into smaller pieces so that other tasks can have CPU time.
    while(1)
    {
        // This task performs normal stack task including checking
        // for incoming packet, type of packet and calling
        // appropriate stack entity to process it.
        StackTask();

        StackApplications();

        BakeBaguette();
    }


    /*while(1)
    {
        mPORTAToggleBits(BIT_0);
        putsUART1("Hello World! \n");
        
        Delay10us(50000);

    }*/
}


enum baguette_states {
    BAGUETTE_INIT,
    BAGUETTE_CONNECT,
    BAGUETTE_WORK,
    BAGUETTE_IDLE
};

static BYTE ServerName[] = "dallens.fr";

// TODO : dallens.fr key is 2048 bit long and exceeds the 1024 limit.
//#ifdef STACK_USE_SSL_CLIENT
//    static WORD ServerPort = HTTPS_PORT;
//	// Note that if HTTPS is used, the ServerName and URL
//	// must change to an SSL enabled server.
//#else
static WORD ServerPort = 80;
//#endif

// Defines the URL to be requested by this HTTP client
static ROM BYTE RemoteURL[] = "/ping.txt";


static void BakeBaguette(void)
{
    static int        state = BAGUETTE_INIT;
    static TCP_SOCKET sock;
    static DWORD      timer;

    // Pour tester lancer "nc -lv <port>" sur boxxy et attendre une connexion.
    switch (state) {
        case BAGUETTE_INIT:
            sock = TCPOpen((DWORD)(PTR_BASE)&ServerName[0], TCP_OPEN_RAM_HOST, ServerPort, TCP_PURPOSE_BAGUETTE);

            if (sock == INVALID_SOCKET) {
                putsUART1((ROM char*)"# Invalid socket\r\n");
                break;
            }

            putsUART1((ROM char*)"Connecting...\r\n");
            state = BAGUETTE_CONNECT;
            timer = TickGet();
            break;

        case BAGUETTE_CONNECT:
            // Wait for the remote server to accept our connection request
            if (!TCPIsConnected(sock)) {
                // Time out if too much time is spent in this state
                if (TickGet() - timer > 5 * TICK_SECOND) {
                    // Close the socket so it can be used by other modules
                    TCPDisconnect(sock);
                    sock = INVALID_SOCKET;
                    state = BAGUETTE_INIT;
                }
                break;
            }

//#ifdef STACK_USE_SSL_CLIENT
//            if(!TCPStartSSLClient(MySocket, (void *)"thishost"))
//                break;
//            ...
//#endif

            // Make certain the socket can be written to
            //if (TCPIsPutReady(sock) < 200u)
            //        break;

            // Fill the transmit buffer.
            TCPPutROMString(sock, (ROM BYTE*)"GET ");
            TCPPutROMString(sock, RemoteURL);
            TCPPutROMString(sock, (ROM BYTE*)" HTTP/1.0\r\nHost: ");
            TCPPutString(sock, ServerName);
            TCPPutROMString(sock, (ROM BYTE*)"\r\nConnection: close\r\n\r\n");

            // Send the packet
            TCPFlush(sock);

            putsUART1((ROM char*)"Sending request...\r\n");
            state = BAGUETTE_WORK;
            break;

        case BAGUETTE_WORK:
            Nop();
            
            // Get count of RX bytes waiting
            int w = TCPIsGetReady(sock);
            BYTE vBuffer[9];

            // Obtain and print the server reply
            int i = sizeof(vBuffer) - 1;
            vBuffer[i] = '\0';
            while(w) {
                if(w < i) {
                    i = w;
                    vBuffer[i] = '\0';
                }
                w -= TCPGetArray(sock, vBuffer, i);
                putsUART1((char*)vBuffer);
            }

            while(BusyUART1());
            WriteUART1('#');
            while(BusyUART1());

            // Check to see if the remote node has disconnected from us
            if (!TCPIsConnected(sock)) {
                putsUART1((ROM char*)"# Disconnected\r\n");
                state = BAGUETTE_IDLE;
            }
            break;

        case BAGUETTE_IDLE:
            break;

        default:
            putsUART1((ROM char*)"# Unexpected state\r\n");
            break;
    }
}


// MAC Address Serialization using a MPLAB PM3 Programmer and
// Serialized Quick Turn Programming (SQTP).
// The advantage of using SQTP for programming the MAC Address is it
// allows you to auto-increment the MAC address without recompiling
// the code for each unit.  To use SQTP, the MAC address must be fixed
// at a specific location in program memory.  Uncomment these two pragmas
// that locate the MAC address at 0x1FFF0.  Syntax below is for MPLAB C
// Compiler for PIC18 MCUs. Syntax will vary for other compilers.
//#pragma romdata MACROM=0x1FFF0
static ROM BYTE SerializedMACAddress[6] = {MY_DEFAULT_MAC_BYTE1, MY_DEFAULT_MAC_BYTE2, MY_DEFAULT_MAC_BYTE3, MY_DEFAULT_MAC_BYTE4, MY_DEFAULT_MAC_BYTE5, MY_DEFAULT_MAC_BYTE6};
//#pragma romdata
static void InitAppConfig(void)
{

        // Start out zeroing all AppConfig bytes to ensure all fields are
        // deterministic for checksum generation
        memset((void*)&AppConfig, 0x00, sizeof(AppConfig));


        AppConfig.MyIPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 | MY_DEFAULT_IP_ADDR_BYTE2<<8ul | MY_DEFAULT_IP_ADDR_BYTE3<<16ul | MY_DEFAULT_IP_ADDR_BYTE4<<24ul;
        AppConfig.MyMask.Val = MY_DEFAULT_MASK_BYTE1 | MY_DEFAULT_MASK_BYTE2<<8ul | MY_DEFAULT_MASK_BYTE3<<16ul | MY_DEFAULT_MASK_BYTE4<<24ul;
        AppConfig.MyGateway.Val = MY_DEFAULT_GATE_BYTE1 | MY_DEFAULT_GATE_BYTE2<<8ul | MY_DEFAULT_GATE_BYTE3<<16ul | MY_DEFAULT_GATE_BYTE4<<24ul;
        AppConfig.PrimaryDNSServer.Val = MY_DEFAULT_PRIMARY_DNS_BYTE1 | MY_DEFAULT_PRIMARY_DNS_BYTE2<<8ul  | MY_DEFAULT_PRIMARY_DNS_BYTE3<<16ul  | MY_DEFAULT_PRIMARY_DNS_BYTE4<<24ul;
        AppConfig.SecondaryDNSServer.Val = MY_DEFAULT_SECONDARY_DNS_BYTE1 | MY_DEFAULT_SECONDARY_DNS_BYTE2<<8ul  | MY_DEFAULT_SECONDARY_DNS_BYTE3<<16ul  | MY_DEFAULT_SECONDARY_DNS_BYTE4<<24ul;
        AppConfig.DefaultIPAddr.Val = AppConfig.MyIPAddr.Val;
        AppConfig.DefaultMask.Val = AppConfig.MyMask.Val;
        memcpypgm2ram(AppConfig.NetBIOSName, (ROM void*)MY_DEFAULT_HOST_NAME, 16);
        AppConfig.Flags.bIsDHCPEnabled = TRUE;
        AppConfig.Flags.bInConfigMode = TRUE;
        memcpypgm2ram((void*)&AppConfig.MyMACAddr, (ROM void*)SerializedMACAddress, sizeof(AppConfig.MyMACAddr));
        AppConfig.MyMACAddr.v[0] = MY_DEFAULT_MAC_BYTE6;
}