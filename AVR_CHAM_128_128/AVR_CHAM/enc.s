	.global CHAM_EncryptBlk
	.type CHAM_EncryptBlk, @function
  
	; operand b: r21:r20
	; operand a: r23:r22
	; operand r: r25:r24
//14: Plaintext (8)

#define X0 R0 //R0
#define X1 R1 //R1

#define X2 R2 //R2
#define X3 R3 //R3
#define X4 R4 //R4
#define X5 R5 //R5
#define X6 R6 //R6
#define X7 R7 //R7
#define X8 R8 //R8
#define X9 R9 //R9

#define ZERO R10 //R30

#define X10 R18 //R18
#define X11 R19 //R19
#define X12 R20 //R20
#define X13 R21 //R21
#define X14 R22 //R22
#define X15 R23 //R23

#define C0 R24 //R24
#define C1 R25 //R25

#define X16 R26 //R26
#define X17 R27 //R27
#define X18 R28 //R28
#define X19 R29 //R29



#define T0 R30 //R30
#define T1 R31 //R31

#define T3 R31 //R31

	CHAM_EncryptBlk:
//key 32 bytes
// 80 LINE…
//60 LINES
	//c : r24,r25
	//b : r20,r21
	//a : r23,r22
	
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	PUSH R10

	PUSH R28
	PUSH R29

	MOVW R26, R24	//plain 
	
	LD X0, X+
	LD X1, X+
	LD X2, X+
	LD X3, X+
	LD X4, X+
	LD X5, X+
	LD X6, X+
	LD X7, X+

	LD X8 , X+
	LD X9 , X+
	LD X10, X+
	LD X11, X+
	LD X12, X+
	LD X13, X+
	LD X14, X+
	LD X15, X+
		
	PUSH R26
	PUSH R27

	CLR C0
			//LDI R31, 0X08
	LDI R31, hi8(LUT_1)
	CLR R30

	CLR ZERO

	STEP1:
	//even (0) ROL1 / odd (1) ROL8
	
	MOVW X16, X4
	MOVW X18, X6

	LSL X4
	ROL X5
	ROL X6
	ROL X7
	ADC X4, ZERO

	EOR X0, C0	
	
	ANDI R30, 31

	LPM C1, Z+
	EOR X4, C1

	LPM C1, Z+
	EOR X5, C1

	LPM C1, Z+
	EOR X6, C1

	LPM C1, Z+
	EOR X7, C1

	ADD X0, X4
	ADC X1, X5
	ADC X2, X6
	ADC X3, X7

	INC C0

	// 0 1 2 3 || 4 5 6 7 || 8 9 10 11 || 12 13 14 15
	//16171819   08091011   
	//
	MOVW X4, X8
	MOVW X6, X10

	EOR X16, C0	
	//ANDI R30, 31

	LPM C1, Z+
	EOR X11, C1

	LPM C1, Z+
	EOR X8, C1

	LPM C1, Z+
	EOR X9, C1

	LPM C1, Z+
	EOR X10, C1

	ADD X16, X11
	ADC X17, X8
	ADC X18, X9
	ADC X19, X10

	LSL X16
	ROL X17
	ROL X18
	ROL X19
	ADC X16, ZERO

	MOV X8 , X3
	MOV X9 , X0
	MOV X10, X1
	MOV X11, X2

	MOVW X0, X4
	MOVW X2, X6

	MOVW X4, X12
	MOVW X6, X14
	
	MOVW X12, X16
	MOVW X14, X18
	
	INC C0
	
	CPI C0, 80
	BRLT STEP1

	POP R27
	POP R26
	
	ST -X, X15
	ST -X, X14
	ST -X, X13
	ST -X, X12
	ST -X, X11
	ST -X, X10
	ST -X, X9
	ST -X, X8
	ST -X, X7
	ST -X, X6
	ST -X, X5
	ST -X, X4
	ST -X, X3
	ST -X, X2
	ST -X, X1
	ST -X, X0

	CLR R1
	POP R29
	POP R28
	POP R10
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	/**/
	RET


.balign 256
LUT_1: 
.word	0x0301,0x0705,0x0b09,0x0f0d,0x1311,0x1715,0x1b19,0x1f1d,0x151e,0x0308,0x3932,0x2f24,0x4d46,0x5b50,0x616a,0x777c
