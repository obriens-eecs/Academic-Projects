/*
 * Copyright 2016-2018 NXP Semiconductor, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * o Redistributions of source code must retain the above copyright notice, this list
 *   of conditions and the following disclaimer.
 *
 * o Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 *
 * o Neither the name of NXP Semiconductor, Inc. nor the names of its
 *   contributors may be used to endorse or promote products derived from this
 *   software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
/**
 * @file    Lab8.c
 * @brief   Application entry point.
 */
#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL43Z4.h"
#include "fsl_debug_console.h"
#include <stdlib.h>

void delay(unsigned int mseconds){
        int c, d;

        for (c = 1; c <= mseconds; c++){
            for(d = 1; d <= 1000; d++)
            {

            }
        }
    }
/* TODO: insert other include files here. */

/* TODO: insert other definitions and declarations here. */

/*
 * @brief   Application entry point.
 */
void PORTC_PORTD_IRQHandler(void){
	// if belt is buckled during buzzer, turn off warning light and buzzer and reset interrupt
	// if belt unbuckled during operation, turn on warning light
	if (PTC->PDIR & 0b00){
	PTE->PSOR |= 1<<31u;
	PTD->PSOR |= 1<<5u;
	}
	else if(PTC->PDIR & 0b10){
		PTE->PSOR |= 1<<31u;
	}
	PORTC->PCR[3] |= 1<<24u;
}

int main(void) {

  	/* Init board hardware. */
    BOARD_InitBootPins();
    BOARD_InitBootClocks();
    BOARD_InitBootPeripherals();
  	/* Init FSL debug console. */
    BOARD_InitDebugConsole();

    SysTick->LOAD |= 0x1; // reload value for when the timer reaches 0
    SysTick->CTRL |= 0x05; // bit 0: enable,
    					   // bit 1: enable interrupt when clock reaches 0
    					   // bit 2: 1 means core clock is selected
    					   // bit 16 (COUNTFLAG): set to 1 when timer reaches 0, cleared by reading this register
   // SysTick->VAL |= 0x0; // Reading returns the current value of the timer,
    					   // Writing any value to this register causes the register to clear and the COUNTFLAG to reset to 0

    SIM->SCGC5 |= SIM_SCGC5_PORTE_MASK; // enable clock to port E
    SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK; // enable clock to port D
    SIM->SCGC5 |= SIM_SCGC5_PORTC_MASK; // enable clock to port C
    SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK; // enable clock to port A

    __disable_irq();
    NVIC_DisableIRQ(PORTC_PORTD_IRQn);
    PORTC->PCR[3] &= ~(0xF0000);
    PORTC->PCR[3] |= 0xA0103; // then enable ISF flag and Interrupt on either-edge.
    NVIC_EnableIRQ(PORTC_PORTD_IRQn);
    __enable_irq();

    PORTD->PCR[5] |= 0x100; // enable green led
    PTD->PDDR |= 1<<5u; // set green led to output
    PTD->PSOR |= 1<<5u; // off by default

    PORTE->PCR[31] |= 0x100; // enable red led
    PTE->PDDR |= 1<<31u; // set green led to output
    PTE->PSOR |= 1<<31u; // off by default

    PORTC->PCR[3] |= 0x103; // enable pushbutton 1 (belt buckled) left side
    PTC->PDDR &= 0<<3u; // set to input

    PORTA->PCR[4] |= 0x103; // enable pushbutton 2 (seat occupied)
    PTA->PDDR &= 0<<4u; // set to input

    PORTA->PCR[1] |= 0x103; // enable pin for third input signal (engine on)
    PTA->PDDR &= 0<<1u; // set to input

    PORTA->PCR[2] |= 0x103; // enable the second wire
    PTA->PDDR &= 0<<2u;


    int on = 0;
        while(1) {

        	if (PTA->PDIR & 0b10){
        		//if engine is off, both LEDs should be off
        		printf("engine off\n");
        		PTE->PSOR |= 1<<31u;
        		PTD->PSOR |= 1<<5u;
        		on = 0;
        	}

        	else if(!(PTA->PDIR & 0b10) && PTA->PDIR & 0b100 && !(PTC->PDIR & 0b1000)){
        		// if seat is occupied, and belt is not buckled,
        		// turn on warning light and set buzzer for 5 seconds
        		printf("unbuckled\n");
        		if(on == 0){
        			PTE->PCOR |= 1<<31u;
            		PTD->PCOR |= 1<<5u;
            		delay(12500);
            		SysTick->CTRL |= 0x05;
            		PTD->PSOR |= 1<<5u;
            		on = 1;
        		}else{
        			PTE->PCOR |= 1<<31u;
        			PTD->PSOR |= 1<<5u;
        		}
        	}

        	else if (!(PTA->PDIR & 0b10) && !(PTA->PDIR & 0b100) && !(PTC->PDIR & 0b1000)){
        		// if the seat is occupied and the belt is buckled
        		// the warning light and buzzer should be off
        		printf("proper\n");
        		PTE->PSOR |= 1<<31u;
        		PTD->PSOR |= 1<<5u;
        		on = 0;
        	}

        	else {
        		// the system is in an illegal state
        		// the alarms should be set
        		printf("Illegal\n");
        		PTE->PCOR |= 1<<31u;
        		PTD->PCOR |= 1<<5u;
        		on = 0;
        	}
        }
}
