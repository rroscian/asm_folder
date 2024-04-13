.nds
.open "overlay_0011.bin", 0x22DC240

	.org 0x22ffD0C
	.area 0x4
		beq CheckPassage
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2E600
.area 0x2E6C0 - 0x2E600

CheckPassage:
	push r1-r3
	mov r0, 0x1B
	bl 0x204CF9C
	cmp r0, #0
	pop r1-r3
	beq 0x22FFD60
	ldr r5, =ArrayFutureDungeon
	b 0x22ffd10
.pool

ArrayFutureDungeon:
	.dcw 0x1B
	.dcw 0x1C
	.dcw 0x1D
	.dcw 0x1E
	.dcw 0x1F
	.dcw 0x20
	.dcw 0x21
	.dcw 0x5D
	.dcw 0xAF
	.dcw 0xFFFF
.align
.endarea
.close