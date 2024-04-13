.nds
.open "arm9.bin", 0x2000000
.org 0x205091c
.area 0x8
	add r1, r1, 0x14
	add r1, r1, 0x4800
.endarea

.org 0x205093c
.area 0x8
	add r0, r0, 0x14
	add r0, r0, 0x4900
.endarea
.close