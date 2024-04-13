.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x2332b20
    .area 0xC
		stmdb sp!,{r3-r9, lr}
		sub sp,sp,28h
		mov r5, r2
    .endarea

    .org 0x2332bb0
    .area 0x8
		add sp,sp,28h
		ldmia sp!,{r3-r9, pc}
    .endarea
.close