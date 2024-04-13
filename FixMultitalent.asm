
.nds
.open "arm9.bin", 0x2000000
	.org 0x02013a70
	.area 0x8
		lsrne r1, r0, 2h
		nop
	.endarea
.close