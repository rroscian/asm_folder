.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x233aae0
    .area 0x4
    	bl 0x233B028
    .endarea
.close