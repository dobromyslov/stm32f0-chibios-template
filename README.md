STM32F0 ChibiOS Template
========================

**WARNING**
I dislike ChibiOS and recommend another officially supported by main vendors technology stack for embedded development. See: https://github.com/dobromyslov/stm32f0-cmsis-cube-hal-freertos-template

ChibiOS template project for STM32F0 MCU.
Tested on STM32F0Discovery board.

Features:
* ChibiOS 2.6.5 stable with only necessary dependencies
* Improved Makefile based on the native ChibiOS makefile from board demo
* OpenOCD instant flash support with `make flash`
* Improved project structure for easy further Chibios versions change and migration
* Serial port on PA9 (TX), PA10 (RX) pins uses 115200 bitrate
* User button push triggers "Test message!" output to the serial port
* Green and blue leds blink
* Works great with Eclipse debug via GDB: http://www.chibios.org/dokuwiki/doku.php?id=chibios:guides:eclipse2
