EESchema Schematic File Version 2  date mer. 29 mai 2013 21:37:41 CEST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:protoBaguette
LIBS:valves
LIBS:protoBaguette-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title "Alpha prototype"
Date "29 may 2013"
Rev "0.1"
Comp "ProtoBaguette"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L PIC32MX150F128-1 U?
U 1 1 51A65900
P 3400 2950
F 0 "U?" H 3425 3650 60  0000 C CNN
F 1 "PIC32MX150F128-1" H 3475 1700 60  0000 C CNN
	1    3400 2950
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 519A849C
P 1050 6350
F 0 "R?" V 1050 6450 50  0000 C CNN
F 1 "49.9" V 1050 6300 50  0000 C CNN
	1    1050 6350
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 519A8498
P 1050 6150
F 0 "R?" V 1050 6250 50  0000 C CNN
F 1 "49.9" V 1050 6100 50  0000 C CNN
	1    1050 6150
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 519A8495
P 1050 6050
F 0 "R?" V 1050 6150 50  0000 C CNN
F 1 "49.9" V 1050 6000 50  0000 C CNN
	1    1050 6050
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR?
U 1 1 519A8426
P 9150 5150
F 0 "#PWR?" H 9150 5150 30  0001 C CNN
F 1 "GND" H 9150 5080 30  0001 C CNN
	1    9150 5150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 5150 9150 5050
Wire Wire Line
	7650 5050 7650 5050
Wire Wire Line
	7650 5050 7950 5050
Wire Wire Line
	7950 4550 7950 4050
Wire Wire Line
	7950 4050 8350 4050
Wire Wire Line
	1300 2700 1750 2700
Wire Wire Line
	1400 2850 1400 2500
Wire Wire Line
	1400 2500 1300 2500
Wire Wire Line
	1300 2300 1750 2300
Wire Wire Line
	5100 3150 4800 3150
Wire Wire Line
	4800 2950 5100 2950
Wire Wire Line
	7250 2850 7250 2950
Wire Wire Line
	4100 6750 4100 7400
Wire Bus Line
	4350 5000 4350 7650
Wire Bus Line
	4350 7650 600  7650
Wire Wire Line
	2300 6450 2400 6450
Wire Wire Line
	800  6750 1150 6750
Wire Wire Line
	2300 6850 2400 6850
Wire Wire Line
	1650 6750 2400 6750
Wire Wire Line
	2300 6650 2400 6650
Wire Wire Line
	1750 7000 1750 6250
Wire Wire Line
	1750 6250 800  6250
Wire Wire Line
	2400 5950 2100 5950
Wire Wire Line
	2100 5950 800  5950
Wire Wire Line
	2100 5200 2100 5350
Wire Wire Line
	2100 7000 2100 5950
Wire Wire Line
	800  5850 800  5950
Wire Wire Line
	800  5950 800  6050
Connection ~ 7100 1400
Wire Wire Line
	6400 1400 7100 1400
Wire Wire Line
	7100 1400 7800 1400
Wire Notes Line
	8500 650  6000 650 
Wire Wire Line
	7100 1550 7100 1400
Wire Wire Line
	7100 900  7100 1000
Wire Notes Line
	8500 650  8500 1700
Wire Notes Line
	8500 1700 6000 1700
Wire Notes Line
	6000 1700 6000 650 
Wire Notes Line
	2900 1700 2900 650 
Wire Notes Line
	2900 1700 5400 1700
Wire Notes Line
	5400 1700 5400 650 
Wire Wire Line
	9950 4200 10200 4200
Wire Wire Line
	7350 3750 7150 3750
Wire Wire Line
	9950 3300 10200 3300
Wire Wire Line
	9950 3050 10200 3050
Wire Wire Line
	9350 5050 9150 5050
Wire Wire Line
	9150 5050 8950 5050
Wire Wire Line
	9400 2350 9200 2350
Wire Wire Line
	9200 2350 9000 2350
Wire Wire Line
	3100 900  3100 1000
Wire Wire Line
	3100 1000 5050 1000
Wire Wire Line
	1350 900  1350 1050
Wire Wire Line
	1350 1050 1300 1050
Wire Wire Line
	1300 1150 1650 1150
Wire Wire Line
	7150 3350 8350 3350
Wire Wire Line
	7150 3550 8350 3550
