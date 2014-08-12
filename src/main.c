#include "ch.h"
#include "hal.h"

/**
 * Blue LED blinker thread, times are in milliseconds.
 */
static WORKING_AREA(waThread1, 128);
static msg_t Thread1(void *arg) {
    (void)arg;
    chRegSetThreadName("blinker1");
    while (TRUE) {
        palClearPad(GPIOC, GPIOC_LED4);
        chThdSleepMilliseconds(500);
        palSetPad(GPIOC, GPIOC_LED4);
        chThdSleepMilliseconds(500);
    }

    return RDY_OK;
}

/**
 * Green LED blinker thread, times are in milliseconds.
 */
static WORKING_AREA(waThread2, 128);
static msg_t Thread2(void *arg) {
    (void)arg;
    chRegSetThreadName("blinker2");
    while (TRUE) {
        palClearPad(GPIOC, GPIOC_LED3);
        chThdSleepMilliseconds(250);
        palSetPad(GPIOC, GPIOC_LED3);
        chThdSleepMilliseconds(250);
    }

    return RDY_OK;
}

/**
 * Serial driver bitrate changed from default to 115200.
 */
static const SerialConfig serialConfig = {
    115200,
    0,
    USART_CR2_STOP1_BITS | USART_CR2_LINEN,
    0
};

/**
 * Application entry point.
 */
int main(void) {
    /**
     * System initializations.
     * - HAL initialization, this also initializes the configured device drivers
     *   and performs the board-specific initializations.
     * - Kernel initialization, the main() function becomes a thread and the
     *   RTOS is active.
     */
    halInit();
    chSysInit();

    /**
     * Activates the serial driver 1 using the driver default configuration.
     * PA9 and PA10 are routed to USART1.
     */
    sdStart(&SD1, &serialConfig);
    palSetPadMode(GPIOA, 9, PAL_MODE_ALTERNATE(1));       /* USART1 TX.       */
    palSetPadMode(GPIOA, 10, PAL_MODE_ALTERNATE(1));      /* USART1 RX.       */

    /**
     * Creates the blinker threads.
     */
    chThdCreateStatic(waThread1, sizeof(waThread1), NORMALPRIO, Thread1, NULL);
    chThdCreateStatic(waThread2, sizeof(waThread2), NORMALPRIO, Thread2, NULL);

    /**
     * Normal main() thread activity, in this demo it does nothing except
     * sleeping in a loop and check the button state, when the button is
     * pressed the test procedure is launched with output on the serial
     * driver 1.
     */
    while (TRUE) {
        if (palReadPad(GPIOA, GPIOA_BUTTON)) {
            chnWriteTimeout(&SD1, (const uint8_t*)"Test Message!", 13, TIME_INFINITE);
        }
        chThdSleepMilliseconds(500);
    }

    return 0;
}
