.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x232eebc
    .area 0x8
		cmpeq r6, r0
		bne 0x232ef48
    .endarea
.close