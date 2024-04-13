.nds
.open "arm9.bin", 0x2000000

; Rewrite PP Bonus
.org 0x2013a58
.area 0x4
	b StoreGinsengBoost
.endarea

.org 0x2013ab4
.area 0x4
	b GetGinsengBoost
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34700
.area 0x34800 - 0x34700

; r0: move_dungeon_struct
; move PP: r0+6
; move ginseng: r0+7
StoreGinsengBoost:
	ldrb r1, [r0, 7h]
	ldr r2, =GinsengBoost
	strb r1, [r2]
	ldrh r0, [r0, 4h]
	b 0x2013a5c

GetGinsengBoost:
	push r1-r4
	mov r4, r0
	ldr r0, =GinsengBoost
	ldrb r0, [r0]
	mov r1, #5
	bl 0x0208FEA4 ; Euclidian Division
	add r0, r4, r0
	ldr r1, =GinsengBoost
	ldrb r1, [r1]
	cmp r1, #99
	addge r0, r0, #2
	pop r1-r4
	cmp r0, #99
	movgt r0, #99
	b 0x2013abc

GinsengBoost:
	.dcb 0x0

.pool
.endarea
.close