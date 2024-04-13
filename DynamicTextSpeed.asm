.nds
.open "arm9.bin", 0x2000000
.org 0x2020c90
.area 0xC
	b DynamicText
	nop
	nop
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2FDC0
.area 0x2FE00 - 0x2FDC0

DynamicText:
	ldr r0, =22AB490h
	ldrb r0, [r0, 1h]
	cmp r0, #0
	moveq r0, #8
	b 0x2020c9c
.pool
.endarea
.close