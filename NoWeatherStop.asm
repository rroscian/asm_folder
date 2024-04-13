
.nds
.open "overlay_0029.bin", 0x22DC240
.org 0x23101F4
	bl clearFlagAndCallDamageFunc
.org 0x2310290
	bl clearFlagAndCallDamageFunc
.org 0x234B6FC
	bl hook
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x1380
.area 0x13B8 - 0x1380
stopPlayerFlag:
.word 1
clearFlagAndCallDamageFunc:
	push lr
	mov r12, 0h
	str r12, [stopPlayerFlag]
	bl 0x230D11C ; Some variant of CalcDamage
	; Reset the flag, just in case the message didn't get printed in the end
	mov r0, 1h
	str r0, [stopPlayerFlag]
	pop pc

; Contitionally calls fn_EU_22F399C depending on whether the stop player flag is set. Resets the flag to 1.
hook:
	ldr r12, [stopPlayerFlag]
	cmp r12, 1h
	beq 0x22F2FE4 ; Makes the player stop running, among other things
	; Reset the flag and return
	mov r12, 1h
	str r12, [stopPlayerFlag]
	bx lr

.endarea
.close