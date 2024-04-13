.nds
.open "arm9.bin", 0x2000000
	.org 0x205cbf8
	.area 0x4
		; bl CheckMagne1 
		ldrsh r2, [r4, 0Eh]
	.endarea

	.org 0x205cc18
	.area 0x4
		; bl CheckMagne2 
		ldrsh r2, [r4, 10h]
	.endarea

	.org 0x205cc84
	.area 0x4
		; bl CheckMagne3 
		ldrsh r2, [r4, 12h]
	.endarea

	.org 0x205ce04
	.area 0x4
		; bl CheckMagne4
		ldrsh r0, [r4, 18h]
	.endarea

	.org 0x205ceb0
	.area 0x4
		; bl CheckMagne5 
		ldrsh r5, [r4, 1Ch]
	.endarea

	.org 0x205d56c
	.area 0x4
		; bl CheckMagne6 
		ldrsh r5, [r9, 12h]
	.endarea

	.org 0x205d668
	.area 0x4
		; bl CheckMagne7 
		ldrsh r5, [r2, r1]
	.endarea

	.org 0x205d720
	.org 0x205d7a0
	.area 0x4
		; bl CheckMagne8 
		ldrsh r4, [r2, r1]
	.endarea

	.org 0x205d89c
	.area 0x4
		; bl CheckMagne9
		ldrsh r7, [r5, 18h]
	.endarea

	.org 0x205da54
	.area 0x4
		; bl CheckMagne10 
		ldrsh r4, [r1, r0]
	.endarea

	.org 0x205d980
	.org 0x205dae0
	.area 0x4
		; bl CheckMagne11 
		ldrsh r5, [r1, r0]
	.endarea

	.org 0x2062704
	.area 0x4
		bl CheckAbyss
	.endarea
.close

.open "overlay_0029.bin", 0x22DC240
	.org 0x22f649c
	.area 0x4
		b WarpTeam
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
	.orga 0x2E800
	.area 0x2E840 - 0x2E800

	CheckAbyss:
		cmp r0, 51h
		moveq r0, 4Eh
		and r0, r0, 0xff
		bx lr

	WarpTeam:
		push r0-r3
		bl 0x22E9580 ; Get Leader
		mov r1, r0
		ldr r2, =188h
		mov r3, #0
		bl 0x232CCC4 ; DoMoveWildCall
		pop r0-r3 ; Original instruction
		mov r0, r10
		b 0x22f64a0

	; r8: Actor ID
	; r10: Switch selector
	/*CheckMagne1:
		push r8, r10, r11
		mov r10, #0
		ldrsh r8, [r4, 0Eh]
		b ReplaceMagne
	CheckMagne2:
		push r8, r10, r11
		mov r10, #1
		ldrsh r8, [r4, 10h]
		b ReplaceMagne
	CheckMagne3:
		push r8, r10, r11
		mov r10, #2
		ldrsh r8, [r4, 12h]
		b ReplaceMagne
	CheckMagne4:
		push r8, r10, r11
		mov r10, #3
		ldrsh r8, [r4, 18h]
		b ReplaceMagne
	CheckMagne5:
		push r8, r10, r11
		mov r10, #4
		ldrsh r8, [r4, 1Ch]
		b ReplaceMagne
	CheckMagne6:
		push r8, r10, r11
		mov r10, #5
		ldrsh r8, [r9, 12h]
		b ReplaceMagne
	CheckMagne7:
		push r8, r10, r11
		mov r10, #6
		ldrsh r8, [r2, r1]
		b ReplaceMagne
	CheckMagne8:
		push r8, r10, r11
		mov r10, #7
		ldrsh r8, [r2, r1]
		b ReplaceMagne
	CheckMagne9:
		push r8, r10, r11
		mov r10, #8
		ldrsh r8, [r5, 18h]
		b ReplaceMagne
	CheckMagne10:
		push r8, r10, r11
		mov r10, #9
		ldrsh r8, [r1, r0]
		b ReplaceMagne
	CheckMagne11:
		push r8, r10, r11
		mov r10, #10
		ldrsh r8, [r1, r0]
	ReplaceMagne:
		ldr r11, [MagnezoneID]
		cmp r8, r11
		cmpne r8, 51h ; Magnemite
		addeq r8, r8, 258h
		mov r10, r10, lsl 4h
		sub r10, r10, 4h
		add pc, pc, r10 ; Could be adds
	SwitchMagne:
		; case 0
		strh r8, [r4, 0Eh]
		ldrsh r2, [r4, 0Eh]
		pop r8, r10, r11
		bx lr
		; case 1
		strh r8, [r4, 10h]
		ldrsh r2, [r4, 10h]
		pop r8, r10, r11
		bx lr
		; case 2
		strh r8, [r4, 12h]
		ldrsh r2, [r4, 12h]
		pop r8, r10, r11
		bx lr
		; case 3
		strh r8, [r4, 18h]
		ldrsh r0, [r4, 18h]
		pop r8, r10, r11
		bx lr
		; case 4
		strh r8, [r4, 1Ch]
		ldrsh r5, [r4, 1Ch]
		pop r8, r10, r11
		bx lr
		; case 5
		strh r8, [r9, 12h]
		ldrsh r5, [r9, 12h]
		pop r8, r10, r11
		bx lr
		; case 6
		strh r8, [r2, r1]
		ldrsh r5, [r2, r1]
		pop r8, r10, r11
		bx lr
		; case 7
		strh r8, [r2, r1]
		ldrsh r4, [r2, r1]
		pop r8, r10, r11
		bx lr
		; case 8
		strh r8, [r5, 18h]
		ldrsh r7, [r5, 18h]
		pop r8, r10, r11
		bx lr
		; case 9
		strh r8, [r1, r0]
		ldrsh r4, [r1, r0]
		pop r8, r10, r11
		bx lr
		; case 10
		strh r8, [r1, r0]
		ldrsh r5, [r1, r0]
		pop r8, r10, r11
		bx lr

	MagnezoneID:
		.word 0x1f8*/
	.pool
	.endarea
.close