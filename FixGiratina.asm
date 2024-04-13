.nds
.open "arm9.bin", 0x2000000
	.org 0x2051744
	.area 0x1C
		cmp r0, #81 ; World Abyss
		beq GoodReturn
		cmp r0, #93 ; Forgotten Inlet
		movne r0, #0
		bxne lr
	GoodReturn:
		mov r0, #1
		bx lr
	.endarea

	.org 0x20585dc
	.area 0xC
		bl 0x2051744
		cmp r0, #0
		popeq r4-r9, pc
	.endarea
.close