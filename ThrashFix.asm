
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x23228a8
	.area 0x8
		b 0x23228cc
		nop
	.endarea
.close