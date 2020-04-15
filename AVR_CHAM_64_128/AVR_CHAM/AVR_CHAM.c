/*
 * AVR_CHAM.c
 *
 * Created: 2018-01-15 오후 4:48:15
 *  Author: info
 */ 


#include <avr/io.h>
#include <avr/pgmspace.h>
typedef uint32_t u32;
typedef uint16_t u16;

extern void CHAM_EncryptBlk(u16* X);
//const u16 RK2[16]= { 0x0301,0x0705,0x0b09,0x0f0d,0x1311,0x1715,0x1b19,0x1f1d,0x151e,0x0308,0x3932,0x2f24,0x4d46,0x5b50,0x616a,0x777c};
const u16 RK[16] __attribute__ ((section(".MySection")))= { 0x0301,0x0705,0x0b09,0x0f0d,0x1311,0x1715,0x1b19,0x1f1d,0x151e,0x0308,0x3932,0x2f24,0x4d46,0x5b50,0x616a,0x777c};
u16 plaintext64[] = {0x1100, 0x3322, 0x5544, 0x7766};

int main(void)
{
	//u16 A = pgm_read_byte_near(RK+1);
	//u16 B = pgm_read_byte_near(RK2+2);
   CHAM_EncryptBlk(plaintext64);
}