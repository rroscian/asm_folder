.nds
.open "overlay_0011.bin", 0x022DC240

	.org 0x0230962C
	.area 0x2C
		ldrsh r4,[r5, #+0x4]
		b 0x0230962C+0x2C
		.fill 0x24, 0xCC
	.endarea

	.org 0x02309690
	.area 0x1C
		bl 0x020556A8
		cmp r4,r0
		blne 0x020556EC
		cmp r4,r0
		blne 0x02055730
		cmp r4,r0
		beq 0x023096D0
	.endarea
.close
