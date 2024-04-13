
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x22f708c
	.area 0x4
		mov r0, 234h
	.endarea

	.org 0x22f70f8
	.area 0x8
		.word 0x235
		.word 0x236
	.endarea

	.org 0x22f76ac
	.area 0x20
		movne r1, 234h
		cmpne r4, r1
		addne r1, 1h
		cmpne r4, r1
		addne r1, 1h
		cmpne r4, r1
		beq 0x22f76e4
		b 0x22f7704
	.endarea

	.org 0x22f76ec
	.area 0x4
		mov r0, 234h
	.endarea

	.org 0x22f7758
	.area 0x8
		.word 0x235
		.word 0x236
	.endarea

	.org 0x22f941C
	.area 0x10
		blt 0x22f94d8
		bl GetCastform1
		cmp r2, #2
		bgt 0x22f94d8
	.endarea

	.org 0x22F945C
	.area 0x18
		ldr r0, [0x22f94e0]
		cmp r1, r0
		blt 0x22f94d8
		bl GetCastform15
		cmp r0, #2
		bgt 0x22f94d8
	.endarea

	.org 0x22f94b0
	.area 0x24
		popeq r4, pc
		bl GetCastform2
		cmp r2, 2h
		pople r4, pc
		nop
		nop
		nop
		nop
		nop
	.endarea

	.org 0x22fc708
	.area 0x4
		sub r0, r1, 234h
	.endarea

	.org 0x22fc72c
	.area 0x4
		sub r0, r1, 234h
	.endarea

	.org 0x22fe09c
	.area 0x4
		sub r0, r1, 234h
	.endarea

	.org 0x22fe0c0
	.area 0x4
		sub r0, r1, 234h
	.endarea

    .org 0x2335240
    .area 0x18
    	ldr r0, [0x2335438]
    	bl ChooseCastformOption
    	nop
    	bl GetCastform3
		cmp r0, #2
		ble 0x2335270
    .endarea

    .org 0x2335258
    .area 0x18
    	ldr r0, [0x233543C]
    	bl ChooseCastformOption2
    	nop
    	bl GetCastform3
		cmp r0, #2
		bgt 0x23352FC
    .endarea

	; 2335298: Forecast

	.org 0x23352a8
	.area 0x10
		bl GetCastform4
		cmp r0, #2
		strlth r1, [r7, 4h]
		blt 0x23352c0
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34200
.area 0x34300 - 0x34200
	GetCastform1:
		mov r2, 17Ch
		sub r2, r2, 1h
		cmp r2, r1
		beq 0x22f942c
		mov r2, 234h
		cmp r2, r1
		bxgt lr
		sub r2, r1, r2
		bx lr

	GetCastform15:
		mov r0, 17Ch
		sub r0, r0, 1h
		cmp r0, r1
		beq 0x22f9474
		mov r0, 234h
		cmp r0, r1
		bxgt lr
		sub r0, r1, r0
		bx lr

	GetCastform2:
		mov r2, 234h
		cmp r2, r1
		bxgt lr
		sub r2, r1, r2
		bx lr

	ChooseCastformOption:
		cmp r1, r0
		beq 0x2335270
		blt 0x2335258
		bx lr

	ChooseCastformOption2:
		cmp r1, r0
		beq 0x2335270
		blt 0x23352FC
		bx lr

	GetCastform3:
		push r1
		mov r1, 234h
		cmp r0, r1
		poplt r1
		bxlt lr
		sub r0, r0, r1
		pop r1
		bx lr

	GetCastform4:
		mov r0, 234h
		cmp r0, r1
		bxgt lr
		sub r0, r1, r0
		bx lr
	.endarea
.close