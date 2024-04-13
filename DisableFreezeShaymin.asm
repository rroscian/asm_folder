.nds

; Disables Shaymin reverting when frozen [US]

.open "overlay_0029.bin", 0x022DC240
	.org 0x02312DD8
	.area 0x28
		ldmia  r13!,{r3,r4,r5,r6,r7,r15}
		.fill 0x24,0xCC
	.endarea
.close