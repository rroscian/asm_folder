.nds
.open "arm9.bin", 0x2000000
; // Use it with arm9
; Version with move shortcuts

.definelabel MoveStringIDStartL, 0xEE
.definelabel MoveStringIDStartH, 0x1F00
.definelabel PrintMoveString, 0x02013478
.definelabel MoveSPrintF, 0x02013758
.definelabel GetMovePP, 0x02013A50
.definelabel Is2TurnsMove, 0x02014C64
.definelabel GetStringFromFile, 0x020258C4
.definelabel MoveEmptyStruct, 0x02098D68
.definelabel MoveDispStrings, 0x02098DE4

.org MoveDispStrings
.area 0xC4
move_str_1:
	.ascii "[CS:M]%s[CR]",0
move_set:
	.ascii "[M:S2]",0
move_unset:
	.ascii "[M:S1]",0
move_add_pwr:
	.ascii "%s [CS:B]L.%d[CR]",0
move_max_pwr:
	.ascii "%s[M:I59]",0
move_ult_pwr:
	.ascii "[CS:P]%s[CR][M:T6]",0
move_str_2:
	.ascii "[CS:%c]%s%s[CLUM_SET:111]%2d[CLUM_SET:123]/[CLUM_SET:128]%2d[CR]",0
move_str_3:
	.ascii "%s %2d/%2d",0
shortcut_icon:
	.ascii "[M:B?]",0
no_shortcut:
	.ascii "[S:11]",0
.endarea

.org PrintMoveString
.area 0x2E0
	stmdb  r13!,{r3,r4,r5,r6,r7,r8,r14}
	sub  r13,r13,#0x40
	mov  r6,r1
	ldrb r1,[r6, #+0x0]
	mov  r7,r0
	mov  r5,r2
	tst r1,#0x20
	movne  r4,#0x57
	bne end_choice_1
	ldrh r0,[r6, #+0x2]
	tst r0,#0x1
	movne  r4,#0x57
	moveq  r4,#0x4D
end_choice_1:
	cmp r5,#0x0
	ldreq r5,=MoveEmptyStruct
	ldrb r0,[r5, #+0x8]
	cmp r0,#0x0
	movne  r4,#0x57
	bne end_choice_2
	ldrb r0,[r5, #+0x9]
	cmp r0,#0x0
	beq end_choice_2
	ldrh r0,[r6, #+0x4]
	bl Is2TurnsMove
	cmp r0,#0x0
	movne  r4,#0x57
end_choice_2:
	ldrh r0,[r6, #+0x4]
	add  r0,r0,MoveStringIDStartL
	add  r0,r0,MoveStringIDStartH
	bl GetStringFromFile
	str r0, [r13, #+0x0]
	; // Part related to ginseng bonus
	ldrb r3,[r6, #+0x7]
	b CalcLevel
afterCalcLevel:
	add r0,r13,#0x10
	ldr r2, [r13, #+0x0]
	str r0, [r13, #+0x0]
	bl MoveSPrintF
no_add:
	ldr r0,[r5, #+0x0]
	cmp r0,#0x5
	addls  r15,r15,r0,lsl #0x2
	b end_switch
	b case_0
	b case_1_2
	b case_1_2
	b case_3_4
	b case_3_4
	b case_5
case_0:
	mov  r0,r7
	ldr r1,=move_str_1
	ldr  r2,[r13, #+0x0]
	bl MoveSPrintF
	b end_switch
case_1_2:
	ldrb r1,[r6, #+0x0]
	mov  r0,r6
	tst r1,#0x2
	ldrne r8,=no_shortcut
	bne cancel_shortcut
	cmp r9,#4
	ldrge r8,=no_shortcut
	bge cancel_shortcut
	ldr r8,=shortcut_icon
	mov r1,'2'
	add r1,r1,r9
	strb r1,[r8, #+0x4]
cancel_shortcut:
	mov  r0,r6
	bl GetMovePP
	str r0,[r13, #+0x8]
	ldrb r3,[r6, #+0x6]
	str r3,[r13, #+0x4]
	ldr r1,=move_str_2
	mov  r2,r4
	mov  r0,r7
	mov  r3,r8
	bl MoveSPrintF
	b end_switch
case_3_4:
	ldrb r1,[r6, #+0x0]
	mov  r0,r6
	tst r1,#0x4
	ldrne r8,=move_set
	ldreq r8,=move_unset
	mov  r0,r6
	bl GetMovePP
	str r0,[r13, #+0x8]
	ldrb r3,[r6, #+0x6]
	str r3,[r13, #+0x4]
	ldr r1,=move_str_2
	mov  r2,r4
	mov  r0,r7
	mov  r3,r8
	bl MoveSPrintF
	b end_switch
case_5:
	mov  r4,r0
	mov  r0,r6
	bl GetMovePP
	ldr  r2,[r13, #+0x0]
	str r0,[r13, #+0x0]
	ldrb r3,[r6, #+0x6]
	ldr r1,=move_str_3
	mov  r0,r7
	bl MoveSPrintF
end_switch:
	add  r13,r13,#0x40
	ldmia  r13!,{r3,r4,r5,r6,r7,r8,r15}
	.pool
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34800
.area 0x34900 - 0x34800
; tous les niveaux en dessous de 10 on gagne +3% de puissance, entre 10 et 20 on gagne +6% de puissance, et au niveau max on gagne +10%
; tous les 5 niveaux on gagne 1 PP Max, au niveau max on gagne 2 PP Max
; tous les 10 niveaux on gagne +5% de précision, au niveau max on gagne +10% de précision)
CalcLevel:
; r3 = Ginseng Boost
; if r3 < 30, [3,5] = Lv1, [6,8]=lv2... [30,35]=lv10, [36,41]=lv11... [90,98]=lv20, [99,255] = Max
	push r6
	mov r6, r13
	push r0-r2, r4
	mov r4, r3
	mov r3, #0
	cmp r4, #255
	moveq r3, #69
	bge endCalcLevel
	cmp r4, #99
	movge r3, #21
	bge endCalcLevel
	cmp r4, #90
	movge r3, #20
	bge endCalcLevel
	cmp r4, #30
	addge r3, r3, #10
	push r3
	subge r0, r4, #30
	movge r1, #6
	movlt r0, r4
	movlt r1, #3
	bl 0x0208FEA4 ; Euclidian Division
	pop r3
	add r3, r3, r0

endCalcLevel:
	cmp r3, #0
	pop r0-r2, r4
	mov r13, r6
	pop r6
	beq no_add
	cmp r3, #69
	ldreq r1, =move_ult_pwr
	beq afterCalcLevel
	cmp r3, #21
	ldreq r1, =move_max_pwr
	; ldreq r1, =move_ult_pwr
	ldrne r1, =move_add_pwr
	b afterCalcLevel

.pool
.endarea
.close