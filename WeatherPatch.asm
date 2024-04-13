.nds
.open "overlay_0029.bin", 0x22DC240
; Fix Flower Gift
; r4: Atk boost
; r5: Defender
; r10: Attacker
; r11: SpDef boost
	.org 0x230c00C
	.area 0x10
		nop
		ldrb r0, [r5, 34h]
		add r0, r0, 1h
		strb r0, [r5, 34h]
	.endarea

	.org 0x230c028
	.area 0x4
		bne 0x230c040
	.endarea

	.org 0x230c0f4
	.area 0x4
		bl HailCheck
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34080
.area 0x34100 - 0x34080

HailCheck:
	push r1-r4, lr
	mov r0, r9
	bl 0x2334d08 ; Weather Check
	cmp r0, #5
	bne return

CheckBoost:
	ldrb r0, [r7, 5Eh]
    cmp r0, 6h
    ldrne r0, [r7, 5Fh]
    cmpne r0, 6h
	ldreqb r0, [r5, 35h]
	addeq r0, r0, #2
	streqb r0, [r5, 35h]

return:
	mov r0, r9
	pop r1-r4, pc

.endarea
.close