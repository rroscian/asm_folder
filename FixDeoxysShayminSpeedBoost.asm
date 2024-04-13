
.nds
.open "overlay_0029.bin", 0x22DC240
.org 0x22ffeb0
	.area 0xC
		ldrsh r1, [r6, 4h]
		ldr r0, [0x22fff1c]
		b AddSpeedFix
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2E760
	.area 0x10
	AddSpeedFix:
		cmp r1, 0x258
		addgt r0, r0, 0x258
		cmp r1, r0
		b 0x22ffebc
	.endarea
.close