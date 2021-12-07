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
void PORTC_PORTD_IRQHandler(void){
PTE->PCOR |= 1<<31u;
 delay(500);
PTE->PSOR |= 1<<31u;
PORTC->PCR[3] |= 1<<24u;
delay(8000);
}
int main(void) {
BOARD_InitBootPins();
BOARD_InitBootClocks();
BOARD_InitBootPeripherals();
BOARD_InitDebugConsole();
SIM->SCGC5 |= SIM_SCGC5_PORTE_MASK; // enable clock to port E
SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK; // enable clock to port D
SIM->SCGC5 |= SIM_SCGC5_PORTC_MASK; // enable clock to port C
__disable_irq();
NVIC_DisableIRQ(PORTC_PORTD_IRQn);
PORTC->PCR[3] &= ~(0xF0000);
PORTC->PCR[3] |= 0xA0103; // then enable ISF flag and Interrupt on falling-edge.
NVIC_EnableIRQ(PORTC_PORTD_IRQn);
__enable_irq();
PORTD->PCR[5] |= 0x100; // enable green led
PTD->PDDR |= 1<<5u; // set green led to output
PTD->PSOR |= 1<<5u; // off by default
PORTE->PCR[31] |= 0x100; // enable red led
PTE->PDDR |= 1<<31u; // set green led to output
PTE->PSOR |= 1<<31u; // off by default
PORTC->PCR[3] |= 0x103; // enable pushbutton
PTC->PDDR &= 0<<3u; // set pushbutton to input
while(1) {
PTD->PCOR |= 1<<5u;
delay(500);
PTD->PSOR |= 1<<5u;
delay(4000);
}
}