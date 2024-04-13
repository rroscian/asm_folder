.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x230b698
    .area 0x8
		bl CheckTypesCloudy
		nop
    .endarea

    .org 0x230b6e4
    .area 0x4
    	blne CheckTypesFoggy
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33F80
.area 0x34000 - 0x33F80

CheckTypesCloudy:
	cmp r8, #1
	beq 0x230b6c0
	cmp r8, #14
	beq 0x230b6c0
	bx lr

CheckTypesFoggy:
	cmp r8, #10
	bne 0x230b700
	bx lr

.endarea
.close