Wire Wire Line
	8350 3450 7150 3450
Wire Wire Line
	7150 3250 8350 3250
Wire Wire Line
	1650 1250 1300 1250
Wire Wire Line
	1300 1350 1350 1350
Wire Wire Line
	7250 2950 7150 2950
Wire Wire Line
	1350 1350 1350 1600
Wire Notes Line
	650  650  1850 650 
Wire Notes Line
	1850 650  1850 1700
Wire Notes Line
	1850 1700 600  1700
Wire Notes Line
	600  1700 600  650 
Wire Notes Line
	600  650  700  650 
Wire Wire Line
	5050 1400 3300 1400
Wire Wire Line
	3300 1400 3100 1400
Wire Wire Line
	3100 1400 3100 1500
Connection ~ 3300 1400
Wire Notes Line
	5400 650  2900 650 
Wire Wire Line
	9200 2250 9200 2350
Connection ~ 9200 2350
Wire Wire Line
	7800 5150 7800 5050
Connection ~ 9150 5050
Wire Wire Line
	10200 3150 9950 3150
Wire Wire Line
	9950 3400 10200 3400
Wire Wire Line
	7350 3850 7150 3850
Wire Wire Line
	9950 4300 10200 4300
Wire Wire Line
	6400 1000 7100 1000
Wire Wire Line
	7100 1000 7800 1000
Connection ~ 7100 1000
Wire Wire Line
	1750 7500 1750 7400
Connection ~ 800  5950
Connection ~ 2100 5950
Wire Wire Line
	1300 5850 2400 5850
Wire Wire Line
	1300 6050 2400 6050
Wire Wire Line
	1300 6350 2400 6350
Wire Wire Line
	1300 6150 2400 6150
Connection ~ 800  6250
Wire Wire Line
	800  6350 800  6250
Wire Wire Line
	800  6250 800  6150
Wire Wire Line
	2100 7500 2100 7400
Wire Wire Line
	2400 6550 1650 6550
Wire Wire Line
	1150 6550 800  6550
Wire Notes Line
	600  7650 600  5000
Wire Notes Line
	600  5000 4350 5000
Wire Wire Line
	7150 3050 7250 3050
Wire Wire Line
	7250 3050 7250 3100
Wire Wire Line
	5100 3050 4800 3050
Wire Notes Line
	700  1950 600  1950
Wire Notes Line
	600  1950 600  3000
Wire Notes Line
	600  3000 1850 3000
Wire Notes Line
	1850 3000 1850 1950
Wire Notes Line
	1850 1950 650  1950
Wire Wire Line
	1300 2400 1400 2400
Wire Wire Line
	1400 2400 1400 2150
Wire Wire Line
	1300 2600 1750 2600
Wire Wire Line
	5050 2450 5050 2350
Wire Wire Line
	7650 4650 7650 3850
Wire Wire Line
	7650 3850 8350 3850
$Comp
L C C?
U 1 1 519A8409
P 7650 4850
F 0 "C?" H 7700 4950 50  0000 L CNN
F 1 "10u" H 7700 4750 50  0000 L CNN
	1    7650 4850
	-1   0    0    1   
$EndComp
$Comp
L R R?
U 1 1 519A8400
P 7950 4800
F 0 "R?" H 7800 4750 50  0000 C CNN
F 1 "2.32k, 1%" H 7700 4850 50  0000 C CNN
	1    7950 4800
	-1   0    0    1   
$EndComp
$Comp
L VDD #PWR?
U 1 1 519A8384
P 5050 2350
F 0 "#PWR?" H 5050 2450 30  0001 C CNN
F 1 "VDD" H 5050 2460 30  0000 C CNN
	1    5050 2350
	1    0    0    -1  
$EndComp
$Comp
L R R?
U 1 1 519A8376
P 5050 2700
F 0 "R?" H 4900 2650 50  0000 C CNN
F 1 "10k" H 4900 2750 50  0000 C CNN
	1    5050 2700
	-1   0    0    1   
$EndComp
Text Label 1550 2300 0    60   ~ 0
RST
Text Label 1550 2700 0    60   ~ 0
PGC
Text Label 1550 2600 0    60   ~ 0
PGD
$Comp
L HEADER_5 P?
U 1 1 519A8178
P 900 2500
F 0 "P?" V 850 2500 50  0000 C CNN
F 1 "HEADER_5" V 950 2500 50  0000 C CNN
	1    900  2500
	-1   0    0    -1  
