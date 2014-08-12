stm32f0-chibios-template
========================

ChibiOS template project for STM32F0 MCU.
Tested on STM32F0Discovery board.

Features:
* ChibiOS 2.6.5 stable with only necessary dependencies
* Improved Makefile based on the native ChibiOS makefile from board demo
* OpenOCD instant flash support with `make flash`
* Serial port on PA9 (TX), PA10 (RX) pins uses 115200 bitrate
* User button push triggers "Test message!" output to the serial port
* Green and blue leds blink
* Works with Eclipse GDB: http://www.chibios.org/dokuwiki/doku.php?id=chibios:guides:eclipse2
