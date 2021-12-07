#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL43Z4.h"
#include "fsl_debug_console.h"
#include <stdlib.h>

int main(void) {

	SysTick->LOAD = 0xFFFFFF;
	SysTick->CTRL = 0x05;

	PTE->PDDR |= 1<<30u; /* Configure pin30 as output */

	SIM->SCGC6 |= 1<<31u; /* set DAC clock enable bit */

	DAC0->C0 |= 1<<7; /* set DAC enable bit */
	DAC0->C0 |= 1<<6; /* set DAC enable bit */
	DAC0->C1 |= 0<<7; /* disable DAC buffer */

	int c = 0, d = 0;

	while (1) {

		if (c < 255){
			c++;
			DAC0->DAT[0].DATL = c;
		}
		else if (c == 255 && d < 15){
			d++;
			c = 0;
			DAC0->DAT[0].DATL = c;
			DAC0->DAT[0].DATH = d;
		}
		else {
			c = 0;
			d = 0;
			DAC0->DAT[0].DATL = c;
			DAC0->DAT[0].DATH = d;
		}

	}
	}
