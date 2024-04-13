.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x2335dc0
    .area 0x4
        add r0, r4, 90h
    .endarea
    
.close