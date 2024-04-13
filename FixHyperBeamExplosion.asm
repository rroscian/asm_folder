.nds
.open "overlay_0029.bin", 0x22DC240
	.org 0x2320b9c
	.area 0x4
		b CheckHyper
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
	.orga 0x2E840
	.area 0x40
	CheckHyper:
		mov r3, #242
		cmp r5, r3
		addne r3, r3, #213 ; Giga Impact
		cmpne r5, r3
		beq 0x2320BC0
		mov r3, #0
		b 0x2320BA0
	.endarea
.close