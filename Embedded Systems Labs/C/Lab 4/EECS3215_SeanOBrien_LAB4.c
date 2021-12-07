#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL43Z4.h"
#include "fsl_debug_console.h"
#include<stdlib.h>
void delay(unsigned int mseconds)
{
	 int c, d;

	   for (c = 1; c <= 1000; c++)
	       for (d = 1; d <= 1000; d++)
	       {}

	   return 0;
}


int main (void) {

	SysTick->LOAD = 0xFFFFFF;
	SysTick->CTRL = 0x05;

	SIM->SCGC5 |= SIM_SCGC5_PORTC_MASK;
	SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK;
	SIM->SCGC5 |= SIM_SCGC5_PORTE_MASK;
	SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK;

	PORTE->PCR[31] = 0x100;
	PORTD->PCR[5] = 0x100;

	PTE->PDDR |= 1<<31u;
	PTD->PDDR |= 1<<5u;

	PTE->PSOR |= 1<<31u;
	PTD->PSOR |= 1<<5u;

	PTC->PDDR &= 1<<3u;
	PORTC->PCR[3] = 0x103;

	PTA->PDDR &= 1<<4u;
	PORTA->PCR[4] = 0x103;

	PTA->PDDR &= 0<<1u;
	PORTA->PCR[1] = 0x103;


	while (1) {
		if (PTC->PDIR & 0b1000 && PTA->PDIR & 0b10000 && !(PTA->PDIR & 0b10)){
			PTD -> PSOR |= 1<<5u;
			PTE -> PSOR |= 1<<31u;
		}else if(!(PTA->PDIR & 0b10000) && PTC->PDIR & 0b1000  && !(PTA->PDIR & 0b10)){
			PTD -> PCOR |= 1<<5u;
			PTE -> PSOR |= 1<<31u;
		}else if(!(PTA->PDIR & 0b10000) && !(PTC->PDIR & 0b1000)  && !(PTA->PDIR & 0b10)){
			PTD -> PCOR |= 1<<5u;
			PTE -> PCOR |= 1<<31u;
		}else if(PTA->PDIR & 0b10 && !(PTA->PDIR & 0b10000) && !(PTC->PDIR & 0b1000)){
			PTD -> PCOR |= 1<<5u;
			PTE -> PCOR |= 1<<31u;
			delay(1000);
			PTD -> PSOR |= 1<<5u;
			PTE -> PSOR |= 1<<31u;
			delay(1000);
		}else{
			PTD -> PSOR |= 1<<5u;
			PTE -> PCOR |= 1<<31u;
			delay(1000);
			PTE -> PSOR |= 1<<31u;
			delay(1000);
		}
	}