$EndComp
Text Notes 600  1950 0    60   ~ 0
Microchip ICSP
$Comp
L VDD #PWR?
U 1 1 519A81F2
P 1400 2150
F 0 "#PWR?" H 1400 2250 30  0001 C CNN
F 1 "VDD" H 1400 2260 30  0000 C CNN
	1    1400 2150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 519A80F8
P 1400 2850
F 0 "#PWR?" H 1400 2850 30  0001 C CNN
F 1 "GND" H 1400 2780 30  0001 C CNN
	1    1400 2850
	1    0    0    -1  
$EndComp
Text Label 4800 3150 0    60   ~ 0
PGD
Text Label 4800 3050 0    60   ~ 0
PGC
Text Label 4800 2950 0    60   ~ 0
RST
$Comp
L VDD #PWR?
U 1 1 519A80AD
P 7250 2850
F 0 "#PWR?" H 7250 2950 30  0001 C CNN
F 1 "VDD" H 7250 2960 30  0000 C CNN
	1    7250 2850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 519A80AA
P 7250 3100
F 0 "#PWR?" H 7250 3100 30  0001 C CNN
F 1 "GND" H 7250 3030 30  0001 C CNN
	1    7250 3100
	1    0    0    -1  
$EndComp
Text Notes 9200 800  0    60   ~ 0
TODO : \n- regulator ?\n- Clock\n- Controller reset\n
$Comp
L GND #PWR?
U 1 1 519A75C8
P 4100 7400
F 0 "#PWR?" H 4100 7400 30  0001 C CNN
F 1 "GND" H 4100 7330 30  0001 C CNN
	1    4100 7400
	1    0    0    -1  
$EndComp
Text Notes 600  5000 0    60   ~ 0
User ETHERNET SOCKET
$Comp
L GND #PWR?
U 1 1 519A7550
P 2300 6450
F 0 "#PWR?" H 2300 6450 30  0001 C CNN
F 1 "GND" H 2300 6380 30  0001 C CNN
	1    2300 6450
	0    1    1    0   
$EndComp
Text Label 800  6750 0    60   ~ 0
LEDB
Text Label 800  6550 0    60   ~ 0
LEDA
$Comp
L GND #PWR?
U 1 1 519A74FC
P 2300 6850
F 0 "#PWR?" H 2300 6850 30  0001 C CNN
F 1 "GND" H 2300 6780 30  0001 C CNN
	1    2300 6850
	0    1    1    0   
$EndComp
$Comp
L GND #PWR?
U 1 1 519A74EF
P 2300 6650
F 0 "#PWR?" H 2300 6650 30  0001 C CNN
F 1 "GND" H 2300 6580 30  0001 C CNN
	1    2300 6650
	0    1    1    0   
$EndComp
$Comp
L R R?
U 1 1 519A74D4
P 1400 6750
F 0 "R?" V 1400 6850 50  0000 C CNN
F 1 "330" V 1400 6700 50  0000 C CNN
	1    1400 6750
	0    -1   -1   0   
$EndComp
$Comp
L R R?
U 1 1 519A74CE
P 1400 6550
F 0 "R?" V 1400 6650 50  0000 C CNN
F 1 "330" V 1400 6500 50  0000 C CNN
	1    1400 6550
	0    -1   -1   0   
$EndComp
$Comp
L C C?
U 1 1 519A737C
P 2100 7200
F 0 "C?" H 2150 7300 50  0000 L CNN
F 1 "100n" H 2150 7100 50  0000 L CNN
	1    2100 7200
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR?
U 1 1 519A737B
P 2100 7500
F 0 "#PWR?" H 2100 7500 30  0001 C CNN
F 1 "GND" H 2100 7430 30  0001 C CNN
	1    2100 7500
	1    0    0    -1  
$EndComp
Text Label 1450 6150 0    60   ~ 0
TPI+
Text Label 1450 6350 0    60   ~ 0
TPI-
Text Label 1450 6050 0    60   ~ 0
TPO-
Text Label 1450 5850 0    60   ~ 0
TPO+
$Comp
L INDUCTOR L?
U 1 1 519A724C
P 2100 5650
F 0 "L?" V 2050 5650 40  0000 C CNN
F 1 "INDUCTOR" V 2200 5650 40  0000 C CNN
	1    2100 5650
	-1   0    0    1   
