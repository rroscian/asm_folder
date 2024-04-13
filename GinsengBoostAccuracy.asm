.nds
.open "overlay_0029.bin", 0x22DC240
; Rewrite the Accuracy Bonus
.org 0x2323C5C
.area 0xC
	bl RewriteGinsengAccuracyBoost
	mov r1, r3
	bl 0x2013a0c
.endarea
.close

; Ginseng Accuracy Boost
.open "overlay_0036.bin", 0x23A7080
.orga 0x33680
.area 0x33800 - 0x33680

RewriteGinsengAccuracyBoost:
	stmdb  r13!,{r1-r6,r14}
	mov r4, r1 ; Move Data Struct
	mov r5, #100 ; Accuracy Boost
	mov r6, r2 ; Accuracy Type
	ldrb r0, [r4, 7h]
	; cmp r0, #255
	; beq SetUltimateEvolutionAccuracy
	cmp r0, #15
	addge r5, r5, #3
	cmp r0, #30
	addge r5, r5, #3
	cmp r0, #60
	addge r5, r5, #3
	cmp r0, #90
	addge r5, r5, #3
	cmp r0, #99
	addge r5, r5, #6
AccuracyChecks:
	ldrh r0, [r4, 4h]
	bl 0x2014E00 ; IsOHKOMove
	cmp r0, #1
	beq ReduceAccuracyBoost
	mov r0, r4
	bl 0x20139AC ; GetNbHits
	cmp r0, #1
	bgt ReduceAccuracyBoost
	mov r0, r4
	mov r1, 0x0
	bl 0x2013840 ; GetMoveRange
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	cmp r0, #2
	beq ReduceAccuracyBoost
	cmp r0, #3
	beq ReduceAccuracyBoost
	cmp r0, #5
	beq ReduceAccuracyBoost
	cmp r0, #6
	beq ReduceAccuracyBoost
	b GetMoveAccuracy
ReduceAccuracyBoost:
	add r5, r5, #100
	mov r5, r5, lsr #1
GetMoveAccuracy:
	mov r0, r4
	mov r1, #0
	bl 0x2013A0C
	cmp r0, #100
	bgt perfect_accuracy
AccuracyCalc:
	mul r0, r0, r5
	mov r1, #100
	bl 0x208FEA4 ; Euclidian Division
	cmp r0, #100
	movgt r0, #100
perfect_accuracy:
	ldmia  r13!,{r1-r6,r15}
.endarea
.close