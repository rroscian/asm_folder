.nds
.open "overlay_0029.bin", 0x22DC240

; Base Instruction
; mov r0, #0xc
	.org 0x22fbe78
	.area 0x4
		b GetEntryLevel
	.endarea

; Base Instruction
; ldrsheq r0, [r1, r0]
	.org 0x23437f0
	.area 0x4
		ldreqsh r0, [r1, r0]
		; bleq GetEntryLevel
	.endarea

; Base Instruction
; ldrsh r1, [r1, r2]
	.org 0x2343FDC
	.area 0x8
		; bl GetEntryLevel
		ldrsh r1, [r1, r2]
		mov r2, r8
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x30E00
.area 0x31000 - 0x30E00

GetEntryLevel:
	mov r0, #0xc
	push r0-r2
	ldr r0, =2353538h
    ldr r0, [r0]
    add r0,r0,4000h
    ldrb r0,[r0,0DAh]
    cmp r0, #200
    moveq r1, #45
    cmp r0, #201
    moveq r1, #12
    cmp r0, #202
    moveq r1, #22
    cmp r0, #203
    moveq r1, #35
    cmp r0, #204
    moveq r1, #40
    cmp r0, #205
    moveq r1, #45
    cmp r0, #206
    moveq r1, #50
    cmp r0, #207
    moveq r1, #45
    cmp r0, #208
    moveq r1, #45
    cmp r0, #209
    moveq r1, #48
    cmp r0, #210
    moveq r1, #55
    cmp r0, #211
    moveq r1, #65
    cmp r0, #212
    moveq r1, #60
    cmp r0, #213
    moveq r1, #65
    cmp r0, #214
    moveq r1, #70
    cmp r0, #215
    moveq r1, #70
    cmp r0, #216
    moveq r1, #92
    cmp r0, #217
    moveq r1, #95
    cmp r0, #218
    moveq r1, #95
    cmp r0, #219
    moveq r1, #95
    cmp r0, #220
    moveq r1, #95
    cmp r0, #221
    moveq r1, #95
    cmp r0, #224
    moveq r1, #90
    cmp r0, #240
    moveq r1, #65
    cmp r0, #241
    moveq r1, #65
    cmp r0, #242
    moveq r1, #26
    cmp r0, #243
    moveq r1, #27
    cmp r0, #244
    moveq r1, #51
    cmp r0, #245
    moveq r1, #52
    cmp r0, #246
    moveq r1, #53
    cmp r0, #247
    moveq r1, #84
    cmp r0, #248
    moveq r1, #86
    ldr r2, =22C5AA0h
    strh r1, [r2]
return:
	pop r0-r2
	b 0x22fbe7c

.pool
.endarea
.close