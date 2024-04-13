.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x23091e4
    .area 0x4
		bne CaseSturdy
    .endarea

.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34900
.area 0x34980 - 0x34900 ; Store it elsewhere

; "if pokémon has Sturdy 
; and currentHP == maxHP 
; and damage >= currentHP"
; then set damage to (currentHP - 1)
; and print a message saying the ability activated
; [r6]: damages to be dealt
; r7: target
; r8: user

CaseSturdy:
	push r4-r8, lr 
	mov r5, r1
	ldr r3, [r7, #+0xb4]
	ldrsh r0,[r3,10h]
    ldrsh r1,[r3,12h]
    ldrsh r2,[r3,16h]
	adds r1, r1, r2
	cmp r0, r1
	bne return
	cmp r0, r5
	bgt return
	sub r5,r0,1
    str r5,[r6]
    mov  r1,r7
    mov  r0,#0x1
    mov  r2,#0x0
    bl 0x022E2AD8
    mov  r0,r8 ; User
    mov  r1,r7 ; Target
    mov  r2,#0xC40
    bl 0x234B350
	.pool

return:
	pop r4-r8, lr
	b 0x2309224

.endarea
.close