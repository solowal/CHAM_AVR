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
//const u32 RK[16] __attribute__ ((section(".MySection")))= { 0x07070303,0x0f0f0b0b,0x17171313,0x1f1f1b1b,0xe6e6e2e2,0xeeeeeaea,0xf6f6f2f2,0xfefefafa,0x39222f34,0x150e0318,0x617a776c,0x4d565b40,0xafb4b9a2,0x8398958e,0xf7ece1fa,0xdbc0cdd6};
u32 plaintext64[] = {0x33221100, 0x77665544, 0xbbaa9988, 0xffeeddcc};

int main(void)
{
	//u16 A = pgm_read_byte_near(RK+1);
	//u16 B = pgm_read_byte_near(RK2+2);
   CHAM_EncryptBlk(plaintext64);
}