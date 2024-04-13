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
		cmp r5, #242 ; Hyper Beam ID
		beq 0x2320BC0
		mov r3, #0
		b 0x2320BA0
	.endarea
.close