$EndComp
$Comp
L R R?
U 1 1 519A723A
P 1050 5850
F 0 "R?" V 1050 5950 50  0000 C CNN
F 1 "49.9" V 1050 5800 50  0000 C CNN
	1    1050 5850
	0    -1   -1   0   
$EndComp
$Comp
L VDD #PWR?
U 1 1 519A7084
P 2100 5200
F 0 "#PWR?" H 2100 5300 30  0001 C CNN
F 1 "VDD" H 2100 5310 30  0000 C CNN
	1    2100 5200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 519A7081
P 1750 7500
F 0 "#PWR?" H 1750 7500 30  0001 C CNN
F 1 "GND" H 1750 7430 30  0001 C CNN
	1    1750 7500
	1    0    0    -1  
$EndComp
$Comp
L C C?
U 1 1 519A7052
P 1750 7200
F 0 "C?" H 1800 7300 50  0000 L CNN
F 1 "100n" H 1800 7100 50  0000 L CNN
	1    1750 7200
	-1   0    0    1   
$EndComp
$Comp
L C Cosc1
U 1 1 519A6DAC
P 7800 1200
F 0 "Cosc1" H 7850 1300 50  0000 L CNN
F 1 "100n" H 7850 1100 50  0000 L CNN
	1    7800 1200
	1    0    0    -1  
$EndComp
$Comp
L C Cvdd2
U 1 1 519A6DAF
P 6400 1200
F 0 "Cvdd2" H 6450 1300 50  0000 L CNN
F 1 "100n" H 6450 1100 50  0000 L CNN
	1    6400 1200
	1    0    0    -1  
$EndComp
$Comp
L C Ctx2
U 1 1 519A6DAE
P 6750 1200
F 0 "Ctx2" H 6800 1300 50  0000 L CNN
F 1 "100n" H 6800 1100 50  0000 L CNN
	1    6750 1200
	1    0    0    -1  
$EndComp
$Comp
L C Crx2
U 1 1 519A6DAD
P 7100 1200
F 0 "Crx2" H 7150 1300 50  0000 L CNN
F 1 "100n" H 7150 1100 50  0000 L CNN
	1    7100 1200
	1    0    0    -1  
$EndComp
$Comp
L C Cpll2
U 1 1 519A6DAA
P 7450 1200
F 0 "Cpll2" H 7500 1300 50  0000 L CNN
F 1 "100n" H 7500 1100 50  0000 L CNN
	1    7450 1200
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR?
U 1 1 519A6DA9
P 7100 900
F 0 "#PWR?" H 7100 1000 30  0001 C CNN
F 1 "VDD" H 7100 1010 30  0000 C CNN
	1    7100 900 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 519A6DA8
P 7100 1550
F 0 "#PWR?" H 7100 1550 30  0001 C CNN
F 1 "GND" H 7100 1480 30  0001 C CNN
	1    7100 1550
	1    0    0    -1  
$EndComp
Text Notes 7250 1550 0    60   Italic 0
Must be placed near pins
Text Notes 6000 650  0    60   ~ 0
Ethernet controller decoupling
Text Label 10000 4300 0    60   ~ 0
LEDB
Text Label 10000 4200 0    60   ~ 0
LEDA
Text Label 10000 3400 0    60   ~ 0
TPI+
Text Label 10000 3300 0    60   ~ 0
TPI-
Text Label 10000 3150 0    60   ~ 0
TPO+
Text Label 10000 3050 0    60   ~ 0
TPO-
$Comp
L GND #PWR?
U 1 1 519A6BF7
P 7800 5150
F 0 "#PWR?" H 7800 5150 30  0001 C CNN
F 1 "GND" H 7800 5080 30  0001 C CNN
	1    7800 5150
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR?
U 1 1 519A6BE5
P 9200 2250
F 0 "#PWR?" H 9200 2350 30  0001 C CNN
F 1 "VDD" H 9200 2360 30  0000 C CNN
	1    9200 2250
	1    0    0    -1  
$EndComp
Text Notes 2900 650  0    60   ~ 0
MCU decoupling
Text Notes 4150 1550 0    60   Italic 0
Must be placed near pins
$Comp
L GND #PWR?
U 1 1 519A6ADD
P 3100 1500
F 0 "#PWR?" H 3100 1500 30  0001 C CNN
F 1 "GND" H 3100 1430 30  0001 C CNN
	1    3100 1500
	1    0    0    -1  
