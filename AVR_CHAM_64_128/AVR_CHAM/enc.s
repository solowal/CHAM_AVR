	.global CHAM_EncryptBlk
	.type CHAM_EncryptBlk, @function
  
	; operand b: r21:r20
	; operand a: r23:r22
	; operand r: r25:r24
//14: Plaintext (8)

#define X4 R0 //R0
#define X5 R1 //R1

#define ZERO R2 //R2

#define X6 R18 //R18
#define X7 R19 //R19

#define X0 R20 //R20
#define X1 R21 //R21
#define X2 R22 //R22
#define X3 R23 //R23

#define C0 R24 //R24
#define C1 R25 //R25

#define X8 R26 //R26
#define X9 R27 //R27

	CHAM_EncryptBlk:

	PUSH R2
	
	MOVW R26, R24	//plain 
	
	LD X0, X+
	LD X1, X+
	LD X2, X+
	LD X3, X+
	LD X4, X+
	LD X5, X+
	LD X6, X+
	LD X7, X+	
	
	PUSH R26
	PUSH R27
	
	CLR C0
	CLR ZERO
		//LDI R31, 0X08
	LDI R31, hi8(LUT_1)
	CLR R30

	STEP1:
	MOVW X8, X2

	LSL X2
	ROL X3
	ADC X2, ZERO

	EOR X0, C0	
	ANDI R30, 31

	LPM C1, Z+
	EOR X2, C1

	LPM C1, Z+
	EOR X3, C1

	ADD X0, X2
	ADC X1, X3

	INC C0
	
	// SECOND

	MOVW X2, X4
	EOR X8, C0	

	//ANDI R30, 31

	LPM C1, Z+
	EOR X5, C1		//REVERSE

	LPM C1, Z+
	EOR X4, C1		//REVERSE

	ADD X8, X5		//REVERSE
	ADC X9, X4

	LSL X8
	ROL X9
	ADC X8, ZERO

	MOV X4, X1
	MOV X5, X0

	MOVW X0, X2
	MOVW X2, X6
	MOVW X6, X8

	//
	INC C0
	//ADIW C0, 2

	CPI C0, 80
	BRLT STEP1	

	POP R27
	POP R26
		
	ST -X, X7
	ST -X, X6
	ST -X, X5
	ST -X, X4
	ST -X, X3
	ST -X, X2
	ST -X, X1
	ST -X, X0
	
	CLR R1
	POP R2
	
	RET



.balign 256
LUT_1: 
.word	0x0301,0x0705,0x0b09,0x0f0d,0x1311,0x1715,0x1b19,0x1f1d,0x151e,0x0308,0x3932,0x2f24,0x4d46,0x5b50,0x616a,0x777c
