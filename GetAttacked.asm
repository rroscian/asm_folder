.nds
.open "arm9.bin", 0x2000000
.org 0x204d210
	.area 0x40
		ldr r3, [0x204d24c]
		mov r1, r0, asr 0x4
		add r2, r0, r1, lsr 0x1b
		mov r1, r0, lsr 0x1f
	; 	cmp r0, #552
	; 	movle r0, #1
	; 	movgt r0, #0
	; 	pop r3, pc
	.endarea

.org 0x205F794
	.area 0x8
		 cmp r6, #552
		 ble 0x205f774
	 .endarea
.close