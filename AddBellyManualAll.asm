.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x22ebda8
	.area 0xC
		ldrb r0, [r6, #0x7]
		cmp r0, #0
		bne 0x22ebec8
	.endarea

	.org 0x22ec08c
	.area 0x4
		cmp r4, 4h
	.endarea

	.org 0x22f9d60
	.area 0x4
		beq CheckManual2
	.endarea

	.org 0x230fd14
	.area 0x4
		beq CheckManual1
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2FE00
.area 0x2FF00 - 0x2FE00

CheckManual1:
	push r0
	ldr r0, =23A7090h
	ldrb r0, [r0]
	cmp r0, #1
	pop r0
	bne 0x231013c
	b 0x230fd18

CheckManual2:
	push r0
	ldr r0, =23A7090h
	ldrb r0, [r0]
	cmp r0, #1
	pop r0
	bne 0x22f9e78
	b 0x22f9d64

.pool
.endarea
.close