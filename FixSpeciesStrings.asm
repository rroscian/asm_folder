
.nds
.open "arm9.bin", 0x2000000
.org 0x2052494
	.area 0x4
		bne CheckOtherNidoran
	.endarea
.close

.open "overlay_0029.bin", 0x22DC240 
.org 0x2300248
	.area 0x4
		ldrsh r1, [r4, #0x2]
	.endarea

.org 0x2300464
	.area 0x4
		ldrsh r1, [r5, #0x2]
	.endarea

.org 0x23173b4
	.area 0x4
		ldrsh r1, [r8, #0x2]
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2E5C0
	.area 0x40
	CheckOtherNidoran:
		cmpne r5, 0x20
		beq 0x205249c
		cmpne r5, 0x258
		blt 0x20524b0
		sub r5, r5, 258h
		cmp r5, 0x1d
		cmpne r5, 0x20
		bne 0x20524b0
		b 0x205249c
	.endarea
.close