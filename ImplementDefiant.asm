
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x231360c ; Store Attacker/Defender Attack hook
	.area 0x4
		b StoreUserAndTargetAtk
		; mov r8, r0
	.endarea

	.org 0x23137cc ; Offensive stat drop hook
	; r2: D91
	.area 0x4
		b ApplyOtherAbilitiesAtk 
		; b 0x023137e0
	.endarea

	.org 0x2313824 ; Store Attacker/Defender Defense hook
	.area 0x4
		b StoreUserAndTargetDef
		; mov r8, r0
	.endarea

	.org 0x2313960 ; Defensive stat drop hook
	; r2: D90
	.area 0x4
		b ApplyOtherAbilitiesDef
		; b 0x02313974
	.endarea

	.org 0x231423c ; Store Attacker/Defender Accuracy hook
	.area 0x4
		b StoreUserAndTargetAcc
		; mov r8, r3
	.endarea

	.org 0x2314394 ; Accuracy/Evasion drop hook
	; r2: D94
	.area 0x4
		b ApplyOtherAbilitiesAcc 
		; b 0x023143bc
	.endarea

	.org 0x23143a8 ; Accuracy/Evasion drop hook
	; r2: D92
	.area 0x4
		b ApplyOtherAbilitiesAcc
		; b 0x023143bc
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2FA00
.area 0x2FD00 - 0x2FA00

	StoreUserAndTargetAtk:
		mov r8, r0
		push r0-r3, r9
		mov r9, r13
		mov r0, r7
		mov r1, 0x81 ; Contrary ID
		bl 0x2301D10
		cmp r0, 1h
		mov r13, r9
		pop r0-r3, r9
		beq ApplyContraryAtk
		str r0, [UserPointer]
		str r1, [TargetPointer]
		cmp r0, r1
		beq 0x2313610
		push r0-r3, r9
		mov r9, r13
		mov r0, r7
		mov r1, #154 ; Mirror Armor
		bl 0x2301D10
		cmp r0, 1h
		movne r13, r9
		popne r0-r3, r9
		bne 0x2313610
		mov r0, r8
		mov r1, r7
		mov r7, r0
		mov r8, r1
	    ldr r1, =#1445
	    mov r0, r7
	    bl 0x234b2a4
	    mov r13, r9
	    pop r0-r3, r9
		mov r0, r8
		mov r1, r7
		b 0x2313610

	ApplyContraryAtk:   
		pop r4-r8, lr
	    pop r0-r3
	    ; AtkUp start
	    push r0-r3
	    push r3-r9, lr
	    mov r8, r1
	    b 0x23139a8 ; AttackStatUp

	StoreUserAndTargetDef:
		mov r8, r0
		push r0-r3, r9
		mov r9, r13
		mov r0, r7
		mov r1, 0x81 ; Contrary ID
		bl 0x2301D10
		cmp r0, 1h
	    mov r13, r9
	    pop r0-r3, r9
		beq ApplyContraryDef
		str r0, [UserPointer]
		str r1, [TargetPointer]
		cmp r0, r1
		beq 0x2313828
		push r0-r3, r9
		mov r9, r13
		mov r0, r7
		mov r1, #154 ; Mirror Armor
		bl 0x2301D10
		cmp r0, 1h
	    movne r13, r9
	    popne r0-r3, r9
		bne 0x2313828
		mov r0, r8
		mov r1, r7
		mov r7, r0
		mov r8, r1
	    ldr r1, =#1445
	    mov r0, r7
	    bl 0x234b2a4
	    mov r13, r9
	    pop r0-r3, r9
		mov r0, r8
		mov r1, r7
		b 0x2313828

	ApplyContraryDef:   
		pop r4-r8, lr
	    pop r0-r3
	    ; DefUp start
	    push r0-r3
	    push r3-r9, lr
	    mov r8, r1
	    b 0x2313b14 ; DefenseStatUp

	StoreUserAndTargetAcc:
		mov r8, r3
		push r0-r3, r9
		mov r9, r13
		mov r0, r6
		mov r1, 0x81 ; Contrary ID
		bl 0x2301D10
		cmp r0, 1h
	    mov r13, r9
	    pop r0-r3, r9
		beq ApplyContraryAcc
		str r0, [UserPointer]
		str r1, [TargetPointer]
		cmp r0, r1
		beq 0x2314240
		push r0-r3, r9
		mov r9, r13
		mov r0, r6
		mov r1, #154 ; Mirror Armor
		bl 0x2301D10
		cmp r0, 1h
	    movne r13, r9
	    popne r0-r3, r9
		bne 0x2314240
		mov r0, r7
		mov r1, r6
		mov r6, r0
		mov r7, r1
	    ldr r1, =#1445
	    mov r0, r7
	    bl 0x234b2a4
	    mov r13, r9
	    pop r0-r3, r9
		mov r0, r7
		mov r1, r6
		b 0x2314240

	ApplyContraryAcc:
		pop r4-r8, lr
	    pop r0-r3
	    ; FocusUp start
	    push r0-r3
	    push r4-r8, lr
	    mov r6, r1
	    b 0x23140f0 ; FocusStatUp


	ApplyOtherAbilitiesAtk:
		mov r0, #0
		b CheckStatLowered
	ApplyOtherAbilitiesDef:
		mov r0, #1
		b CheckStatLowered
	ApplyOtherAbilitiesAcc:
		mov r0, #2
	CheckStatLowered:
		push r0-r8, lr
		ldr r0, [UserPointer]
		ldr r1, [TargetPointer]
		cmp r0, r1
		beq AfterDropChecks
		ldr r0, [TargetPointer]
		mov r1, #150 ; Defiant ID
		bl 0x2301D10
		cmp r0, 1h
		beq ApplyDefiant
		ldr r0, [TargetPointer]
		mov r1, #151 ; Competitive ID
		bl 0x2301D10
		cmp r0, 1h
		beq ApplyCompetitive
		b AfterDropChecks

	ApplyDefiant:
	    ldr r1, =#1442
		ldr r0, [TargetPointer]
	    bl 0x234b2a4
		mov r2, #0
		b ApplyBoosts
	ApplyCompetitive:
	    ldr r1, =#1443
		ldr r0, [TargetPointer]
	    bl 0x234b2a4
		mov r2, #1
	ApplyBoosts:
		mov r3, #2
		ldr r0, [TargetPointer]
		ldr r1, [TargetPointer]
		bl 0x231399C ; BoostOffensiveStat

	AfterDropChecks:
		pop r0-r8, lr
		cmp r0, #0
		beq	0x023137e0 ; Atk return
		cmp r0, #1
		beq 0x02313974 ; Def return
		b 0x023143bc ; Acc return

.pool

	UserPointer:
		.word 0x0

	TargetPointer:
		.word 0x0

.endarea
.close