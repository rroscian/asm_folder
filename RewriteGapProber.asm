.nds
.open "overlay_0029.bin", 0x22DC240
	
	.org 0x231a6d8
	.area 0xC0;TBD
		cmp r4, r7
		movgt r4, r7
		ldr r1, [0x231a798]
		mov r2, r8, lsl 2h
		ldr r0, [0x231a79c]
		ldrsh r7, [r9, 4h]
		ldrsh r8, [r9, 6h]
		ldrsh r9, [r1, r2]
		ldrsh r10, [r0, r2]
		mov r6, 0h
		b LoopCheck

	ContinueLoop:
		add r7, r7, r9
		add r8, r8, r10
		cmp r7, 1h
		cmpge r8, 1h
		blt return
		cmp r7, 37h
		cmplt r8, 1Fh
		bge return
		mov r0, r7
		mov r1, r8
		bl 0x23360fc
		ldrh r1, [r0, 0h]
		tst r1, 3h
		moveq r0, 0h
		beq LoadMultipleIncrementAfter
		ldr r0, [r0, 0Ch]
		cmp r0, r5
		moveq r0, 1h
		beq LoadMultipleIncrementAfter
		cmp r0, 0h
		beq IncrementLoop
		mov r0, r9
		mov r1, #3
		bl 0x2301F80
		cmp r0, 0h
		movne r0, 0h
		bne LoadMultipleIncrementAfter
		cmp r4, r7
		movle r0, 1h
		movgt r0, 0h
		and r0,r0,0xFF
	LoadMultipleIncrementAfter:
		ldmia sp!, {r4,r5,r6,r7,r8,r9,r10,pc}

	IncrementLoop:
		add r6, r6, 1h
	LoopCheck:
		cmp r6, r4
		ble ContinueLoop
	return:
		mov r0, 0h
		ldmia sp!,{r4,r5,r6,r7,r8,r9,r10,pc}

	.endarea
.close