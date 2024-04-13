.nds
.open "overlay_0029.bin", 0x22DC240 
; 0x22DC240 is the load address of overlay_0029
	.org 0x22ee194
	.area 0x4
		b WTBusterCheck ; original instruction: mov r0, r9
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2E780
.area 0x2E7C0 - 0x2E780

WTBusterCheck:
	mov r0, r10 ; r10: Entity pointer
	bl 0x22E1628 ; Get Tile at entity
	ldr r0, [r0, 10h] ; Non-monster entity pointer in tile struct
	bl 0x22e1608 ; GetTrapInfo
	ldrb r0, [r0] ; Get trap ID
	cmp r0, 0x11 ; Wonder Tile
	beq 0x22ee1a4
	mov r0, r9
	b 0x22ee198

.endarea
.close