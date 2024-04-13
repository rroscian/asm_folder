
.nds
.open "arm9.bin", 0x2000000
	.org 0x205B120
	.area 0x8
		push r4-r7, r11, r14
		sub r13, r13, 28h ; was 24h
	.endarea

	.org 0x205b13c
	.area 0x4
		mov r11, r2
	.endarea

	.org 0x205b1f0
	.area 0x4
		ldrb r0, [r11]
	.endarea

	.org 0x205b21c
	.area 0xC
		ldrsh r0, [r11, #0x4]
		cmp r0, #0x1a
		ldreq r0, [DAT_205B338]
	.endarea

	.org 0x205b238
	.area 0xC
		ldrsh r0, [r11, #0x4]
		cmp r0, #0x32
		ldreq r0, [DAT_205B33C]
	.endarea

	.org 0x205b254
	.area 0xC
		ldrsh r0, [r11, #0x4]
		cmp r0, #0x28
		ldreq r0, [DAT_205B340]
	.endarea

	.org 0x205b270
	.area 0xC
		ldrsh r0, [r11, #0x4]
		cmp r0, #0x32
		ldreq r0, [DAT_205B33C]
	.endarea

	.org 0x205b28c
	.area 0xC
		ldrsh r0, [r11, #0x4]
		cmp r0, #0x25
		ldreq r0, [DAT_205B344]
	.endarea

	.org 0x205b2a8
	.area 0xC
		ldrsh r0, [r11, #0x4]
		cmp r0, #0x29
		ldreq r0, [DAT_205B348]
	.endarea

	.org 0x205b2c4
	.area 0x4
		ldrsh r0, [r11, #0x4]
	.endarea

	.org 0x205b2d4
	.area 0x4
		ldr r0, [DAT_205B34c]
	.endarea

	.org 0x205b31c
	.area 0x38
		ldrnesh r1, [r5, #0x0]
		ldrne r4, [r4]
		ldrnesh r0, [r4, #0xA]
		movne r0, r0, lsr 3h
		addne r0, r1, r0
		strneh r0, [r5, #0x0]
		add sp, sp, 28h
		pop r4-r7, r11, r15
	DAT_205B338:
		.word 0x20a18ac
	DAT_205B33C:
		.word 0x20a187c
	DAT_205B340:
		.word 0x20a186c
	DAT_205B344:
		.word 0x20a18a8
	DAT_205B348:
		.word 0x20a18b4
	DAT_205B34c:
		.word 0x20a1898
	.endarea
.close

.open "overlay_0029.bin", 0x22DC240
	.org 0x22fb758
	.area 0x10
		ldrnesh r1, [r4, #0x16]
		mov r8, #0x0
		ldrneh r0, [r4, #0x12]
		mov r0, r0, lsr 3h
	.endarea
.close