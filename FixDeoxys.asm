; Fixes Shiny Deoxys form swap
.nds
.open "arm9.bin", 0x2000000

	.org 0x2054B74
	.area 0x30
		ldr r2,=-418
		add r1,r0,r2
		cmp r1,3h
		movls r0,1
		bxls lr
		subhi r2,r2,258h
		addhi r0,r0,r2
		cmphi r0,3h
		movls r0,2
		movhi r0,0
		bx lr
		.pool ; 2 literals
	.endarea

	.org 0x2054C30
	.area 0xC
		cmp r0, 0h
		blne ChooseDeoxys
		popne r4, r15
	.endarea
.close

.nds
.open "overlay_0029.bin", 0x22DC240

    .org 0x22F7664
    .area 0x4
    	bl SelectDeoxys
    .endarea

    .org 0x22F7690
    .area 0x4
    	bl SelectBackDeoxys
    .endarea

    .org 0x22fd400
    .area 0x4
    	bne CheckDeoxysShiny
    .endarea
.close

; 22fd3f8: Deoxys ID read
; 22fd77c: Hardcoded Deoxys value
; 22df50c: Reading the data field containing all Deoxys forms (418 to 421)
; 23510c0: Data field containing Deoxys forms IDs
; 21c9b46: Deoxys Value
; 22F7668: -418
; 22F7690: Deoxys Value read

.open "overlay_0036.bin", 0x23A7080
.orga 0x34100
.area 0x34200 - 0x34100

ChooseDeoxys:
	cmp r0, 1h
	ldreq r0, [BaseDeoxys]
	ldrne r0, [ShinyDeoxys]
	bx lr

SelectDeoxys:
	push r1, lr
	ldr r1, [ShinyDeoxys]
	cmp r0, r1
	ldrne r0, =#-418
	moveq r0, #1
	ldreq r1, [FlagShinyDeoxys]
	ldreq r0, =#-1018
	pop r1, pc

SelectBackDeoxys:
	push r1, lr
	ldrsh r0, [r0, 3Ah]
	ldrb r1, [FlagShinyDeoxys]
	cmp r1, #1
	addeq r0, r0, 258h
	pop r1, pc

CheckDeoxysShiny:
	ldr r1, [ShinyDeoxys]
	cmp r0, r1
	bne 0x22fd420
	ldrb r0, [sp, 3Ch]
	cmp r0, #0
	ldrne r0, =2353538h
	ldrne r0, [r0]
	addne r0, r0, 3E00h
	ldrnesh r7, [r0, 3Ah]
	addne r7, r7, 258h
	moveq r7, r1
	b 0x22FD420

BaseDeoxys:
	.dcw 0x1A2
ShinyDeoxys:
	.dcw 0x3FA
FlagShinyDeoxys:
	.dcb 0x0
	.dcb 0x0

.pool
.endarea
.close