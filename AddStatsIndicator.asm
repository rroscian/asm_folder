.nds
.open "overlay_0029.bin", 0x22DC240
.org 0x22f1ad4
.area 0x4
	bl AddPopUpIndicators
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.org 0x23A75E8
.area 0x4
	str r0,[r1]
.endarea

.orga 0x35400
.area 0x35800-0x35400

AddPopUpIndicators:
	push r0-r8

ShowStats:
	ldr r4,=0x02353538
	ldr r5,=0x23DC19A
	ldrb r5, [r5]
    ldr r0,[r4]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0, r6
    bl 0x22E9600 ; Checks if the entity is valid
    cmp r0,1h
    bne return
	ldr r4,[r6, #+0xb4]
	; Atk Stat
	ldrb r2,[r4, #+0x1A]
    mov r0, #196
    mov r1, #24
    mov r3, #0
    bl 0x2335880
    ; SpAtk Stat
	ldrb r2,[r4, #+0x1B]
    mov r0, #196
    mov r1, #40
    mov r3, #0
    bl 0x2335880
    ; Def Stat
	ldrb r2,[r4, #+0x1C]
    mov r0, #196
    mov r1, #32
    mov r3, #0
    bl 0x2335880
    ; SpDef Stat
	ldrb r2,[r4, #+0x1D]
    mov r0, #196
    mov r1, #48
    mov r3, #0
    bl 0x2335880

; Get Boosts
ShowBoosts:
	; Atk boost
	ldrb r2,[r4, #+0x24]
	ldr r3,=atkBoost
	strh r2, [r3]
	mov r3, #10
	cmp r2, r3
	subge r2, r2, r3
	sublt r2, r3, r2
    mov r0, #236
    mov r1, #24
    mov r3, #0
    bl 0x2335880
	; Def boost
	ldrb r2,[r4, #+0x28]
	ldr r3,=defBoost
	strh r2, [r3]
	mov r3, #10
	cmp r2, r3
	subge r2, r2, r3
	sublt r2, r3, r2
    mov r0, #236
    mov r1, #32
    mov r3, #0
    bl 0x2335880
	; SpAtk boost
	ldrb r2,[r4, #+0x26]
	ldr r3,=spaBoost
	strh r2, [r3]
	mov r3, #10
	cmp r2, r3
	subge r2, r2, r3
	sublt r2, r3, r2
    mov r0, #236
    mov r1, #40
    mov r3, #0
    bl 0x2335880
	; SpDef boost
	ldrb r2,[r4, #+0x2A]
	ldr r3,=spdBoost
	strh r2, [r3]
	mov r3, #10
	cmp r2, r3
	subge r2, r2, r3
	sublt r2, r3, r2
    mov r0, #236
    mov r1, #48
    mov r3, #0
    bl 0x2335880
	; Acc boost
	ldrb r2,[r4, #+0x2C]
	ldr r3,=accBoost
	strh r2, [r3]
	mov r3, #10
	cmp r2, r3
	subge r2, r2, r3
	sublt r2, r3, r2
    mov r0, #236
    mov r1, #56
    mov r3, #0
    bl 0x2335880
	; Eva boost
	ldrb r2,[r4, #+0x2E]
	ldr r3,=evaBoost
	strh r2, [r3]
	mov r3, #10
	cmp r2, r3
	subge r2, r2, r3
	sublt r2, r3, r2
    mov r0, #236
    mov r1, #64
    mov r3, #0
    bl 0x2335880
    ; Speed boost
    ldrb r2,[r4, #+0x110]
    ldr r3,=speBoost
    strb r2,[r3]
    b AfterShowBoosts

atkBoost:
	.dcw 0x0
	.dcw 0x0
defBoost:
	.dcw 0x0
	.dcw 0x0
spaBoost:
	.dcw 0x0
	.dcw 0x0
spdBoost:
	.dcw 0x0
	.dcw 0x0
accBoost:
	.dcw 0x0
	.dcw 0x0
evaBoost:
	.dcw 0x0
	.dcw 0x0
speBoost:
	.dcb 0x0
	.dcb 0x0
	.dcw 0x0

AfterShowBoosts:
	sub r13,r13,40h
	ldr r5, =MapCoordinates
	mov r6, #0
LoopPrintSymbols:
	mov r0, sp        ; Pass the new render struct to function
    bl 0x201e730      ; This function initializes all fields of the struct
    ; Set tex_params
    ldr r0, =0x237ca8c
    ldrh r0, [r0]
    strh r0, [sp, #0x14]
    ; Set texture_offset
    mov r0, #0x1000
    str r0, [sp, #0x20]
	mov r0, #0x28
	strh r0, [sp, #0x2a]

	mov  r0, sp
    mov r1, #0 ; This parameters turns out to be the color offset
    push {r1}

    ldrb r1, [r5, r6]
    add r6, r6, #1
    ldrb r2, [r5, r6]
    add r6, r6, #1
    ldrb r3, [r5, r6]
    add r6, r6, #1
	bl 0x02335988
	add sp, sp, 4h

nextIterPrintSymbols:
	cmp r6, #21
	blt LoopPrintSymbols

	ldr r5,=atkBoost
	mov r6, #0
	mov r7, #24
	mov r4, #10
LoopPrintBoosts:
	mov r0, sp        ; Pass the new render struct to function
    bl 0x201e730      ; This function initializes all fields of the struct
    ; Set tex_params
    ldr r0, =0x237ca8c
    ldrh r0, [r0]
    strh r0, [sp, #0x14]
    ; Set texture_offset
    mov r0, #0x1000
    str r0, [sp, #0x20]
	mov r0, #0x28
	strh r0, [sp, #0x2a]

	mov  r0, sp
    mov r1, #0 ; This parameters turns out to be the color offset
    push {r1}

    mov r1, #228
    mov r2, r7
    ldrh r3, [r5, r6]
    cmp r3, r4
    movge r3, 0x25
    movlt r3, 0x26
    bl 0x02335988

    add sp, sp, 4h

nextIterPrintBoosts:
	cmp r6, #20
	addlt r6, r6, #4
	addlt r7, r7, #8
	blt LoopPrintBoosts

	ldr r4, =speBoost
	ldrb r4, [r4]
	mov r5, 0h
	; Y = 80
	mov r6, #196
LoopSpeedBoosts:
	cmp r5, r4
	beq Inverse

	mov r0, sp        ; Pass the new render struct to function
    bl 0x201e730      ; This function initializes all fields of the struct
    ; Set tex_params
    ldr r0, =0x237ca8c
    ldrh r0, [r0]
    strh r0, [sp, #0x14]
    ; Set texture_offset
    mov r0, #0x1000
    str r0, [sp, #0x20]
	mov r0, #0x28
	strh r0, [sp, #0x2a]

	mov  r0, sp
    mov r1, #0 ; This parameters turns out to be the color offset
    push {r1}

   	mov r1, r6
   	mov r2, #80
   	mov r3, 0x2F
    bl 0x02335988
    add r6, r6, #10
    add r5, r5, #1
    add sp, sp, #4
    b LoopSpeedBoosts

Inverse:
	; r1 = 236, r2 = 80, r3 = 2D
	push r0-r2
	mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3C
    bl 0x204B678
    cmp r0, 1h
    popne r0-r2
    bne returnAfterStack
    pop r0-r2
    mov r0, sp        ; Pass the new render struct to function
    bl 0x201e730      ; This function initializes all fields of the struct
    ; Set tex_params
    ldr r0, =0x237ca8c
    ldrh r0, [r0]
    strh r0, [sp, #0x14]
    ; Set texture_offset
    mov r0, #0x1000
    str r0, [sp, #0x20]
	mov r0, #0x28
	strh r0, [sp, #0x2a]

	mov  r0, sp
    mov r1, #0 ; This parameters turns out to be the color offset
    push {r1}

    mov r1, #236
    mov r2, #88
    mov r3, 0x2D
	bl 0x02335988
	add sp, sp, 4h
	b returnAfterStack

MapCoordinates:
	; Atk Stat indicator
	.dcb 0xB0
	.dcb 0x18
	.dcb 0x27
	; SpAtk Stat indicator
	.dcb 0xB0
	.dcb 0x28
	.dcb 0x28
	; Def Stat indicator
	.dcb 0xB0
	.dcb 0x20
	.dcb 0x2A
	; SpDef Stat indicator
	.dcb 0xB0
	.dcb 0x30
	.dcb 0x2B
	; Atk boost indicator
	;.dcb 0xB0
	;.dcb 0x50
	;.dcb 0x27
	; SpAtk boost indicator
	;.dcb 0xD0
	;.dcb 0x50
	;.dcb 0x28
	; Acc boost indicator
	.dcb 0xCC
	.dcb 0x38
	.dcb 0x29
	; Def boost indicator
	;.dcb 0xB0
	;.dcb 0x58
	;.dcb 0x2A
	; SpDef boost indicator
	;.dcb 0xD0
	;.dcb 0x58
	;.dcb 0x2B
	; Eva boost indicator
	.dcb 0xCC
	.dcb 0x40
	.dcb 0x2C
	; Speed indicator
	.dcb 0xB0
	.dcb 0x50
	.dcb 0x2E

	.dcb 0xFF
	.dcw 0xFFFF
.align

returnAfterStack:
	add r13,r13,40h
return:
	pop r0-r8
	ldr r0,=237c694h
	b 0x22f1ad8
.pool
.endarea
.close