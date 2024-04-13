
.nds
.open "overlay_0010.bin", 0x22bca80

.org 0x22beda0
	.area 0x4
		b AddSparklyWind
	.endarea
.close

.open "overlay_0029.bin", 0x22DC240

.org 0x2325210
	.area 0x4
		cmp r0, 52h
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2E770
.area 0x10

AddSparklyWind:
	cmp r0, 52h
	cmpne r0, 0A8h
	b 0x22beda4
.endarea
.close