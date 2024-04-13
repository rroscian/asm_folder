.nds
.open "overlay_0029.bin", 0x22DC240

; Rewrite the Power Bonus
.org 0x2302328
.area 0x4
	b RewriteGinsengBoost
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33580
.area 0x33780 - 0x33580

RewriteGinsengBoost:
	ldrb r4, [r1, 7h] ; Base Instruction: Ginseng Boost -> Power Boost
	push r0-r3, r5-r7
	mov r7, r1 ; r7: Move Pointer
	push r0-r3
	mov r0, r2
	bl 0x20151C8
	cmp r0, #2 ; Status Moves get no power evolution
	pop r0-r3
	moveq r4, #0 ; No Power Boost
	beq return
	mov r5, #0 ; r5: Power Boost
	mov r6, r2 ; r6: Move ID
	cmp r4, #99
	addge r5, r5, #2
	cmp r4, #255
	beq SetUltimateEvolutionPower
	mov r0, r4
	mov r1, #6
	bl 0x0208FEA4 ; Euclidian Division
	add r4, r5, r0
	mov r0, r6
	bl 0x2013BE8 ; r0: Move Base Power
	cmp r0, #30
	addge r4, r4, r4 ; Strong Moves get a bigger power evolution
	cmp r0, #6
	bgt return
	; Weak Moves get a smaller power evolution
	mov r0, #3
	mul r0, r4, r0
	mov r1, #2
	bl 0x0208FEA4 ; Euclidian Division
	cmp r1, #0
	addgt r0, r0, #1
	mov r4, r0 
	b return

SetUltimateEvolutionPower:
	mov r0, r6
	bl 0x20139AC ; GetNbHits
	cmp r0, #1 ; Multi-Hit: Power Evolution
	movgt r4, #36
	bgt return
	mov r0, r6
	bl 0x2014C64 ; Is2TurnsMove
	cmp r0, #1
	moveq r4, #0
	beq return
	; Range Checks
	mov r0, r7 ; Move Pointer
	mov r1, 0x0
	bl 0x2013840
	; ret r0: move range*16 [0,15]
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	cmp r0, #0 ; Front
	moveq r4, #0
	beq return
	cmp r0, #1 ; 180°
	moveq r4, #176
	beq return
	cmp r0, #4
	moveq r4, #0
	beq return
	cmp r0, #8
	moveq r4, #0
	beq return
	cmp r0, #9
	moveq r4, #0
	beq return
	; Base Power Checks
	mov r0, r6
	bl 0x2013BE8 ; r0: Move Base Power
	cmp r0, #6 ; Low Power Moves: no evolution
	movle r4, #0
	movgt r4, #176

return:
	pop r0-r3, r5-r7
	b 0x230232c

.endarea
.close