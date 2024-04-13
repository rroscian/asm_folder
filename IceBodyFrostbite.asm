.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x2308e38
	.area 0x4
		beq IceBodyCheck ; beq 0x2308e80
	.endarea

	.org 0x2308e50
	.area 0x4
		beq IceBodyCheck ; beq 0x2308e80
	.endarea

	.org 0x2308e58
	.area 0x4
		bne IceBodyCheck ; beq 0x2308e80
	.endarea

	.org 0x2308e7c
	.area 0x4
		b IceBodyHook ; strhlt r1, [r0, #0x92]
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x30D00
.area 0x30E00 - 0x30D00

IceBodyHook:
	strlth r1, [r0, #0x92]
IceBodyCheck:
	mov r0, r10
	mov r1, r9
	mov r2, #0x4D ; Ice Body
	mov r3, #0x1
	bl 0x230a940 ; DefenderAbilityIsActive
	cmp r0, #0x0
	beq 0x2308e80 ; Check Stench
	ldr r1, [r9, #0xb4]
	ldrsh r0, [r6, #0x2]
	ldrsh r1, [r1, #0x2]
	bl 0x2054ec8
	cmp r0, #0x0
	beq 0x2308e80 ; Check Stench
	cmp r4, #0x0
	bne 0x2308e80
	mov r0, #0x64
	bl 0x22eaa98 ; RollRndmNumber
	cmp r0, #12 ; 12%, 23D7A3C
	addlt r0, r6, 0x100
	ldrlth r1, [r0, 92h]
	orrlt r1, r1, 0x200
	strlth r1, [r0, 92h]
	b 0x2308e80 ; Check Stench

.endarea
.close