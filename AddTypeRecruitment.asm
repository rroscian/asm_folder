.nds
.open "overlay_0029.bin", 0x22DC240

; Add Type-Recruitment Items
    .org 0x230dfb4
    .area 0x4
        beq HiHat
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33A00
.area 0x33E00 - 0x33A00

HiHat:
	mov r0, r8
	ldr r1, =HiHatID
	bl 0x230e578
	cmp r0, 0h
	beq Guitar
	mov r0, r7
	mov r1, 11h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Guitar:
	mov r0, r8
	ldr r1, =GuitarID
	bl 0x230e578
	cmp r0, 0h
	beq Didgeridoo
	mov r0, r7
	mov r1, 5h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0
 
Didgeridoo:
	mov r0, r8
	ldr r1, =DidgeridooID
	bl 0x230e578
	cmp r0, 0h
	beq Recorder
	mov r0, r7
	mov r1, 0Ch
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Recorder:
	mov r0, r8
	ldr r1, =RecorderID
	bl 0x230e578
	cmp r0, 0h
	beq Horn
	mov r0, r7
	mov r1, 0Bh
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Horn:
	mov r0, r8
	ldr r1, =HornID
	bl 0x230e578
	cmp r0, 0h
	beq Bass
	mov r0, r7
	mov r1, 0Fh
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Bass:
	mov r0, r8
	ldr r1, =BassID
	bl 0x230e578
	cmp r0, 0h
	beq Harp
	mov r0, r7
	mov r1, 10h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Harp:
	mov r0, r8
	ldr r1, =BassID
	bl 0x230e578
	cmp r0, 0h
	beq Box
	mov r0, r7
	mov r1, 12h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Box:
	mov r0, r8
	ldr r1, =BoxID
	bl 0x230e578
	cmp r0, 0h
	beq Oboe
	mov r0, r7
	mov r1, 1h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Oboe:
	mov r0, r8
	ldr r1, =OboeID
	bl 0x230e578
	cmp r0, 0h
	beq Phone
	mov r0, r7
	mov r1, 0Dh
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Phone:
	mov r0, r8
	ldr r1, =PhoneID
	bl 0x230e578
	cmp r0, 0h
	beq Gong
	mov r0, r7
	mov r1, 8h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0

Gong:
	mov r0, r8
	ldr r1, =GongID
	bl 0x230e578
	cmp r0, 0h
	beq 0x230dfd4
	mov r0, r7
	mov r1, 7h
	bl 0x2301e50
	cmp r0, 0h
	ldrne r0, =RecruitBoost
	ldrnesh r0, [r0,0h]
	addne r6, r6, r0
	b 0x230dfd4

	.pool
HiHatID:
    dcd 430
GuitarID:
    dcd 431
DidgeridooID:
    dcd 432
RecorderID:
    dcd 433
HornID:
    dcd 434
BassID:
    dcd 435
HarpID:
    dcd 436
BoxID:
    dcd 437
OboeID:
    dcd 438
PhoneID:
    dcd 439
GongID:
    dcd 440
RecruitBoost:
	dcd 200

.endarea
.close