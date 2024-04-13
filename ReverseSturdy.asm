.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x2309224
    .area 0x4
		ldrb r0,[r4,#0xc4]
    .endarea

.close