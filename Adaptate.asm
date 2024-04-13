.nds
.open "overlay_0029.bin", 0x22DC240

    .org 0x23022c0
    .area 0x4
		b Adaptate
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33D80
.area 0x33F00 - 0x33D80

Adaptate:
	push r1-r5
	mov r0, r5
	mov r1, #24 ; Adaptate
	bl 0x2301d10
	cmp r0, 0h
	beq CheckSpecies
	ldr r1, =20a6004h
	ldrb r0, [r1]
	cmp r0, 1h
	bne CheckSpecies
	ldr r1, [r5, #+0xb4]
	ldrb r0, [r1, #+0x5f]
	cmp r0, 0h
	ldreqb r0, [r1, #+0x5e]
	pop r1-r5
	ldmia sp!, r3-r5, pc

CheckSpecies:
	ldr r1, [r5, #+0xb4]
	ldrh r0, [r1, #+0x2]
	ldr r1, =#550
    cmp r0, #96
    cmpne r0, #97
    movne r1, #696
    cmpne r0, r1
    addne r1, r1, #1
    beq SoulCheck
    sub r1, r1, #146  ; 550: Marowak-Alola
    cmp r0, r1
	addne r1, r1, 258h ; Marowak-Alola Female
    cmpne r0, r1
    beq BoneCheck
    sub r1, r1, #85 ; Zoroark-H Female
    cmp r0, r1
    subne r1, r1, 258h ; Zoroark-H
    cmpne r0, r1
    beq DazeCheck
    b return

BoneCheck:
    ldrh r0, [r4, 4h]
	ldr r1, =#285 ; Bone Rush
	cmp r0, r1
	addne r1, r1, 4h ; Bone Club
	cmpne r0, r1
	addne r1, r1, 1h ; Bonemerang
	cmpne r0, r1
	beq DazeType
	b return

SoulCheck:
	ldrh r0, [r4, 4h]
	ldr r1, =#331
	cmp r0, r1
	bne return
SoulType:
	ldr r1, [r5, #+0xb4]
	ldrb r0, [r1, #+0x5e]
	pop r1-r5
	ldmia sp!, r3-r5, pc

DazeCheck:
	ldrh r0, [r4, 4h]
	ldr r1, =#293
	cmp r0, r1
	bne return
DazeType:
	ldr r1, [r5, #+0xb4]
	ldrb r0, [r1, #+0x5f]
	pop r1-r5
	ldmia sp!, r3-r5, pc

return:
	pop r1-r5
	ldrh r1, [r4, 4h]
	b 0x23022c4

.pool
.endarea
.close