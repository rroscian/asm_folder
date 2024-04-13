.nds
.open "arm9.bin", 0x2000000

; Rewrite PP Bonus
.org 0x2013a58
.area 0x4
	b StoreGinsengBoost
.endarea

.org 0x2013ab4
.area 0x4
	b GetGinsengBoost
.endarea

.org 0x2013b20
.area 0x4
	b GinsengCritRate
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x32C00
.area 0x33000 - 0x32C00

; r0: move_dungeon_struct
; move PP: r0+6
; move ginseng: r0+7
StoreGinsengBoost:
	ldr r2, =MoveStrPointer
	str r0, [r2]
	ldrh r1, [r0, 4h]
	ldr r2, =MoveID
	strh r1, [r2]
	ldrb r1, [r0, 7h]
	ldr r2, =GinsengBoost
	strb r1, [r2]
	ldrh r0, [r0, 4h]
	b 0x2013a5c

GetGinsengBoost:
	push r1-r7
	mov r4, r0 ; r4: Move PPs
	mov r7, #0 ; r7: PP Bonus
	ldr r0, =MoveID
	ldrh r0, [r0]
	mov r5, r0
	ldr r1, =#457
	cmp r0, r1
	beq CalcMaxPP
	bl 0x2014E00 ; IsOHKOMove
	cmp r0, #1
	moveq r2, #99
	beq CalcMaxPP
	ldr r0, =GinsengBoost
	ldrb r0, [r0]
	cmp r0, #255
	beq SetUltimateEvolutionPP
	mov r1, #6
	bl 0x0208FEA4 ; Euclidian Division
	add r7, r7, r0
	ldr r1, =GinsengBoost
	ldrb r1, [r1]
	cmp r1, #99
	addge r0, r0, #2
	ldr r1, =#467
	cmp r5, r1
	moveq r2, #40
	beq CalcMaxPP
	push r1-r3
	ldr r0, =MoveStrPointer
	ldr r0, [r0]
	mov r1, 0x0
	bl 0x2013840
	; ret r0: move range*16 [0,15]
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	pop r1-r3
	; Determine Max PPs through evolution
	mov r2, #99
	cmp r0, #0
	addeq r7, r7, r7 ; Moves only hitting front targets get more PPs through evolution
	cmp r0, #1
	moveq r2, #30 ; 180°
	cmp r0, #2
	moveq r2, #30 ; 360°
	cmp r0, #3
	moveq r2, #30 ; Room
	cmp r0, #4
	moveq r2, #60 ; 2 tiles
	cmp r0, #5
	moveq r2, #30 ; Line of Sight
	cmp r0, #6
	moveq r2, #30 ; Floor
	cmp r0, #7
	moveq r2, #40 ; Range: User
	cmp r0, #9
	moveq r2, #60 ; 2 tiles, cuts corners
	mov r6, r2
	ldr r0, =MoveStrPointer
	ldr r0, [r0]
	bl 0x2013BE8 ; GetMoveBPWithID
	cmp r0, #10
	movge r2, #40
	bge CalcMaxPP
	cmp r0, #20
	movge r2, #30
	bge CalcMaxPP
	cmp r0, #40
	movge r2, #20
	bge CalcMaxPP
	mov r0, r5
	bl 0x2013E14 ; IsRecoilMove
	cmp r0, #1
	moveq r2, #30
	beq CalcMaxPP
	mov r0, r5
	bl 0x2014C64 ; Is2TurnsMove
	cmp r0, #1
	moveq r2, #30
	beq CalcMaxPP
	mov r0, r5
	bl 0x20139AC ; GetNbHits
	cmp r0, #1 ; Multi-Hit: No Accuracy Evolution
	moveq r2, #30
	beq CalcMaxPP
	mov r2, r6
	b CalcMaxPP

SetUltimateEvolutionPP:
	ldr r0, =MoveID
	ldrh r0, [r0]
	bl 0x20139AC ; GetNbHits
	cmp r0, #1 ; Multi-Hit: No Accuracy Evolution
	bgt ReducedPPEvolution
	; range checks
	ldr r1, =MoveID
	ldrh r0, [r1]
	bl 0x2014C64 ; Is2TurnsMove
	cmp r0, #1
	beq ReducedPPEvolution
	ldr r0, =MoveStrPointer
	ldr r0, [r0]
	mov r1, 0x0
	bl 0x2013840
	; ret r0: move range*16 [0,15]
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	cmp r0, #0
	bleq IncreasedPPEvolution
	cmp r0, #1
	beq ReducedPPEvolution
	cmp r0, #2
	beq ReducedPPEvolution
	cmp r0, #3
	beq ReducedPPEvolution
	cmp r0, #4
	bleq IncreasedPPEvolution
	cmp r0, #5
	beq ReducedPPEvolution
	cmp r0, #6
	beq ReducedPPEvolution
	cmp r0, #8
	bleq IncreasedPPEvolution
	cmp r0, #9
	bleq IncreasedPPEvolution
	; base power checks
	ldr r0, =MoveStrPointer
	ldr r0, [r0]
	bl 0x2013BE8 ; GetMoveBPWithID
	cmp r0, #6
	blle IncreasedPPEvolution
	cmp r0, #30
	bge ReducedPPEvolution
	b CalcMaxPP

IncreasedPPEvolution:
	push lr
	mov r4, #99
	mov r2, #99
	pop pc

ReducedPPEvolution:
	mov r2, #5
	sub r4, r4, r2
	mov r2, r4

CalcMaxPP:
	add r0, r4, r7
	cmp r0, r2
	movgt r0, r2
	pop r1-r7
	b 0x2013abc

MoveStrPointer:
	.word 0x0

MoveID:
	.dcw 0x0

GinsengBoost:
	.dcb 0x0
	.dcb 0x0

.pool
.endarea

; Crit Rate Evolution
.orga 0x33C00
.area 0x33E00 - 0x33C00

GinsengCritRate:
	bl 0x20a5f40 ; Original Instruction, r0: Crit Rate
	push r1-r3
	push r0
	ldr r1, =MoveID
	ldrh r0, [r1]
	bl 0x2014C64 ; Is2TurnsMove
	cmp r0, #1
	pop r0
	beq CheckUltimateCrit
	cmp r0, #8
	bgt CheckUltimateCrit
	b returnCrit

CheckUltimateCrit:
	ldr r1, =GinsengBoost
	ldrb r1, [r1]
	cmp r1, #255
	moveq r0, #30

returnCrit:
	pop r1-r3
	b 0x2013b24

.pool
.endarea
.close