$EndComp
$Comp
L VDD #PWR?
U 1 1 519A6AD8
P 3100 900
F 0 "#PWR?" H 3100 1000 30  0001 C CNN
F 1 "VDD" H 3100 1010 30  0000 C CNN
	1    3100 900 
	1    0    0    -1  
$EndComp
$Comp
L C Cpll
U 1 1 519A6A8D
P 4350 1200
F 0 "Cpll" H 4400 1300 50  0000 L CNN
F 1 "100n" H 4400 1100 50  0000 L CNN
	1    4350 1200
	1    0    0    -1  
$EndComp
$Comp
L C Cvdd?
U 1 1 519A6A8C
P 4700 1200
F 0 "Cvdd?" H 4750 1300 50  0000 L CNN
F 1 "100n" H 4750 1100 50  0000 L CNN
	1    4700 1200
	1    0    0    -1  
$EndComp
$Comp
L C Cosc
U 1 1 519A6A8B
P 5050 1200
F 0 "Cosc" H 5100 1300 50  0000 L CNN
F 1 "100n" H 5100 1100 50  0000 L CNN
	1    5050 1200
	1    0    0    -1  
$EndComp
$Comp
L C Crx
U 1 1 519A6A79
P 4000 1200
F 0 "Crx" H 4050 1300 50  0000 L CNN
F 1 "100n" H 4050 1100 50  0000 L CNN
	1    4000 1200
	1    0    0    -1  
$EndComp
$Comp
L C Ctx
U 1 1 519A6A77
P 3650 1200
F 0 "Ctx" H 3700 1300 50  0000 L CNN
F 1 "100n" H 3700 1100 50  0000 L CNN
	1    3650 1200
	1    0    0    -1  
$EndComp
$Comp
L C Cvdd
U 1 1 519A6756
P 3300 1200
F 0 "Cvdd" H 3350 1300 50  0000 L CNN
F 1 "100n" H 3350 1100 50  0000 L CNN
	1    3300 1200
	1    0    0    -1  
$EndComp
Text Notes 600  650  0    60   ~ 0
User UART + POWER
$Comp
L VDD #PWR?
U 1 1 519A6999
P 1350 900
F 0 "#PWR?" H 1350 1000 30  0001 C CNN
F 1 "VDD" H 1350 1010 30  0000 C CNN
	1    1350 900 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 519A6988
P 1350 1600
F 0 "#PWR?" H 1350 1600 30  0001 C CNN
F 1 "GND" H 1350 1530 30  0001 C CNN
	1    1350 1600
	1    0    0    -1  
$EndComp
Text Label 1500 1150 0    60   ~ 0
TX
Text Label 7250 3850 0    60   ~ 0
TX
Text Label 1500 1250 0    60   ~ 0
RX
Text Label 7250 3750 0    60   ~ 0
RX
Text Notes 7550 3250 0    60   ~ 0
To check
$Comp
L ENC28J60-1 U?
U 1 1 519A64E7
P 9100 3750
F 0 "U?" H 9500 4900 60  0000 L CNN
F 1 "ENC28J60-1" H 9450 2650 60  0000 L CNN
	1    9100 3750
	1    0    0    -1  
$EndComp
$Comp
L HEADER_4 P?
U 1 1 519A61D4
P 950 1200
F 0 "P?" V 900 1200 50  0000 C CNN
F 1 "HEADER_4" V 1000 1200 50  0000 C CNN
	1    950  1200
	-1   0    0    -1  
$EndComp
$Comp
L PIC24F04KA201-PB-1 U?
U 1 1 519A61F6
P 6100 3500
F 0 "U?" H 6125 4200 60  0000 C CNN
F 1 "PIC24F04KA201-PB-1" H 6175 2750 60  0000 C CNN
	1    6100 3500
	1    0    0    -1  
$EndComp
$Comp
L RJ45-MAG J?
U 1 1 519A61DD
P 3500 6350
F 0 "J?" H 3600 6950 60  0000 L CNN
F 1 "RJ45-MAG" H 3450 6950 60  0000 R CNN
	1    3500 6350
	1    0    0    -1  
$EndComp
$EndSCHEMATC
