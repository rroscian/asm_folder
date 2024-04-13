.nds
.open "arm9.bin", 0x2000000

; Rewrite PP Bonus
.org 0x2013a58
.area 0x4
	b StoreStats
.endarea

.org 0x2013ab4
.area 0x4
	b GetGinsengBoost
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x342A0
.area 0x34400 - 0x342A0

; r0: move_dungeon_struct
; move PP: r0+6
; move ginseng: r0+7
StoreStats:
	push r1-r3
	ldr r3, =MoveStrPointer
	str r0, [r3]
	mov r3, r0
	ldrb r1, [r3, 7h]
	ldr r2, =GinsengBoost
	strb r1, [r2]
	ldrh r0, [r3, 4h]
	ldr r2, =MoveID
	strh r0, [r2]
	pop r1-r3
	b 0x2013a5c

GetGinsengBoost:
	push r1-r5
	mov r4, r0
	ldr r0, =MoveID
	ldrh r0, [r0]
	mov r5, r0
	ldr r1, =#457
	cmp r0, r1
	beq return
	mov r0, r5
	bl 0x2014E00 ; IsOHKOMove
	cmp r0, #1
	beq return
	ldr r0, =MoveStrPointer
	ldr r0, [r0]
	bl 0x2324534 ; IsPauseMove
	cmp r0, #1
	beq return
	ldr r0, =GinsengBoost
	ldrb r0, [r0]
	mov r1, #5
	bl 0x0208FEA4 ; Euclidian Division
	add r0, r4, r0
	ldr r1, =GinsengBoost
	ldrb r1, [r1]
	cmp r1, #99
	addge r0, r0, #2
	push r0
CheckMoveCategory:
	mov r0, r5
	bl 0x2013E14 ; IsRecoilMove
	cmp r0, #1
	moveq r2, #30
	beq CalcMaxPP
	mov r0, r5
	bl 0x2014C64 ; Is2TurnsMove
	cmp r0, #1
	moveq r2, #30
	beq CalcMaxPP
	mov r0, r5
	bl 0x2013BE8 ; GetMoveBPWithID
	cmp r0, #0
	moveq r2, #40
	beq CalcMaxPP
	cmp r0, #20
	moveq r2, #30
	beq CalcMaxPP
	mov r2, #99
; Calculation
CalcMaxPP:
	pop r0
	cmp r0, r2
	movgt r0, r2
return:
	pop r1-r5
	b 0x2013abc

MoveStrPointer:
	.dcd 0x0

GinsengBoost:
	.dcb 0x0

MoveID:
	.dcw 0x0

.pool
.endarea
.close