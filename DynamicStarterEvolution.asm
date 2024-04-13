.nds
.open "arm9.bin", 0x2000000

.org 0x2052AC4
.area 0x4
	b ChangeStarterEvo
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x30300
.area 0x30400 - 0x30300 ; Determine area later

; r2: evo struct
; r9: ground monster struct
; r9+2h: Origin ID (check 0xD6 et 0xD7)
; r9+6h: 1st evo level 
; CanEvolve: 0x205297C, r0; Pkmn ID -> ret: bool
; evo 1: type 3 (item), item ID = 427
; evo 2: type 3 (item), item ID = 428

ChangeStarterEvo:
	add r2, r1, 8h
	push r0-r3
	ldrb r0, [r9, 2h] ; Ground struct Origin ID
	cmp r0, #0xD6 ; Leader location
	cmpne r0, #0xD7 ; Partner location
	bne returnAll
	mov r0, #3 ; Item Evo
	strh r0, [r2, 2h] ; Evolution type in struct
	push r0-r3, lr
	ldrh r0, [r9, 4h] ; Ground struct Pokemon ID
	bl 0x205297C ; CanEvolve
	cmp r0, #0
	pop r0-r3, lr
	beq returnAll
	ldrb r0, [r9, 6h] ; 1st evo level
	cmp r0, #0 ; if not 0, has already evolved
	ldreq r0, =#427 ; Mark I
	ldrne r0, =#428 ; Mark II
	strh r0, [r2, 4h] ; Evolution item in struct
returnAll:
	pop r0-r3
	b 0x2052AC8
.pool
.endarea
.close