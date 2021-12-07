#include <stdio.h>
#include "board.h"
#include "peripherals.h"
#include "pin_mux.h"
#include "clock_config.h"
#include "MKL43Z4.h"
#include "fsl_debug_console.h"
#include <stdlib.h>
/* TODO: insert other include files here. */
/* TODO: insert other definitions and declarations here. */
/*
* @brief Application entry point.
*/
void delay(unsigned int mseconds){
int c, d;
for (c = 1; c <= 200; c++){
for(d = 1; d <= 200; d++)
{
}
}
}
int main(void) {
/* Init board hardware. */
//
BOARD_InitBootPins();
//
BOARD_InitBootClocks();
//
BOARD_InitBootPeripherals();
//
/* Init FSL debug console. */
//
BOARD_InitDebugConsole();
SIM->SCGC6 |= 1<<27u;
SIM->SCGC5 |= SIM_SCGC5_PORTE_MASK;
SIM->SCGC5 |= SIM_SCGC5_PORTA_MASK;
SIM->SCGC5 |= SIM_SCGC5_PORTB_MASK;
SIM->SCGC5 |= SIM_SCGC5_PORTC_MASK;
SIM->SCGC5 |= SIM_SCGC5_PORTD_MASK;
ADC0->SC1[0] &= 0xFFFFFFC0; // 000000; // DIFF and ADCH
ADC0->CFG1 &= 0xFFFFFFF3; // Mode
ADC0->CFG2 &= 0xFFFFFFEF; // Muxsel
PTE->PDDR = 0<<20u; // set PTE as input
 PORTA->PCR[1] = 0x100;
PORTA->PCR[2] = 0x100;
PORTD->PCR[3] = 0x100;
PORTA->PCR[12] = 0x100;
PORTB->PCR[18] = 0x100;
PORTB->PCR[19] = 0x100;
PORTC->PCR[0] = 0x100;
PORTC->PCR[4] = 0x100;
//first four segments
PTA->PDDR |= 1<<1u; //A
PTA->PDDR |= 1<<2u; //B
PTD->PDDR |= 1<<3u; //C
PTA->PDDR |= 1<<12u; //D
//next four segments
PTB->PDDR |= 1<<18u; //E
PTB->PDDR |= 1<<19u; //F
PTC->PDDR |= 1<<0u; //G
PTC->PDDR |= 1<<4u; //selector bit
int lsb = 0;
int msb = 0;
while(1) {
ADC0->SC1[0] &= 0xFFFFFFC0; // DIFF and ADCH
while((ADC0->SC1[0] >> 7u) != 0b1) {}
delay(1000);
lsb = ADC0->R[0] % 16;
msb = ADC0->R[0] >> 4;
printf("This is our thing: %i\n", ADC0->R[0]);
PTC->PCOR |= 1<<4u;
if(lsb == 0)
{
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}
else if(lsb == 1)
{
PTA->PCOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
 PTC->PCOR |= 1; //G
}
else if(lsb == 2)
{
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(lsb == 3)
{
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(lsb == 4)
{
PTA->PCOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(lsb == 5)
{
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(lsb == 6){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 7){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
 PTA->PCOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}else if(lsb == 8){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 9){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 10){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 11){
PTA->PCOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 12){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}else if(lsb == 13){
PTA->PCOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 14){
PTA->PSOR |= 1<<1u; //A
 PTA->PCOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(lsb == 15){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
delay(1000);
PTC->PSOR |= 1<<4u;
if(msb == 0)
{
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}
else if(msb == 1)
{
PTA->PCOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}
else if(msb == 2)
{
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(msb == 3)
{
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
 PTB->PCOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(msb == 4)
{
PTA->PCOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(msb == 5)
{
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
else if(msb == 6){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 7){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}else if(msb == 8){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 9){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PCOR |= 1<<18u; //E
 PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 10){
PTA->PSOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 11){
PTA->PCOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 12){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PCOR |= 1; //G
}else if(msb == 13){
PTA->PCOR |= 1<<1u; //A
PTA->PSOR |= 1<<2u; //B
PTD->PSOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PCOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 14){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PSOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}else if(msb == 15){
PTA->PSOR |= 1<<1u; //A
PTA->PCOR |= 1<<2u; //B
PTD->PCOR |= 1<<3u; //C
PTA->PCOR |= 1<<12u; //D
PTB->PSOR |= 1<<18u; //E
PTB->PSOR |= 1<<19u; //F
PTC->PSOR |= 1; //G
}
}