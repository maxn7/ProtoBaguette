#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-XC32_PIC32MX150F128B.mk)" "nbproject/Makefile-local-XC32_PIC32MX150F128B.mk"
include nbproject/Makefile-local-XC32_PIC32MX150F128B.mk
endif
endif

# Environment
MKDIR=mkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=XC32_PIC32MX150F128B
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/66603954/IP.o ${OBJECTDIR}/_ext/66603954/ARP.o ${OBJECTDIR}/_ext/66603954/Tick.o ${OBJECTDIR}/_ext/66603954/Helpers.o ${OBJECTDIR}/_ext/66603954/ENC28J60.o ${OBJECTDIR}/_ext/66603954/Delay.o ${OBJECTDIR}/_ext/66603954/StackTsk.o ${OBJECTDIR}/_ext/66603954/DHCP.o ${OBJECTDIR}/_ext/66603954/SSL.o ${OBJECTDIR}/_ext/66603954/TCP.o ${OBJECTDIR}/_ext/66603954/UDP.o ${OBJECTDIR}/_ext/66603954/ARCFOUR.o ${OBJECTDIR}/_ext/66603954/DNS.o ${OBJECTDIR}/_ext/66603954/RSA.o ${OBJECTDIR}/_ext/66603954/Hashes.o ${OBJECTDIR}/_ext/66603954/Random.o ${OBJECTDIR}/_ext/66603954/BigInt.o ${OBJECTDIR}/configuration_bits.o ${OBJECTDIR}/exceptions.o ${OBJECTDIR}/interrupts.o ${OBJECTDIR}/main.o ${OBJECTDIR}/system.o ${OBJECTDIR}/user.o ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o ${OBJECTDIR}/_ext/66603954/websocket.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/66603954/IP.o.d ${OBJECTDIR}/_ext/66603954/ARP.o.d ${OBJECTDIR}/_ext/66603954/Tick.o.d ${OBJECTDIR}/_ext/66603954/Helpers.o.d ${OBJECTDIR}/_ext/66603954/ENC28J60.o.d ${OBJECTDIR}/_ext/66603954/Delay.o.d ${OBJECTDIR}/_ext/66603954/StackTsk.o.d ${OBJECTDIR}/_ext/66603954/DHCP.o.d ${OBJECTDIR}/_ext/66603954/SSL.o.d ${OBJECTDIR}/_ext/66603954/TCP.o.d ${OBJECTDIR}/_ext/66603954/UDP.o.d ${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d ${OBJECTDIR}/_ext/66603954/DNS.o.d ${OBJECTDIR}/_ext/66603954/RSA.o.d ${OBJECTDIR}/_ext/66603954/Hashes.o.d ${OBJECTDIR}/_ext/66603954/Random.o.d ${OBJECTDIR}/_ext/66603954/BigInt.o.d ${OBJECTDIR}/configuration_bits.o.d ${OBJECTDIR}/exceptions.o.d ${OBJECTDIR}/interrupts.o.d ${OBJECTDIR}/main.o.d ${OBJECTDIR}/system.o.d ${OBJECTDIR}/user.o.d ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d ${OBJECTDIR}/_ext/66603954/websocket.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/66603954/IP.o ${OBJECTDIR}/_ext/66603954/ARP.o ${OBJECTDIR}/_ext/66603954/Tick.o ${OBJECTDIR}/_ext/66603954/Helpers.o ${OBJECTDIR}/_ext/66603954/ENC28J60.o ${OBJECTDIR}/_ext/66603954/Delay.o ${OBJECTDIR}/_ext/66603954/StackTsk.o ${OBJECTDIR}/_ext/66603954/DHCP.o ${OBJECTDIR}/_ext/66603954/SSL.o ${OBJECTDIR}/_ext/66603954/TCP.o ${OBJECTDIR}/_ext/66603954/UDP.o ${OBJECTDIR}/_ext/66603954/ARCFOUR.o ${OBJECTDIR}/_ext/66603954/DNS.o ${OBJECTDIR}/_ext/66603954/RSA.o ${OBJECTDIR}/_ext/66603954/Hashes.o ${OBJECTDIR}/_ext/66603954/Random.o ${OBJECTDIR}/_ext/66603954/BigInt.o ${OBJECTDIR}/configuration_bits.o ${OBJECTDIR}/exceptions.o ${OBJECTDIR}/interrupts.o ${OBJECTDIR}/main.o ${OBJECTDIR}/system.o ${OBJECTDIR}/user.o ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o ${OBJECTDIR}/_ext/66603954/websocket.o


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE}  -f nbproject/Makefile-XC32_PIC32MX150F128B.mk dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX150F128B
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o: ../MCPTCPIP/src/BigInt_helper_PIC32.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d 
	@${RM} ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.ok ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d" "${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d"  -o ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o ../MCPTCPIP/src/BigInt_helper_PIC32.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.asm.d",--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1
	
else
${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o: ../MCPTCPIP/src/BigInt_helper_PIC32.S  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d 
	@${RM} ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.ok ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.err 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d" "${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.d"  -o ${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o ../MCPTCPIP/src/BigInt_helper_PIC32.S  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/_ext/66603954/BigInt_helper_PIC32.o.asm.d",--gdwarf-2
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/66603954/IP.o: ../MCPTCPIP/src/IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/IP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/IP.o.d" -o ${OBJECTDIR}/_ext/66603954/IP.o ../MCPTCPIP/src/IP.c   
	
${OBJECTDIR}/_ext/66603954/ARP.o: ../MCPTCPIP/src/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/ARP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/ARP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/ARP.o.d" -o ${OBJECTDIR}/_ext/66603954/ARP.o ../MCPTCPIP/src/ARP.c   
	
${OBJECTDIR}/_ext/66603954/Tick.o: ../MCPTCPIP/src/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Tick.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Tick.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Tick.o.d" -o ${OBJECTDIR}/_ext/66603954/Tick.o ../MCPTCPIP/src/Tick.c   
	
${OBJECTDIR}/_ext/66603954/Helpers.o: ../MCPTCPIP/src/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Helpers.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Helpers.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Helpers.o.d" -o ${OBJECTDIR}/_ext/66603954/Helpers.o ../MCPTCPIP/src/Helpers.c   
	
${OBJECTDIR}/_ext/66603954/ENC28J60.o: ../MCPTCPIP/src/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/ENC28J60.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/ENC28J60.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/ENC28J60.o.d" -o ${OBJECTDIR}/_ext/66603954/ENC28J60.o ../MCPTCPIP/src/ENC28J60.c   
	
${OBJECTDIR}/_ext/66603954/Delay.o: ../MCPTCPIP/src/Delay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Delay.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Delay.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Delay.o.d" -o ${OBJECTDIR}/_ext/66603954/Delay.o ../MCPTCPIP/src/Delay.c   
	
${OBJECTDIR}/_ext/66603954/StackTsk.o: ../MCPTCPIP/src/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/StackTsk.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/StackTsk.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/StackTsk.o.d" -o ${OBJECTDIR}/_ext/66603954/StackTsk.o ../MCPTCPIP/src/StackTsk.c   
	
${OBJECTDIR}/_ext/66603954/DHCP.o: ../MCPTCPIP/src/DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/DHCP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/DHCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/DHCP.o.d" -o ${OBJECTDIR}/_ext/66603954/DHCP.o ../MCPTCPIP/src/DHCP.c   
	
${OBJECTDIR}/_ext/66603954/SSL.o: ../MCPTCPIP/src/SSL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/SSL.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/SSL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/SSL.o.d" -o ${OBJECTDIR}/_ext/66603954/SSL.o ../MCPTCPIP/src/SSL.c   
	
${OBJECTDIR}/_ext/66603954/TCP.o: ../MCPTCPIP/src/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/TCP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/TCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/TCP.o.d" -o ${OBJECTDIR}/_ext/66603954/TCP.o ../MCPTCPIP/src/TCP.c   
	
${OBJECTDIR}/_ext/66603954/UDP.o: ../MCPTCPIP/src/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/UDP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/UDP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/UDP.o.d" -o ${OBJECTDIR}/_ext/66603954/UDP.o ../MCPTCPIP/src/UDP.c   
	
${OBJECTDIR}/_ext/66603954/ARCFOUR.o: ../MCPTCPIP/src/ARCFOUR.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d" -o ${OBJECTDIR}/_ext/66603954/ARCFOUR.o ../MCPTCPIP/src/ARCFOUR.c   
	
${OBJECTDIR}/_ext/66603954/DNS.o: ../MCPTCPIP/src/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/DNS.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/DNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/DNS.o.d" -o ${OBJECTDIR}/_ext/66603954/DNS.o ../MCPTCPIP/src/DNS.c   
	
${OBJECTDIR}/_ext/66603954/RSA.o: ../MCPTCPIP/src/RSA.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/RSA.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/RSA.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/RSA.o.d" -o ${OBJECTDIR}/_ext/66603954/RSA.o ../MCPTCPIP/src/RSA.c   
	
${OBJECTDIR}/_ext/66603954/Hashes.o: ../MCPTCPIP/src/Hashes.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Hashes.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Hashes.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Hashes.o.d" -o ${OBJECTDIR}/_ext/66603954/Hashes.o ../MCPTCPIP/src/Hashes.c   
	
${OBJECTDIR}/_ext/66603954/Random.o: ../MCPTCPIP/src/Random.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Random.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Random.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Random.o.d" -o ${OBJECTDIR}/_ext/66603954/Random.o ../MCPTCPIP/src/Random.c   
	
${OBJECTDIR}/_ext/66603954/BigInt.o: ../MCPTCPIP/src/BigInt.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/BigInt.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/BigInt.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/BigInt.o.d" -o ${OBJECTDIR}/_ext/66603954/BigInt.o ../MCPTCPIP/src/BigInt.c   
	
${OBJECTDIR}/configuration_bits.o: configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/configuration_bits.o.d 
	@${FIXDEPS} "${OBJECTDIR}/configuration_bits.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/configuration_bits.o.d" -o ${OBJECTDIR}/configuration_bits.o configuration_bits.c   
	
${OBJECTDIR}/exceptions.o: exceptions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/exceptions.o.d 
	@${FIXDEPS} "${OBJECTDIR}/exceptions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/exceptions.o.d" -o ${OBJECTDIR}/exceptions.o exceptions.c   
	
${OBJECTDIR}/interrupts.o: interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/interrupts.o.d 
	@${FIXDEPS} "${OBJECTDIR}/interrupts.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/interrupts.o.d" -o ${OBJECTDIR}/interrupts.o interrupts.c   
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${FIXDEPS} "${OBJECTDIR}/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/main.o.d" -o ${OBJECTDIR}/main.o main.c   
	
${OBJECTDIR}/system.o: system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${FIXDEPS} "${OBJECTDIR}/system.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/system.o.d" -o ${OBJECTDIR}/system.o system.c   
	
${OBJECTDIR}/user.o: user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/user.o.d 
	@${FIXDEPS} "${OBJECTDIR}/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/user.o.d" -o ${OBJECTDIR}/user.o user.c   
	
${OBJECTDIR}/_ext/66603954/websocket.o: ../MCPTCPIP/src/websocket.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/websocket.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/websocket.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/websocket.o.d" -o ${OBJECTDIR}/_ext/66603954/websocket.o ../MCPTCPIP/src/websocket.c   
	
else
${OBJECTDIR}/_ext/66603954/IP.o: ../MCPTCPIP/src/IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/IP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/IP.o.d" -o ${OBJECTDIR}/_ext/66603954/IP.o ../MCPTCPIP/src/IP.c   
	
${OBJECTDIR}/_ext/66603954/ARP.o: ../MCPTCPIP/src/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/ARP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/ARP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/ARP.o.d" -o ${OBJECTDIR}/_ext/66603954/ARP.o ../MCPTCPIP/src/ARP.c   
	
${OBJECTDIR}/_ext/66603954/Tick.o: ../MCPTCPIP/src/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Tick.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Tick.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Tick.o.d" -o ${OBJECTDIR}/_ext/66603954/Tick.o ../MCPTCPIP/src/Tick.c   
	
${OBJECTDIR}/_ext/66603954/Helpers.o: ../MCPTCPIP/src/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Helpers.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Helpers.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Helpers.o.d" -o ${OBJECTDIR}/_ext/66603954/Helpers.o ../MCPTCPIP/src/Helpers.c   
	
${OBJECTDIR}/_ext/66603954/ENC28J60.o: ../MCPTCPIP/src/ENC28J60.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/ENC28J60.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/ENC28J60.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/ENC28J60.o.d" -o ${OBJECTDIR}/_ext/66603954/ENC28J60.o ../MCPTCPIP/src/ENC28J60.c   
	
${OBJECTDIR}/_ext/66603954/Delay.o: ../MCPTCPIP/src/Delay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Delay.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Delay.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Delay.o.d" -o ${OBJECTDIR}/_ext/66603954/Delay.o ../MCPTCPIP/src/Delay.c   
	
${OBJECTDIR}/_ext/66603954/StackTsk.o: ../MCPTCPIP/src/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/StackTsk.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/StackTsk.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/StackTsk.o.d" -o ${OBJECTDIR}/_ext/66603954/StackTsk.o ../MCPTCPIP/src/StackTsk.c   
	
${OBJECTDIR}/_ext/66603954/DHCP.o: ../MCPTCPIP/src/DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/DHCP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/DHCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/DHCP.o.d" -o ${OBJECTDIR}/_ext/66603954/DHCP.o ../MCPTCPIP/src/DHCP.c   
	
${OBJECTDIR}/_ext/66603954/SSL.o: ../MCPTCPIP/src/SSL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/SSL.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/SSL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/SSL.o.d" -o ${OBJECTDIR}/_ext/66603954/SSL.o ../MCPTCPIP/src/SSL.c   
	
${OBJECTDIR}/_ext/66603954/TCP.o: ../MCPTCPIP/src/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/TCP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/TCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/TCP.o.d" -o ${OBJECTDIR}/_ext/66603954/TCP.o ../MCPTCPIP/src/TCP.c   
	
${OBJECTDIR}/_ext/66603954/UDP.o: ../MCPTCPIP/src/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/UDP.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/UDP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/UDP.o.d" -o ${OBJECTDIR}/_ext/66603954/UDP.o ../MCPTCPIP/src/UDP.c   
	
${OBJECTDIR}/_ext/66603954/ARCFOUR.o: ../MCPTCPIP/src/ARCFOUR.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/ARCFOUR.o.d" -o ${OBJECTDIR}/_ext/66603954/ARCFOUR.o ../MCPTCPIP/src/ARCFOUR.c   
	
${OBJECTDIR}/_ext/66603954/DNS.o: ../MCPTCPIP/src/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/DNS.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/DNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/DNS.o.d" -o ${OBJECTDIR}/_ext/66603954/DNS.o ../MCPTCPIP/src/DNS.c   
	
${OBJECTDIR}/_ext/66603954/RSA.o: ../MCPTCPIP/src/RSA.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/RSA.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/RSA.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/RSA.o.d" -o ${OBJECTDIR}/_ext/66603954/RSA.o ../MCPTCPIP/src/RSA.c   
	
${OBJECTDIR}/_ext/66603954/Hashes.o: ../MCPTCPIP/src/Hashes.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Hashes.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Hashes.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Hashes.o.d" -o ${OBJECTDIR}/_ext/66603954/Hashes.o ../MCPTCPIP/src/Hashes.c   
	
${OBJECTDIR}/_ext/66603954/Random.o: ../MCPTCPIP/src/Random.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/Random.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/Random.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/Random.o.d" -o ${OBJECTDIR}/_ext/66603954/Random.o ../MCPTCPIP/src/Random.c   
	
${OBJECTDIR}/_ext/66603954/BigInt.o: ../MCPTCPIP/src/BigInt.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/BigInt.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/BigInt.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/BigInt.o.d" -o ${OBJECTDIR}/_ext/66603954/BigInt.o ../MCPTCPIP/src/BigInt.c   
	
${OBJECTDIR}/configuration_bits.o: configuration_bits.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/configuration_bits.o.d 
	@${FIXDEPS} "${OBJECTDIR}/configuration_bits.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/configuration_bits.o.d" -o ${OBJECTDIR}/configuration_bits.o configuration_bits.c   
	
${OBJECTDIR}/exceptions.o: exceptions.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/exceptions.o.d 
	@${FIXDEPS} "${OBJECTDIR}/exceptions.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/exceptions.o.d" -o ${OBJECTDIR}/exceptions.o exceptions.c   
	
${OBJECTDIR}/interrupts.o: interrupts.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/interrupts.o.d 
	@${FIXDEPS} "${OBJECTDIR}/interrupts.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/interrupts.o.d" -o ${OBJECTDIR}/interrupts.o interrupts.c   
	
${OBJECTDIR}/main.o: main.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/main.o.d 
	@${FIXDEPS} "${OBJECTDIR}/main.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/main.o.d" -o ${OBJECTDIR}/main.o main.c   
	
${OBJECTDIR}/system.o: system.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/system.o.d 
	@${FIXDEPS} "${OBJECTDIR}/system.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/system.o.d" -o ${OBJECTDIR}/system.o system.c   
	
${OBJECTDIR}/user.o: user.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR} 
	@${RM} ${OBJECTDIR}/user.o.d 
	@${FIXDEPS} "${OBJECTDIR}/user.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/user.o.d" -o ${OBJECTDIR}/user.o user.c   
	
${OBJECTDIR}/_ext/66603954/websocket.o: ../MCPTCPIP/src/websocket.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/_ext/66603954 
	@${RM} ${OBJECTDIR}/_ext/66603954/websocket.o.d 
	@${FIXDEPS} "${OBJECTDIR}/_ext/66603954/websocket.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"../picClient.X" -I"../MCPTCPIP/inc" -MMD -MF "${OBJECTDIR}/_ext/66603954/websocket.o.d" -o ${OBJECTDIR}/_ext/66603954/websocket.o ../MCPTCPIP/src/websocket.c   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mdebugger -D__MPLAB_DEBUGGER_PK3=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION)
	${MP_CC_DIR}/xc32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/picClient.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/XC32_PIC32MX150F128B
	${RM} -r dist/XC32_PIC32MX150F128B

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell "${PATH_TO_IDE_BIN}"mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
