
.nds
.open "arm9.bin", 0x2000000
	.org 0x0205B19C ; BeforeMenuComparisons
	.area 0x4
		bl ProtoHook3
	.endarea

	.org 0x205b320
	.area 0x8
		ldrne r11, [r11]
		ldrnesh r0, [r11, #0xa]
	.endarea
.close

.open "overlay_0029.bin", 0x22DC240 
.definelabel LogMessageByIdWithPopupCheckUser, 0x0234B2A4
.definelabel LogMessageByIdWithPopupCheckUserTarget, 0x0234B350
.definelabel DUNGEON_STRUCT_PTR, 0x2353538
.definelabel DIRECTIONS_XY, 0x0235171C
; 0x22DC240 is the load address of overlay_0029
	.org 0x0230C338 ; BeforeStatItemBoosts
	.area 0x4
		b ProtoHook1
	EndProtoHook1:
	.endarea

	.org 0x022F8AA4 ; PassMonsterPointer
	.area 0x4
		bl ProtoHook2
	.endarea

	.org 0x22f9204
	.area 0x4
		mov r1, r5
		; b CheckAbilityDifficulty
	.endarea

	.org 0x22fdea4
	.area 0x4
		b CheckAbilityDifficulty
	.endarea

	.org 0x2300F38
	.area 0x4
		mov r5, r1
	.endarea

	.org 0x22ff678
	.area 0x4
		mov r5, r0
	.endarea

	.org 0x22f9cf0
	.area 0x4
		ldrsh r0, [r5, #0x2]
	.endarea

	.org 0x231e798
	.area 0x4
		ldrsh r0, [r6, #0x2]
	.endarea

	.org 0x230106c
	.area 0x4
		ldrsh r1, [r2, #0x2]
	.endarea


	.org 0x02309B18 ; EndOfApplyDamage
	.area 0x4
		b ElectromorphosisHook
	EndElectroHook:
	.endarea

	.org 0x022FD2F4 ; CreateEnemyCheck
	.area 0x4
		bl CreateIllusionHook
	.endarea

	.org 0x022fc914 ; Spawn Team
	.area 0x4
		b CreateAllyIllusion
	.endarea

	.org 0x2301d00
	.area 0x4
		bne NeutralizingGas
	.endarea

	.org 0x02301944 ; SafeguardStart
	.area 0x4
		bl FlowerVeilHook1
	.endarea

	.org 0x02301b34 ; MistStart
	.area 0x4
		bl FlowerVeilHook2
	.endarea

	.org 0x2310210
	.area 0x4
		b OvercoatAndSandRushHook
	NoSandVeilOROvercoatORSandRush:
	.endarea

	.org 0x231019c
	.area 0x4
		b OvercoatAndSlushRushHook
	NoIceBodyOROvercoatORSlushRush:
	.endarea

	.org 0x023093b0 ; MotorDriveFail1
	.area 0x4
		beq SapSipperHook
	.endarea

	.org 0x023093bc ; MotorDriveFail2
	.area 0x4
		bne SapSipperHook
	.endarea

	.org 0x0231b6a4
	.area 0x4
		b UnnerveHook
	EndUnnerveHook:
	.endarea

	.org 0x2323d8c
	.area 0x8
		addne r10, r10
		b GuidingStar
	AfterGuidingStar:
	.endarea

	.org 0x232e928
	.area 0x4
		b ProteanHook
	.endarea

	.org 0x232ea24
	.area 0x8
		mov r4,r5
		b 0x232ee54
	.endarea

	; Lightning Rod
	.org 0x232ea60
	.area 0xC
		b SpAtkBoost2
		str r0, [r13,68h]
		b 0x232ee54
	.endarea

	; Storm Drain
	.org 0x232eaa0
	.area 0xC
		b SpAtkBoost
		str r0, [r13,64h]
		b 0x232ee54
	.endarea

	.org 0x232ef38
	.area 0x4
		beq 0x232ef48
	.endarea

	.org 0x232ef44
	.area 0x4
		bl 0x231b0a4 ; Original Frisk instruction
	.endarea

	.org 0x232f21c
	.area 0x4
		beq overcoat_powder_immunity
	.endarea

	.org 0x232f238
	.area 0x4
		beq overcoat_powder_immunity
	.endarea
	
	.org 0x232f248
	.area 0x4
		beq overcoat_powder_immunity
	.endarea
	
	.org 0x023249a0
	.area 0x4
		b SheerForceHook1; cmp r4,#0 ; b SheerForceHook1
	NoSheerForceEnd1:
	.endarea

	.org 0x02324a3c
	.area 0x4
		b SheerForceHook2 ;cmp r4,#0 ; b SheerForceHook2
	NoSheerForceEnd2:
	.endarea

	.org 0x02332b38
	.area 0x4
		bl SheerForceHook3 ; mov r4,r3 ; bl SheerForceHook3
	.endarea

	.org 0x23326cc
	.area 0x4
		b PoisonTouch
	.endarea

	.org 0x231cb4c
	.area 0x4
		beq CheckCheekPouch
	.endarea

	.org 0x231cb68
	.area 0x14
		b CalcMaxHPPouch
		mov r4, #1
		lsr r2, 3h
		mov r0, r8
		mov r1, r7
	.endarea

	.org 0x22f4878
	.area 0x4
		b GiveHeldItemGem
	.endarea

	.org 0x22f4988
	.area 0x4
		b TakeHeldItemGem
	.endarea

	.org 0x22f4b88
	.area 0x4
		mov r0, r7 ; b SwapHeldItemGem
	.endarea

	.org 0x22f9ef0
	.area 0x4
		b CheckHeldGemsAlly
	.endarea

	.org 0x230fdb8
	.area 0x4
		b CheckHeldGemsLeader
	.endarea

	.org 0x232a244
	.area 0x4
		bl CheckSuperWeather ; mov r1, #0
	.endarea

	.org 0x232a258
	.area 0x4
		bl PrintSuperWeather ; ldr r2, =EC5h
	.endarea

	.org 0x23260f4
	.area 0x4
		bl CheckSuperWeather ; mov r1, #0
	.endarea

	.org 0x2326108
	.area 0x4
		bl PrintSuperWeather ; ldr r2, =EC5h
	.endarea

	.org 0x2326150
	.area 0x4
		bl CheckSuperWeather ; mov r1, #0
	.endarea

	.org 0x2326164
	.area 0x4
		bl PrintSuperWeather ; ldr r2, =EC5h
	.endarea

	.org 0x2328a1c
	.area 0x4
		bl CheckSuperWeather ; mov r1, #0
	.endarea

	.org 0x2328a30
	.area 0x4
		bl PrintSuperWeather ; ldr r2, =EC5h
	.endarea

	.org 0x233507c
	.area 0x4
		bl TextSuperWeather
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
; 0x23A7080 is the load address of overlay_0036

	.orga 0xC000 ; where you want your code to be in overlay_0036
	.area 0xE000 - 0xC000 ; the range of where your code will be applied in overlay_0036

	TryActivateAdjacentAbility: ; r0 = Target, r1 = ability, r2 = flag (ally or enemy)
		push r4-r9,r12,r14
		mov r6,r0
		mov r8,r1
		mov r9,r2
		mov r5,#0
		ldr r4,=DIRECTIONS_XY
		b direction_loop_next_iter
	direction_loop:
		mov r1,r5,lsl #0x2
		add r0,r4,r5,lsl #0x2
		ldrsh r3,[r4,r1]
		ldrsh r12,[r6,#0x4]
		ldrsh r1,[r0,#0x2]
		ldrsh r2,[r6,#0x6]
		add r0,r12,r3
		add r1,r2,r1
		bl 0x023360FC ; GetTile
		ldr r0,[r0,#+0xC]
		mov r7,r0
		bl 0x022E0354 ; EntityIsValid
		cmp r0,#0
		beq direction_loop_nope
		; Okay, so the entity is valid. Is it our ally?
		ldr r0,[r7,#+0xB4]
		ldrb r1,[r0,#0x6]
		ldrb r2,[r0,#0x8]
		eor r0,r1,r2
		ldr r1,[r6,#+0xb4]
		ldrb r2,[r1,#0x6]
		ldrb r3,[r1,#0x8]
		eor r1,r2,r3
		cmp r0,r1
		bne adjacent_target_is_enemy
		; Ally
		cmp r9,#0
		bne direction_loop_nope
		b adjacent_ability_check
	adjacent_target_is_enemy:
		cmp r9,#0
		beq direction_loop_nope
		; Moment of truth, does it have the ability?
	adjacent_ability_check:
		mov r0,r7
		mov r1,r8
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		beq direction_loop_nope
		mov r0,#1
		pop r4-r9,r12,r15
	direction_loop_nope:
		add r5,r5,#1
	direction_loop_next_iter:
		cmp r5,#8
		blt direction_loop
		mov r0,#0
		pop r4-r9,r12,r15

	; 1: Primordial Sea, damaging Fire-moves fail to deal damage
	; 2: Desolate Land, damaging Water-moves fail to deal damage
	; 3: Delta Stream, Flying-types have a passive Filter

	; Protosynthesis
	ProtoHook1:
		; We have to check the attacker and the defender! r10 and r9, respectively
		; Power boost is at r13+#0x90 originally, so 0x94 in this function and 0x9C in ApplyProtosynthesisBoost...ldr r0, =DUNGEON_STRUCT_PTR
		ldr r0, =2353538h
		ldr r0, [r0]
	    ldrb r0, [r0, 748h]
	    bl 0x20514CC ; IsFutureDungeon
		cmp r0,#1
		bne proto_hook_ret1
	    mov r0, 0x0
	    mov r1, 0x4E
	    mov r2, 0x38
	    bl 0x204B678
	    cmp r0, 1h
	    beq proto_hook_ret1  
	    mov r1, 0x4E
	    mov r2, 0x39
	    bl 0x204B678
	    cmp r0, 1h
	    beq proto_hook_ret1
		mov r0,r10
		bl ApplyProtosynthesisBoost
	defender_check:
		mov r0,r9
		bl ApplyProtosynthesisBoost
	proto_hook_ret1:
		ldr r0,[r13,#+0x18] ; Original instruction
		b EndProtoHook1

	ApplyProtosynthesisBoost: ; r0 = Entity pointer
		ldr r2,[r0,#+0xb4]
		add r2,r2,0x1A
		mov r1,#3 ; 0 : Atk, 1 : Sp. Atk, 2 : Def, 3 : Sp. Def
		mov r0,#0
		mov r12,r1
	find_highest_stat_loop:
		ldrb r3,[r2,r1]
		cmp r3,r0
		movge r0,r3
		movge r12,r1
		subs r1,r1,#1
		bpl find_highest_stat_loop
		; Ensure we're boosting the right stat...
		ldr r2,[r13,#+0x18] ; 0 = Physical, 1 = Special
		and r1,r12,#0x1
		cmp r1,r2
		bxne r14
		; Okay, time to boost!
		cmp r12,#2 ; r12 = Index of highest stat
		; If Offenses, highest stat x5/4
	    addlt r1, r3, r3, lsl #2
		lsrlt r1,2h
		; If Defenses, highest stat x9/8
		addge r1, r3, r3, lsl #3
		lsrge r1, 3h
		sub r2, r1, r3
		mov r1,#0x90
		addge r1,r1,#4
		ldr r0,[r13,r1]
		add r0,r0,r2
		str r0,[r13,r1]
		ldr r1,=BOOST_BYTE_LOCATIONS
		ldrb r1,[r1,r12]
		; Atk is [r5,#0x30], Sp. Atk is [r5,#0x31], Def is [r5,#0x36], Sp. Def is Def is [r5,#0x37]
		ldrb r3,[r5,r1]
		add r3,r3,r2
		strb r3,[r5,r1]
		bx r14

	ProtoHook2:
		mov r0,r7 ; Original instruction
		ldr r12,=PROTO_PTR
		str r6,[r12]
		bx r14

	ProtoHook3:
		; r5 is some pointer to a Pokémon struct
		; 0x2 = Attack
		; 0x4 = Sp. Attack
		; 0x6 = Defense
		; 0x8 = Sp. Defense
		push r0-r3,r4,r6,r14
		strh r0,[r5] ; Original instruction
		mov r0,#34
		bl 0x02003ED0 ; OverlayIsLoaded
		ldr r4, =PROTO_PTR
		ldr r4, [r4]
		cmp r0,#0
		cmpne r4,#0
		popeq r0-r3,r4,r6,r15
		ldr r0, =DUNGEON_STRUCT_PTR
		ldr r0, [r0]
	    ldrb r0, [r0, 748h]
	    bl 0x20514CC ; IsFutureDungeon
		cmp r0,#1
		popne r0-r3,r4,r6,r15
	    mov r0, 0x0
	    mov r1, 0x4E
	    mov r2, 0x38
	    bl 0x204B678
	    cmp r0, 1h
		popeq r0-r3,r4,r6,r15 
	    mov r1, 0x4E
	    mov r2, 0x39
	    bl 0x204B678
	    cmp r0, 1h
		popeq r0-r3,r4,r6,r15
		ldr r2,[r4,#+0xb4]
		add r2,r2,0x1A
		mov r1,#3 ; 0 : Atk, 1 : Sp. Atk, 2 : Def, 3 : Sp. Def
		mov r0,#0
		mov r12,r1
	find_menu_max_loop:
		ldrb r3,[r2,r1]
		cmp r3,r0
		movge r0,r3
		movge r12,r1
		subs r1,r1,#1
		bpl find_menu_max_loop
		cmp r12,#2 ; r12 = Index of highest stat
		lsl r12,r12,#1
		add r12,r12,#2
		ldrh r0, [r5,r12]
		; If Offenses, highest stat x5/4
	    addlt r1, r3, r3, lsl #2
		lsrlt r1, 2h
		; If Defenses, highest stat x9/8
		addge r1, r3, r3, lsl #3
		lsrge r1, 3h
		sub r0, r1, r3
		strh r0, [r5,r12] ; 2-3: Atk, 4-5: Sp. Atk, 6-7: Def, 8-9: Sp. Def
		pop r0-r3,r4,r6,r15

	.pool

	; Electromorphosis
	ElectromorphosisHook:
		sub r13,r13,#0x10
		ldr r0,=#558
		cmp r5,r0
		bgt IllusionCheck
		mov r0,r8
		mov r1,r7
		mov r2, #157 ; Overload
		mov r3,#1
		bl 0x02332A0C ; DefenderAbilityIsActive
		cmp r0,#0
		beq IllusionCheck
		ldr r0,[r7,#+0xB4]
		ldrb r0,[r0,#+0xD2]
		cmp r0,#0xB
		beq IllusionCheck
		ldr r0,=#0xCD9
		bl 0x020258C4 ; StringFromMessageId
		str r0,[r13]
		mov r0,r7
		mov r1,r7
		mov r2,#0xB
		mov r3,#128
		bl 0x02318bbc ; SomeBidingFunction
		; Cool animation
		mov r0,r7
		ldr r1,=#0x1A5
		bl 0x022e42e8 ; LoadAndPlayAnimation

	IllusionCheck:
		add r13,r13,#0x10
		; Start of illusion code
		ldr r0,=#558
		cmp r5,r0
		bgt damage_ret ; If greater than the max move ID, then it's by some other cause and the illusion should not be broken.
		cmp r7,r8
		beq damage_ret ; We shouldn't break our own illusion!
		ldr r0,[r7,#+0xb4]
		add r0,r0,#0x60
		ldrb r2,[r0]
		; No Gastro Acid shenanigans, it seems pointless
		cmp r2, #0x7D ; First ability check!
		ldrneb r2, [r0, 0x1]
		cmpne r2, #0x7D ; Second ability check!
		bne damage_ret ; If neither, continue the ApplyDamage function!
		; Weird code, keep in check
		mov r2, #0
		strb r2, [r0] ; If Illusion, set the ability to null!
    	mov r0, 0x41 ; Hidden stairs animation
    	mov r1, r7
    	bl 0x23AF080
		mov r0,r7
		ldr r2,[r7,#+0xb4]
		ldrh r1,[r2,#+0x2]
		strh r1, [r2, 4h]
		bl ChangeMonsterSprite
		mov r2,#0
		ldr r0,[r7,#+0xb4]
		strb r2,[r0,#+0xEF]
		mov r0,#1
		mov r1,r7
		bl 0x022E2AD8 ; ChangeString
		mov r0,r7
		ldr r1, =#1454 ; Illusion wore off
		mov r2,#0
		bl 0x0234B498 ; SendMessageWithIDLog
		ldr r1,[r7,#+0xb4]
		ldrh r0, [r1,#+0x24]
		cmp r0, #0
		subne r0, r0, 1h
		strh r0, [r1,#+0x24]
		ldrh r0, [r1,#+0x26]
		cmp r0, #0
		subne r0, r0, 1h
		strh r0, [r1,#+0x26]
	damage_ret:
	    mov r0,#0x0 ; Vanilla instruction!
		b EndElectroHook

	CreateIllusionHook:
		; r4 = Enemy Entity Pointer
		push r8-r10, r14
		sub r13,r13,#0x240
		ldr r5, [r4,#+0xb4]
		ldrb r0, [r5,#+0x60]
		ldrb r1, [r5,#+0x61]
		cmp r0, #0x7D
		cmpne r1, #0x7D
		bne CheckImposter
		; getNbOfEntries
		mov r10, #0 ; 0 if Illusion
		b StartPartialCopy
	CheckImposter:
		cmp r0, #0xA6
		cmpne r1, #0xA6
		bne CheckGem
		mov r10, #1 ; 1 if Imposter

	StartPartialCopy:
		add r0,r13,#0x40
		mov r1,#0
		bl 0x022E7C60 ; MonsterSpawnListPartialCopy
		; ret: amount of species in the spawn table
		mov r6,r0
		add r11,r13,#0x40
		mov r7,#0 ; Counter!
	loop:
		; roll random value from number of entries
		mov r0,r6
		bl 0x022EAA98 ; DungeonRandInt
		add r0,r11,r0,lsl #0x3
		bl 0x2054480 ; GetMonsterIdFromSpawnEntry
		mov r1,r0
		mov r0,r4
		bl 0x022F9408 ; GetMonsterApparentId
		ldrsh r1, [r5,#+0x4]
		movs r8,r0
		ble next_iter
		cmp r0,r1
		beq next_iter
		strh r0, [r5,#+0x4]
		mov r0,r4
		mov r1,r8
		strh r8, [r5, 4h]
		bl ChangeMonsterSprite
		mov r0, #2
		strb r0, [r5,#+0xEF] ; Transformed byte
		mov r0, #0x7F
		strb r0, [r5,#+0xF0] ; Infinite duration
		cmp r10, #0 ; if Illusion
		bne ImposterEffects
		strh r0, [r5,#+0x24]
		strh r0, [r5,#+0x26]
		b ret
	ImposterEffects:
		ldrsh r0, [r5,#+0x4]
		mov r1, #0
		bl 0x2052A04 ; GetType
		strb r0, [r5, #+0x5E]
		ldrsh r0, [r5,#+0x4]
		mov r1, #1
		bl 0x2052A04 ; GetType
		strb r0, [r5, #+0x5F]
		mov r0, #1
		strb r0, [r5,#0xFF] ; Force the type to not change again
		ldrsh r0, [r5,#+0x4]
		mov r1, #0
		bl 0x2052A24 ; GetAbility
		strb r0, [r5, #+0x60]
		ldrsh r0, [r5,#+0x4]
		mov r1, #1
		bl 0x2052A24 ; GetAbility
		strb r0, [r5, #+0x61]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #0
		bl 0x22FE350 ; GetOffensiveStatAtLevel
		strb r0, [r5, #+0x1A]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #1
		bl 0x22FE350 ; GetOffensiveStatAtLevel
		strb r0, [r5, #+0x1B]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #0
		bl 0x22FE3B8 ; GetDefensiveStatAtLevel
		strb r0, [r5, #+0x1C]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #1
		bl 0x22FE3B8 ; GetDefensiveStatAtLevel
		strb r0, [r5, #+0x1D]
		ldr r0, =MoveIDList 
		ldrsh r1, [r5,#+0x4]
		ldrb r2, [r5,#+0xA]
		bl 0x2303B18 ; GetMonsterMoves
		ldr r6, =MoveIDList
		mov r4, #0
		add r5, r5, 124h
	LoopMoveset:
		add r0, r6, r4, lsl 1h
		ldrh r1, [r0] ; r1: Move ID
		mov r0, r5 ; r0: Move pointer
		bl 0x20137e8 ; InitMoveCheckId
		add r4, r4, #0x1
		cmp r4, #0x4
		addlt r5, r5, 8h
		blt LoopMoveset
		b ret

	MoveIDList:
		.word 0x0
		.word 0x0

	next_iter:
		cmp r7,#0x14 ; This should definitely be changed to something else; I don't know why I did the loop like this.
		addlt r7,r7,#1
		blt loop
		b ret

	CheckGem:
		ldrh r0, [r5,#+0x66] ; Item ID
		ldrh r1, [r5,#+0x4] ; Pokemon ID
		mov r3, #412
		add r3, r3, 2h
		mov r2, 570h ; ID 1392
		add r2, r2, 2h
		cmp r0, r2 ; Alpha Shard
		beq CheckKyogre
		add r2, r2, 1h
		add r3, r3, 1h
		cmp r0, r2 ; Omega Shard
		beq CheckGroudon
		add r2, r2, 1h
		add r3, r3, 1h
		cmp r0, r2 ; Delta Shard
		beq CheckRayquaza
		b ret

	CheckKyogre:
		mov r0, #552
		cmp r1, r3  ; Kyogre
		addeq r0, r0, #3 ; Base Primal form
		moveq r1, #1 ; Apparent 1: Kyogre
		beq SetApparentForm
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Kyogre
		addeq r0, r0, #6 ; Shiny Primal form
		moveq r1, #1
		beq SetApparentForm
		b ret

	CheckGroudon:
		mov r0, #552
		cmp r1, r3  ; Groudon
		addeq r0, r0, #4 ; Base Primal form
		moveq r1, #2 ; Apparent 2: Groudon
		beq SetApparentForm
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Groudon
		addeq r0, r0, #7 ; Shiny Primal form
		moveq r1, #2
		beq SetApparentForm
		b ret

	CheckRayquaza:
		mov r0, #552
		cmp r1, r3  ; Rayquaza
		addeq r0, r0, #5 ; Base Mega form
		moveq r1, #3 ; Apparent 3: Rayquaza
		beq SetApparentForm
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Rayquaza
		addeq r0, r0, #8 ; Shiny Mega form
		moveq r1, #3
		beq SetApparentForm
		b ret

	FloorStatusWord:
		.word 0x0

	SetApparentForm:
		str r1, [FloorStatusWord]
		strh r0, [r5, 4h]
		mov r1,r0
		mov r0,r4
		bl ChangeMonsterSprite
		mov r0,#2
		strb r0, [r5,#+0xEF] ; Transformed byte
		mov r0,#0x7F
		strb r0, [r5,#+0xF0] ; Infinite duration
		ldr r1, [FloorStatusWord]
		cmp r1, #1 ; Primal Kyogre
		moveq r0, #11
		streqh r0, [r5,#+0x26]
		streqh r0, [r5,#+0x2A]
		moveq r0, #12
		streqh r0, [r5,#+0x24]
		moveq r0, #252
		streqb r0, [r5, #+0x61]
		cmp r1, #2 ; Primal Groudon
		moveq r0, #11
		streqh r0, [r5,#+0x24]
		streqh r0, [r5,#+0x28]
		moveq r0, #12
		streqh r0, [r5,#+0x26]
		moveq r0, #2 ; Fire-type
		streqb r0, [r5, #+0x5F]
		moveq r0, #1
		streqb r0, [r5,#0xFF] ; Force the type to not change again
		moveq r0, #253
		streqb r0, [r5, #+0x61]
		cmp r1, #3 ; Mega Rayquaza
		moveq r0, #12
		streqh r0, [r5,#+0x24]
		streqh r0, [r5,#+0x26]
		moveq r0, #254
		streqb r0, [r5, #+0x61]

	ret:
		add r13,r13,#0x240
		mov r0,r4 ; Vanilla instruction.
		pop r8-r10, r15

	CheckSuperWeather:
		push r0, lr
		mov r1, #0
		ldr r0, [FloorStatusWord]
		cmp r0, #0
		movne r3, #0
		pop r0, pc

	PrintSuperWeather:
		push r0, lr
		ldr r2, [WeatherStringNoChange]
		ldr r0, [FloorStatusWord]
		add r2, r2, r0
		pop r0, pc

	WeatherStringNoChange:
		.word 0x0EC5

	TextSuperWeather:
		push r1, lr
		ldr r1, =FloorStatusWord
		ldrb r1, [r1]
		cmp r1, #0
		addne r0, r1, #0x25
		addeq r0, r0, #0x45
		pop r1, pc

	CreateAllyIllusion:
		ldr r0, [r0,#+0xb28]
		push r0-r11
		mov r10, r0
		ldr r5, [r0,#+0xb4]
		ldrb r0, [r5,#+0x60]
		ldrb r1, [r5,#+0x61]
		cmp r0, #0x7D
		cmpne r1, #0x7D
		bne CreateAllyImposter
		mov r0, r10
		ldr r1, =#383
		strh r1, [r5, 4h]
		bl ChangeMonsterSprite
		mov r0, #2
		strb r0, [r5,#+0xEF] ; Transformed byte
		mov r0, #2
		strb r0, [r5,#+0xEF] ; Transformed byte
		mov r0, #11
		strh r0, [r5,#+0x24]
		strh r0, [r5,#+0x26]
		mov r0, #0x7F
		strb r0, [r5,#+0xF0] ; Infinite duration
		b retAlly

	CreateAllyImposter:
		cmp r0, #0xA6
		cmpne r1, #0xA6
		bne CheckGemAlly
		; HERE
		sub r13,r13,#0x240
		add r0,r13,#0x40
		mov r1,#0
		bl 0x022E7C60 ; MonsterSpawnListPartialCopy
		; ret: amount of species in the spawn table
		mov r6,r0
		add r11,r13,#0x40
		mov r7,#0 ; Counter!
	loopImposter:
		; roll random value from number of entries
		mov r0,r6
		bl 0x022EAA98 ; DungeonRandInt
		add r0,r11,r0,lsl #0x3
		bl 0x2054480 ; GetMonsterIdFromSpawnEntry
		mov r1,r0
		mov r0,r4
		bl 0x022F9408 ; GetMonsterApparentId
		ldrsh r1, [r5,#+0x4]
		movs r8,r0
		ble next_iter_imposter
		cmp r0,r1
		beq next_iter_imposter
		mov r0,r10
		mov r1,r8
		strh r1, [r5, 4h]
		bl ChangeMonsterSprite
		mov r0,#2
		strb r0, [r5,#+0xEF] ; Transformed byte
		mov r0, #0x7F
		strb r0, [r5,#+0xF0] ; Infinite duration
		ldrsh r0, [r5,#+0x4]
		mov r1, #0
		bl 0x2052A04 ; GetType
		strb r0, [r5, #+0x5E]
		ldrsh r0, [r5,#+0x4]
		mov r1, #1
		bl 0x2052A04 ; GetType
		strb r0, [r5, #+0x5F]
		mov r0, #1
		strb r0, [r5,#0xFF] ; Force the type to not change again
		ldrsh r0, [r5,#+0x4]
		mov r1, #0
		bl 0x2052A24 ; GetAbility
		strb r0, [r5, #+0x60]
		ldrsh r0, [r5,#+0x4]
		mov r1, #1
		bl 0x2052A24 ; GetAbility
		strb r0, [r5, #+0x61]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #0
		bl 0x22FE350 ; GetOffensiveStatAtLevel
		strb r0, [r5, #+0x1A]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #1
		bl 0x22FE350 ; GetOffensiveStatAtLevel
		strb r0, [r5, #+0x1B]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #0
		bl 0x22FE3B8 ; GetDefensiveStatAtLevel
		strb r0, [r5, #+0x1C]
		ldrsh r0, [r5,#+0x4]
		ldrb r1, [r5,#+0xA]
		mov r2, #1
		bl 0x22FE3B8 ; GetDefensiveStatAtLevel
		strb r0, [r5, #+0x1D]
		ldr r0, =MoveIDListAlly
		ldrsh r1, [r5,#+0x4]
		ldrb r2, [r5,#+0xA]
		bl 0x2303B18 ; GetMonsterMoves
		ldr r6, =MoveIDListAlly
		mov r4, #0
		add r5, r5, 124h
	LoopMovesetAlly:
		add r0, r6, r4, lsl 1h
		ldrh r1, [r0] ; r1: Move ID
		mov r0, r5 ; r0: Move pointer
		bl 0x20137e8 ; InitMoveCheckId
		add r4, r4, #0x1
		cmp r4, #0x4
		addlt r5, r5, 8h
		blt LoopMovesetAlly
		add r13,r13,#0x240
		b retAlly

	MoveIDListAlly:
		.word 0x0
		.word 0x0

	next_iter_imposter:
		cmp r7,#0x14 ; This should definitely be changed to something else; I don't know why I did the loop like this.
		addlt r7,r7,#1
		blt loopImposter
		b retAlly

	CheckAbilityDifficulty:
		; r0: Pokémon ID
		; r1: 0 if Ability 1, 1 if Ability 2
		mov r1, r8
		push r0-r3
	    mov r0, 0x0
	    mov r1, 0x4E
	    mov r2, 0x38
	    bl 0x204B678
	    cmp r0, 1h
	    beq VanillaAbilities
	    mov r1, 0x4E
	    mov r2, 0x39
	    bl 0x204B678
	    cmp r0, 1h
	    bne ExpertAbilities
	    pop r0-r3
	    b 0x22fdea8

	CheckGemAlly:
		ldrh r0, [r5,#+0x66] ; Item ID
		ldrh r1, [r5,#+0x4] ; Pokemon ID
		mov r3, #412
		add r3, r3, 2h
		ldr r2, [AlphaShard]
		cmp r0, r2 ; Alpha Shard
		beq CheckAllyKyogre
		ldr r2, [OmegaShard]
		add r3, r3, 1h
		cmp r0, r2 ; Omega Shard
		beq CheckAllyGroudon
		ldr r2, [DeltaShard]
		add r3, r3, 1h
		cmp r0, r2 ; Delta Shard
		beq CheckAllyRayquaza
		ldr r2, [GriseousCore]
		add r3, r3, #113
		cmp r0, r2 ; Griseous Core
		beq CheckAllyGiratina
		b retAlly

	CheckAllyKyogre:
		mov r0, #552
		cmp r1, r3  ; Kyogre
		addeq r0, r0, #3 ; Base Primal form
		moveq r1, #1 ; Apparent 1: Kyogre
		beq SetAllyApparentForm
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Kyogre
		addeq r0, r0, #6 ; Shiny Primal form
		moveq r1, #1
		beq SetAllyApparentForm
		b retAlly

	CheckAllyGroudon:
		mov r0, #552
		cmp r1, r3  ; Groudon
		addeq r0, r0, #4 ; Base Primal form
		moveq r1, #2 ; Apparent 2: Groudon
		beq SetAllyApparentForm
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Groudon
		addeq r0, r0, #7 ; Shiny Primal form
		moveq r1, #2
		beq SetAllyApparentForm
		b retAlly

	CheckAllyRayquaza:
		mov r0, #552
		cmp r1, r3  ; Rayquaza
		addeq r0, r0, #5 ; Base Mega form
		moveq r1, #3 ; Apparent 3: Rayquaza
		beq SetAllyApparentForm
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Rayquaza
		addeq r0, r0, #8 ; Shiny Mega form
		moveq r1, #3
		beq SetAllyApparentForm
		b retAlly

	CheckAllyGiratina:
		cmp r1, r3
		addeq r0, r3, #7
		moveq r1, #6 ; Apparent 6: Giratina
		beq SetAllyApparentForm
		add r3, r3, 258h
		cmp r1, r3
		addeq r0, r3, #7
		moveq r1, #6 ; Apparent 6: Giratina
		beq SetAllyApparentForm
		b retAlly

	SetAllyApparentForm:
		str r1, [FloorStatusWord]
		mov r1,r0
		mov r0,r10
		bl ChangeMonsterSprite
		ldr r1, [FloorStatusWord]
		cmp r1, #1 ; Primal Kyogre
		moveq r0, #11
		streqh r0, [r5,#+0x26]
		streqh r0, [r5,#+0x2A]
		moveq r0, #12
		streqh r0, [r5,#+0x24]
		moveq r0, #252
		streqb r0, [r5, #+0x61]
		cmp r1, #2 ; Primal Groudon
		moveq r0, #11
		streqh r0, [r5,#+0x24]
		streqh r0, [r5,#+0x28]
		moveq r0, #12
		streqh r0, [r5,#+0x26]
		moveq r0, #253
		streqb r0, [r5, #+0x61]
		moveq r0, #2 ; Fire-type
		streqb r0, [r5, #+0x5F]
		moveq r0, #1
		streqb r0, [r5,#0xFF] ; Force the type to not change again
		cmp r1, #3 ; Mega Rayquaza
		moveq r0, #12
		streqh r0, [r5,#+0x24]
		streqh r0, [r5,#+0x26]
		moveq r0, #254
		streqb r0, [r5, #+0x61]
		cmp r1, #6 ; Giratina
		moveq r0, #55
		streqb r0, [r5, #+0x60]

	retAlly:
		pop r0-r11
		b 0x22fc918

	ChangeMonsterSprite: ; r0 = ent_ptr, r1 = target_species_id
		push r4-r6,r14
		mov r5,r0
		mov r4,r1
		mov r1,#1
		mov r0,r4
		bl 0x022F7654 ; LoadMonsterSprite
		mov r0,r4
		bl 0x022F7388 ; GetDungeonSpriteIndex
		strh r0, [r5,#+0xA8]
		mov r0,r5
		bl 0x02304BAC ; GetShadowSize
    	mov r0,r5
    	bl 0x02304AB4 ; GetSleepAnimationId
    	mov r1,r0
    	mov r0,r5
    	bl 0x02304830 ; UnkFunc6
		pop r4-r6,r15

	.pool

	; Neutralizing Gas
	NeutralizingGas:
		push r1-r3,r5-r6
		mov r5, #0
		mov r6, r4
	LoopCheckNeutralize:
		mov r0, r6
		mov r1, #160 ; Neutralizing Gas
		mov r2, r5
		bl TryActivateAdjacentAbility
		cmp r0, #1
		moveq r0, #0
		beq PopNeutralize
	NextIterNeutralize:
		add r5, r5, #1
		cmp r5, #2
		bne LoopCheckNeutralize
		mov r0, #1
	PopNeutralize:
		pop r1-r3,r5-r6
		b 0x2301d08

	; Sap Sipper
	SapSipperHook:
		mov r0,r8
		mov r1,r7
		mov r2,#161
		mov r3,#0x1
		bl 0x02332A0C ; DefenderAbilityIsActive
		cmp r0,#0
		beq NoSapSipper
		ldrb r0, [r6,#+0xC]
		cmp r0,#4
		bne NoSapSipper
		mov r2,#0
		; str r2,[r13]
		mov r3,#1
		mov r0,r8
		mov r1,r7
		bl 0x0231399c ; AttackStatUp
		mov r0,#1
		strb r0, [r6,#+0x10]
		mov r0,#0
		b 0x0230a918 ; ApplyDamageRet

	NoSapSipper:
		ldr r0, [FloorStatusWord]
		cmp r0, #1
		beq PrimordialSea
		cmp r0, #2
		beq DesolateLand
		b 0x023093d8

	PrimordialSea:
		ldrb r0, [r6, #+0xC]
		cmp r0, #2 ; Fire-type
		bne 0x023093d8
		mov r0,r8
		ldr r1,=#1455
		bl LogMessageByIdWithPopupCheckUser
		mov r0,#1
		strb r0,[r6,#+0x10]
		mov r0,#0
		b 0x0230a918 ; ApplyDamageRet

	DesolateLand:
		ldrb r0, [r6, #+0xC]
		cmp r0, #3 ; Water-type
		bne 0x023093d8
		mov r0,r8
		ldr r1,=#1456
		bl LogMessageByIdWithPopupCheckUser
		mov r0, #0
		b 0x0230a918

	GiveHeldItemGem:
		push r0-r3
		ldrh r0, [r9, 0x66]
		ldrh r1, [r9,#+0x2] ; Pokemon ID

		mov r3, #412
		add r3, r3, #2
		ldr r2, [AlphaShard]
		cmp r0, r2
		beq CheckKyogreHeld
		add r3, r3, #1
		ldr r2, [OmegaShard]
		cmp r0, r2
		beq CheckGroudonHeld
		add r3, r3, #1
		ldr r2, [DeltaShard]
		cmp r0, r2
		beq CheckRayquazaHeld
		add r3, r3, #113
		ldr r2, =#1399
		cmp r0, r2
		beq CheckGiratinaHeld
	CheckWasTransformedHeld:
		mov r3, #412
		add r2, r3, #2
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r2, #113
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r3, 258h
		add r2, r2, #2
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedHeld
		add r2, r2, #113
		cmp r1, r2
		beq CheckTransformedHeld
	ReturnGiveItemGem:
		pop r0-r3
		mov r0, r4
		b 0x22f487c

	CheckTransformedHeld:
		ldrh r2, [r9,#+0x4]
		cmp r1, r2
		beq ReturnGiveItemGem
		mov r3, #560 ; Rayquaza
		cmp r2, r3
		subne r3, r3, 3h
		cmpne r2, r3
		ldreqh r0, [r9, #+0x24]
		subeq r0, r0, 2h
		streqh r0, [r9,#+0x24]
		ldreqh r0, [r9, #+0x26]
		subeq r0, r0, 2h
		streqh r0, [r9,#+0x26]
		sub r3, r3, 1h ; Groudon
		cmp r2, r3
		subne r3, r3, 3h
		cmpne r2, r3
		ldreqh r0, [r9, #+0x26]
		subeq r0, r0, 2h
		streqh r0, [r9,#+0x26]
		ldreqh r0, [r9, #+0x24]
		subeq r0, r0, 1h
		streqh r0, [r9,#+0x24]
		ldreqh r0, [r9, #+0x28]
		subeq r0, r0, 1h
		streqh r0, [r9,#+0x28]
		sub r3, r3, 1h ; Kyogre
		cmp r2, r3
		subne r3, r3, 3h
		cmpne r2, r3
		ldreqh r0, [r9, #+0x24]
		subeq r0, r0, 2h
		streqh r0, [r9,#+0x24]
		ldreqh r0, [r9, #+0x26]
		subeq r0, r0, 1h
		streqh r0, [r9,#+0x26]
		ldreqh r0, [r9, #+0x2A]
		subeq r0, r0, 1h
		streqh r0, [r9,#+0x2A]
		ldrsh r0, [r9,#+0x2]
		mov r1, #1
		bl 0x2052A24 ; GetAbility
		strb r0, [r9, #+0x61]
		mov r1, #0
		str r1, [FloorStatusWord]
		ldr r1, =#1462
		mov r3, #544
		sub r3, r3, #8
		cmp r2, r3
		subeq r1, r1, #1
		add r3, r3, 258h
		cmp r2, r3
		subeq r1, r1, #1
		mov r0, r4
		bl LogMessageByIdWithPopupCheckUser
		mov r0,r4
		mov r1,#147
		bl 0x022e42e8 ; LoadAndPlayAnimation
		mov r0, r4
		ldrh r1, [r9,#+0x2]
		strh r1, [r9,#+0x4]
		bl ChangeMonsterSprite
		b ReturnGiveItemGem

	CheckKyogreHeld:
		mov r0, #552
		cmp r1, r3  ; Kyogre
		addeq r0, r0, #3 ; Base Primal form
		moveq r1, #1 ; Apparent 1: Kyogre
		beq SetAllyTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Kyogre
		addeq r0, r0, #6 ; Shiny Primal form
		moveq r1, #1
		beq SetAllyTransformation
		b CheckWasTransformedHeld

	CheckGroudonHeld:
		mov r0, #552
		cmp r1, r3  ; Groudon
		addeq r0, r0, #4 ; Base Primal form
		moveq r1, #2 ; Apparent 2: Groudon
		beq SetAllyTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Groudon
		addeq r0, r0, #7 ; Shiny Primal form
		moveq r1, #2
		beq SetAllyTransformation
		b CheckWasTransformedHeld

	CheckRayquazaHeld:
		mov r0, #552
		cmp r1, r3  ; Rayquaza
		addeq r0, r0, #5 ; Base Primal form
		moveq r1, #3 ; Apparent 3: Rayquaza
		beq SetAllyTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Rayquaza
		addeq r0, r0, #8 ; Shiny Primal form
		moveq r1, #3
		beq SetAllyTransformation
		b CheckWasTransformedHeld

	CheckGiratinaHeld:
		cmp r1, r3  ; Giratina
		addeq r0, r1, #7 ; Base Origin form
		moveq r1, #6 ; Apparent 6: Giratina
		beq SetAllyTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Giratina
		addeq r0, r1, #7 ; Shiny Primal form
		moveq r1, #6
		beq SetAllyTransformation
		b CheckWasTransformedHeld

	SetAllyTransformation:
		str r1, [FloorStatusWord]
		push r0-r3
		mov r0,r4
		mov r1,#147
		bl 0x022e42e8 ; LoadAndPlayAnimation
		pop r0-r3
		mov r1,r0
		mov r0,r4
		strh r1, [r9, 4h]
		bl ChangeMonsterSprite
		ldr r1, [FloorStatusWord]
		cmp r1, #1 ; Primal Kyogre
		ldreqh r0, [r9, #+0x26]
		addeq r0, r0, 1h
		streqh r0, [r9,#+0x26]
		ldreqh r0, [r9, #+0x2A]
		addeq r0, r0, 1h
		streqh r0, [r9,#+0x2A]
		ldreqh r0, [r9, #+0x24]
		addeq r0, r0, 2h
		streqh r0, [r9,#+0x24]
		moveq r0, #252
		streqb r0, [r9, #+0x61]
		; DoRainDance
		moveq r0, r4
		ldreq r1, =#1457
		bleq LogMessageByIdWithPopupCheckUser
		moveq r0, r4
		moveq r1, r4
		moveq r2, #12
		moveq r3, #0
		bleq 0x23260D0 ; DoMoveRainDance
		beq ReturnGiveItemGem
		cmp r1, #2 ; Primal Groudon
		ldreqh r0, [r9, #+0x24]
		addeq r0, r0, 1h
		streqh r0, [r9,#+0x24]
		ldreqh r0, [r9, #+0x28]
		addeq r0, r0, 1h
		streqh r0, [r9,#+0x28]
		ldreqh r0, [r9, #+0x26]
		addeq r0, r0, 2h
		streqh r0, [r9,#+0x26]
		moveq r0, #253
		streqb r0, [r9, #+0x61]
		moveq r0, #2 ; Fire-type
		streqb r0, [r9, #+0x5F]
		moveq r0, #1
		streqb r0, [r9,#0xFF] ; Force the type to not change again
		; DoSunnyDay
		moveq r0, r4
		ldreq r1, =#1458
		bleq LogMessageByIdWithPopupCheckUser
		moveq r0, r4
		moveq r1, r4
		moveq r2, #223
		moveq r3, #0
		bleq 0x232A220 ; DoMoveSunnyDay
		beq ReturnGiveItemGem
		cmp r1, #3 ; Mega Rayquaza
		ldreqh r0, [r9, #+0x24]
		addeq r0, r0, 2h
		streqh r0, [r9,#+0x24]
		ldreqh r0, [r9, #+0x26]
		addeq r0, r0, 2h
		streqh r0, [r9,#+0x26]
		moveq r0, #254
		streqb r0, [r9, #+0x61]
		moveq r0, r4
		ldreq r1, =#1459
		bleq LogMessageByIdWithPopupCheckUser
		cmp r1, #6 ; Giratina Origin
		moveq r0, #55
		streqb r0, [r9, #+0x60]
		moveq r0, r4
		ldreq r1, =#1460
		bleq LogMessageByIdWithPopupCheckUser
		b ReturnGiveItemGem
/*
	SwapHeldItemGem:
		push r0-r3
		ldrh r0, [r5, 0x66]
		ldrh r1, [r5,#+0x2] ; Pokemon ID
		mov r3, #412
		add r3, r3, #2
		ldr r2, [AlphaShard]
		cmp r0, r2
		beq CheckKyogreSwap
		add r3, r3, #1
		ldr r2, [OmegaShard]
		cmp r0, r2
		beq CheckGroudonSwap
		add r3, r3, #1
		ldr r2, [DeltaShard]
		cmp r0, r2
		beq CheckRayquazaSwap
		add r3, r3, #113
		ldr r2, =#1399
		cmp r0, r2
		beq CheckGiratinaSwap
	CheckWasTransformedSwap:
		mov r3, #412
		add r2, r3, #2
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r2, #113
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r3, 258h
		add r2, r2, #2
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedSwap
		add r2, r2, #113
		cmp r1, r2
		beq CheckTransformedSwap
	ReturnSwapItemGem:
		pop r0-r3
		mov r0, r7
		b 0x22f4b8c

	CheckTransformedSwap:
		ldrh r2, [r7,#+0x4]
		cmp r1, r2
		beq ReturnSwapItemGem
		ldr r1, =#1462
		mov r3, #544
		sub r3, r3, #8
		cmp r2, r3
		subeq r1, r1, #1
		add r3, r3, 258h
		cmp r2, r3
		subeq r1, r1, #1
		mov r0, r4
		bl LogMessageByIdWithPopupCheckUser
		mov r0,r4
		mov r1,#147
		bl 0x022e42e8 ; LoadAndPlayAnimation
		mov r0, r4
		ldrh r1, [r7,#+0x2]
		bl ChangeMonsterSprite
		b ReturnSwapItemGem

	CheckKyogreSwap:
		mov r0, #552
		cmp r1, r3  ; Kyogre
		addeq r0, r0, #3 ; Base Primal form
		moveq r1, #1 ; Apparent 1: Kyogre
		beq SetSwapTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Kyogre
		addeq r0, r0, #6 ; Shiny Primal form
		moveq r1, #1
		beq SetSwapTransformation
		b CheckWasTransformedSwap

	CheckGroudonSwap:
		mov r0, #552
		cmp r1, r3  ; Groudon
		addeq r0, r0, #4 ; Base Primal form
		moveq r1, #2 ; Apparent 2: Groudon
		beq SetSwapTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Groudon
		addeq r0, r0, #7 ; Shiny Primal form
		moveq r1, #2
		beq SetSwapTransformation
		b CheckWasTransformedSwap

	CheckRayquazaSwap:
		mov r0, #552
		cmp r1, r3  ; Rayquaza
		addeq r0, r0, #5 ; Base Primal form
		moveq r1, #3 ; Apparent 3: Rayquaza
		beq SetSwapTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Rayquaza
		addeq r0, r0, #8 ; Shiny Primal form
		moveq r1, #3
		beq SetSwapTransformation
		b CheckWasTransformedSwap

	CheckGiratinaSwap:
		cmp r1, r3  ; Giratina
		addeq r0, r1, #7 ; Base Origin form
		moveq r1, #6 ; Apparent 6: Giratina
		beq SetSwapTransformation
		add r3, r3, 258h
		cmp r1, r3 ; Shiny Giratina
		addeq r0, r1, #7 ; Shiny Primal form
		moveq r1, #3
		beq SetSwapTransformation
		b CheckWasTransformedSwap

	SetSwapTransformation:
		str r1, [FloorStatusWord]
		push r0-r3
		mov r0,r4
		mov r1,#147
		bl 0x022e42e8 ; LoadAndPlayAnimation
		pop r0-r3
		mov r1,r0
		mov r0,r4
		bl ChangeMonsterSprite
		ldr r1, [FloorStatusWord]
		cmp r1, #1 ; Primal Kyogre
		ldreqh r0, [r5, #+0x26]
		addeq r0, r0, 1h
		streqh r0, [r5,#+0x26]
		ldreqh r0, [r5, #+0x2A]
		addeq r0, r0, 1h
		streqh r0, [r5,#+0x2A]
		ldreqh r0, [r5, #+0x24]
		addeq r0, r0, 2h
		streqh r0, [r5,#+0x24]
		moveq r0, #252
		streqb r0, [r5, #+0x61]
		; DoRainDance
		moveq r0, r4
		ldreq r1, =#1457
		bleq LogMessageByIdWithPopupCheckUser
		moveq r0, r7
		moveq r1, r7
		moveq r2, #12
		moveq r3, #0
		bleq 0x23260D0 ; DoMoveRainDance
		beq ReturnSwapItemGem
		cmp r1, #2 ; Primal Groudon
		ldreqh r0, [r5, #+0x24]
		addeq r0, r0, 1h
		streqh r0, [r5,#+0x24]
		ldreqh r0, [r5, #+0x28]
		addeq r0, r0, 1h
		streqh r0, [r5,#+0x28]
		ldreqh r0, [r5, #+0x26]
		addeq r0, r0, 2h
		streqh r0, [r5,#+0x26]
		moveq r0, #253
		streqb r0, [r5, #+0x61]
		moveq r0, #2 ; Fire-type
		streqb r0, [r5, #+0x5F]
		moveq r0, #1
		streqb r0, [r5,#0xFF] ; Force the type to not change again
		; DoSunnyDay
		moveq r0, r4
		ldreq r1, =#1458
		bleq LogMessageByIdWithPopupCheckUser
		moveq r0, r4
		moveq r1, r4
		moveq r2, #223
		moveq r3, #0
		bleq 0x232A220 ; DoMoveSunnyDay
		beq ReturnSwapItemGem
		cmp r1, #3 ; Mega Rayquaza
		ldreqh r0, [r5, #+0x24]
		addeq r0, r0, 2h
		streqh r0, [r5,#+0x24]
		ldreqh r0, [r5, #+0x26]
		addeq r0, r0, 2h
		streqh r0, [r5,#+0x26]
		moveq r0, #254
		streqb r0, [r5, #+0x61]
		moveq r0, r4
		ldreq r1, =#1459
		bleq LogMessageByIdWithPopupCheckUser
		cmp r1, #6 ; Giratina Origin
		moveq r0, #55
		streqb r0, [r5, #+0x60]
		moveq r0, r4
		ldreq r1, =#1460
		bleq LogMessageByIdWithPopupCheckUser
		b ReturnSwapItemGem
*/
	TakeHeldItemGem:
		push r0-r3
		ldrh r1, [r5,#+0x2] ; Pokemon ID
	CheckWasTransformedTake:
		mov r3, #412
		add r2, r3, #2
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r2, #113
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r3, 258h
		add r2, r2, #2
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r2, #1
		cmp r1, r2
		beq CheckTransformedTake
		add r2, r2, #113
		cmp r1, r2
		beq CheckTransformedTake
	ReturnTakeItemGem:
		pop r0-r3
		mov r0, r4
		b 0x22f498c

	CheckTransformedTake:
		ldrh r2, [r5,#+0x4]
		cmp r1, r2
		bne ProceedTransform
		cmp r2, 258h
		subge r2, r2, 258h
		mov r3, #412
		add r3, r3, #2 ; Kyogre
		cmp r3, r2
		beq ProceedTransform
		add r3, r3, #1 ; Groudon
		cmp r3, r2
		beq ProceedTransform
		add r3, r3, #1 ; Rayquaza
		cmp r3, r2
		beq ProceedTransform
		add r3, r3, #113 ; Giratina
		cmp r3, r2
		bne ReturnTakeItemGem
	ProceedTransform:
		ldrh r2, [r5,#+0x4]
		mov r3, #560 ; Rayquaza
		cmp r2, r3
		subne r3, r3, 3h
		cmpne r2, r3
		ldreqh r0, [r5, #+0x24]
		subeq r0, r0, 2h
		streqh r0, [r5,#+0x24]
		ldreqh r0, [r5, #+0x26]
		subeq r0, r0, 2h
		streqh r0, [r5,#+0x26]
		sub r3, r3, 1h ; Groudon
		cmp r2, r3
		subne r3, r3, 3h
		cmpne r2, r3
		ldreqh r0, [r5, #+0x26]
		subeq r0, r0, 2h
		streqh r0, [r5,#+0x26]
		ldreqh r0, [r5, #+0x24]
		subeq r0, r0, 1h
		streqh r0, [r5,#+0x24]
		ldreqh r0, [r5, #+0x28]
		subeq r0, r0, 1h
		streqh r0, [r5,#+0x28]
		sub r3, r3, 1h ; Kyogre
		cmp r2, r3
		subne r3, r3, 3h
		cmpne r2, r3
		ldreqh r0, [r5, #+0x24]
		subeq r0, r0, 2h
		streqh r0, [r5,#+0x24]
		ldreqh r0, [r5, #+0x26]
		subeq r0, r0, 1h
		streqh r0, [r5,#+0x26]
		ldreqh r0, [r5, #+0x2A]
		subeq r0, r0, 1h
		streqh r0, [r5,#+0x2A]
		sub r3, r3, #13 ; Giratina-O
		mov r1, #0
		cmp r2, r3
		moveq r1, #1
		sub r3, r3, #7
		cmp r2, r3
		moveq r1, #1
		add r3, r3, 258h
		cmp r2, r3
		moveq r1, #1
		add r3, r3, 7h
		cmp r2, r3
		moveq r1, #1
		str r1, [IsGiratina]
		ldrsh r0, [r5,#+0x2]
		mov r1, #1
		bl 0x2052A24 ; GetAbility
		strb r0, [r5, #+0x61]
		mov r1, #0
		str r1, [FloorStatusWord]
		ldr r1, =#1462
		ldr r0, [IsGiratina]
		sub r1, r1, r0
		mov r0, r4
		bl LogMessageByIdWithPopupCheckUser
		mov r0,r4
		mov r1,#147
		bl 0x022e42e8 ; LoadAndPlayAnimation
		mov r0, r4
		ldrh r1, [r5,#+0x2]
		strh r1, [r5, 4h]
		bl ChangeMonsterSprite
		b ReturnTakeItemGem

	IsGiratina:
		.word 0x0

	CheckHeldGemsAlly:
		bne 0x22f9ef4
		mov r0, r5
		ldr r1, [AlphaShard]
		bl 0x23467e4
		cmp r0, #0
		bne 0x22f9ef4
		mov r0, r5
		ldr r1, [OmegaShard]
		bl 0x23467e4
		cmp r0, #0
		bne 0x22f9ef4
		mov r0, r5
		ldr r1, [DeltaShard]
		bl 0x23467e4
		cmp r0, #0
		bne 0x22f9ef4
		b 0x22f9f60

	CheckHeldGemsLeader:
		mov r0, r5
		ldr r1, [AlphaShard]
		add r7, r7, r2
		bl 0x2311034
		cmp r0, #0x0
		movne r2, #0x1
		moveq r2, #0x0
		mov r0, r5
		ldr r1, [OmegaShard]
		add r7, r7, r2
		bl 0x2311034
		cmp r0, #0x0
		movne r2, #0x1
		moveq r2, #0x0
		mov r0, r5
		ldr r1, [DeltaShard]
		add r7, r7, r2
		bl 0x2311034
		cmp r0, #0x0
		movne r2, #0x1
		moveq r2, #0x0
		mov r0, r5
		b 0x230fdbc

	AlphaShard:
		.word 0x572
	OmegaShard:
		.word 0x573
	DeltaShard:
		.word 0x574
	AdamantCrystal:
		.word 0x575
	LustrousGlobe:
		.word 0x576
	GriseousCore:
		.word 0x577

	.pool

	; Flower Veil
	FlowerVeilHook1:
		push r0-r3,r5,r14
		mov r5,r1
		mov r0,r5
		mov r1,#158 ; Flower Veil
		mov r2,#0
		bl TryActivateAdjacentAbility
		cmp r0,#1
		moveq r1,#4
		beq CheckType
		mov r0,r5
		mov r1,#159 ; Pastel Veil
		mov r2,#0
		bl TryActivateAdjacentAbility
		cmp r0,#1
		moveq r1,#18
		bne SafeguardNotApplied
	CheckType:
		mov r0,r5
		bl 0x02301E50 ; MonsterIsType
		cmp r0,#1
		beq ApplySafeguard
	SafeguardNotApplied:
		mov r4,r5 ; Original instruction, sorta
		pop r0-r3,r5,r15
	ApplySafeguard:
		pop r0-r3,r5,r14
		cmp r2,#0
		beq 0x02301980
		ldr r1,=#1449
		bl LogMessageByIdWithPopupCheckUser
		b 0x02301980 ; EndOfSafeguard

	FlowerVeilHook2:
		push r1-r3,r5,r14
		mov r5,r1
		cmp r0,r1
		beq no_protection
		mov r0,r5
		mov r1,#158 ; Flower Veil
		mov r2,#0
		bl TryActivateAdjacentAbility
		cmp r0,#1
		moveq r1,#4
		beq CheckType2
		mov r0,r5
		mov r1,#159 ; Pastel Veil
		mov r2,#0
		bl TryActivateAdjacentAbility
		cmp r0,#1
		moveq r1,#18
		bne no_protection
	CheckType2:
		mov r0,r5
		bl 0x02301E50 ; MonsterIsType
		cmp r0,#1
		beq ApplyMist
	no_protection:
		pop r1-r3,r5,r15
	ApplyMist:
		pop r1-r3,r5,r14
		cmp r2,#0
		beq 0x02301ba8
		mov r0,r1
		ldr r1,=#1449
		bl LogMessageByIdWithPopupCheckUser
		b 0x02301ba8 ; EndOfMist

	; Overcoat immunity to Sand
	OvercoatAndSandRushHook:
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02310360 ; ProtectedFromWeather
		mov r0,r5
		mov r1, #0x84 ; Sand Rush
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02310360 ; ProtectedFromWeather
		mov r0,r5
		mov r1, #130 ; Overcoat
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02310360 ; ProtectedFromWeather
		b NoSandVeilOROvercoatORSandRush

	; Overcoat immunity to Hail
	OvercoatAndSlushRushHook:
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02310360 ; ProtectedFromWeather
		mov r0, r5
		mov r1, #0x91 ; Slush Rush
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02310360 ; ProtectedFromWeather
		mov r0, r5
		mov r1, #130 ; Overcoat
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02310360 ; ProtectedFromWeather
		b NoIceBodyOROvercoatORSlushRush

	; Unnerve
	UnnerveHook:
		ldr r6,[sp,#0x84] ; Original instruction
		push r0-r3
		ldrh r0,[r6,#+0x4]
		bl 0x0200CAF0 ; GetItemCategoryVeneer
		cmp r0,#2
		cmpne r0,#3
		bne unnerve_ret
		mov r0,r7
		mov r1, #163 ; Unnerve ID
		mov r2, #1
		bl TryActivateAdjacentAbility
		cmp r0,#0
		beq unnerve_ret
		mov r0,r7
		ldr r1,=#1448
		bl LogMessageByIdWithPopupCheckUser
		pop r0-r3
		b 0x0231CB14 ; ItemJumpAddress
	unnerve_ret:
		pop r0-r3
		cmp r9,#0
		b EndUnnerveHook

	GuidingStar:
		push r0-r4
		mov r0, r7
		mov r1, #153 ; 153: Guiding Star
		mov r2, #0
		bl TryActivateAdjacentAbility
		cmp r0, #0
		addne r10, r10, #0x1
		mov r0, r7
		mov r1, #153 ; 153: Guiding Star
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0, #0
		addne r10, r10, #0x1
		pop r0-r4
		ldrh r0, [r11, #0x4]
		b AfterGuidingStar

	ProteanHook:
		push r0-r12
		; r8 = Move Pointer
		; r9 = Attacker Entity Struct
		mov r0,r9
		mov r1,r8
		bl 0x0230227C ; GetMoveType
		cmp r0,#0
		beq protean_ret
		ldr r1, =23AF0D4h
		strb r0, [r1]
		mov r0,r9
		mov r1,#0xA5 ; 165: Protean
		bl 0x2301D10 ; IsAbilityActive
		cmp r0,#0
		beq protean_ret
		; There's also a Weather Ball check, but eh who cares about that
		mov r0,r9
		mov r1,r8
		bl 0x0230227C ; GetMoveType
		ldr r1,[r9,#+0xB4]
		ldrb r2,[r1,#0x5E]
		ldrb r3,[r1,#0x5F]
		cmp r0,r2
		cmpeq r3,#0
		beq protean_ret ; Already monotype of the move type!
		strb r0,[r1,#0x5E]
		mov r2,#0
		strb r2,[r1,#0x5F]
		mov r2,#1
		strb r2,[r1,#0xFF]
		mov r4,r0
		mov r0,#0
		mov r1,r9
		mov r2,r0
		bl 0x022E2AD8 ; SubstitutePlaceholderStringTags
	    mov  r1, r9
	    mov  r0, #0x1
	    mov  r2, #0x0
	    bl 0x022E2AD8
		mov r0,#0
		mov r1,r4
		bl 0x0234B084
		mov r0,r9
		mov r1,r0
		ldr r2,=#1450
		bl LogMessageByIdWithPopupCheckUserTarget
		mov r0,r9
		bl 0x022E647C
	protean_ret:
		pop r0-r12
		b 0x02332824

	; SpAtk Boost from Storm Drain and Lightning Rod
	SpAtkBoost2:
		str r0, [r13,68h]
		b ApplyRedirectBoost
	SpAtkBoost:
		str r0, [r13,64h]
	ApplyRedirectBoost:
		push r0-r3
		mov r2,#1
		; str r2,[r13]
		mov r3,#1
		mov r0,r9
		mov r1,r5
		bl 0x0231399c ; AttackStatUp
		pop r0-r3
		mov r4,r5
		b 0x232ee54

; Poison Touch: 30% chance to poison targets when using a physical move on an adjacent target
	PoisonTouch:
		push r0-r4
		mov r0, r9
		mov r1, 0x7E ; Poison Touch ID
		bl 0x2301d10
		cmp r0, #0
		beq ReturnPoisonTouch
		push r1-r3
		mov r0, r8
		mov r1, 0x0
		bl 0x2013840
		; ret r0: move range*16 [0,15]
		mov r1, #16
		bl 0x0208FEA4 ; Euclidian Division
		pop r1-r3
		cmp r0, #0
		beq TryPoisonTouch
		cmp r0, #1
		beq TryPoisonTouch
		cmp r0, #2
		beq TryPoisonTouch
		cmp r0, #8
		beq TryPoisonTouch
		b ReturnPoisonTouch
	TryPoisonTouch:
		ldrh r0, [r8, #+0x4]
		bl 0x20151C8
		cmp r0, #0
		bne ReturnPoisonTouch
	    mov r0, #100 ; argument #0 Higher bound
	    bl 0x22EAA98
	    cmp r0, #30
		bge ReturnPoisonTouch
	    mov r0, r9 ; argument #0 User
	    mov r1, r4 ; argument #1 Target
	    mov r2, #0 ; argument #2 FailMessage
	    mov r3, #0 ; argument #3 OnlyCheck
	    bl 0x2312664 ; Poison
	    /*cmp r0, #1
	    bne ReturnPoisonTouch
		ldr r2, =#1453
		mov r0, r9
		mov r1, r4
		bl 0x234b350*/
	ReturnPoisonTouch:
	    pop r0-r4
		b 0x232f9c0

	overcoat_powder_immunity:
		mov r0, r9
		mov r1, r4
		mov r2, #130
		mov r3, #1
		bl 0x2332a0c
		cmp r0, #1
		pusheq r5
		moveq r5, #0
		beq check_powder_move
		mov r0, r4
		mov r1, #4
		bl 0x2301E50
		cmp r0, #1
		pusheq r5
		moveq r5, #1
		beq check_powder_move
		b check_ranged_move

	check_powder_move:
		mov r0, r8
		bl isPowderMove
		cmp r0, #0
		popeq r5
		beq check_ranged_move
		mov r0, #1
		mov r1, r4
		mov r2, #0
		bl 0x22e2ad8
		cmp r5, #0
		pop r5
		ldreq r2, =#1451
		ldrne r2, =#1452
		mov r0, r9
		mov r1, r4
		bl 0x234b350
		mov r11, #0x0

	check_ranged_move:
		cmp r11, #0x0
		beq 0x232f270
		mov r0, r9
		mov r1, r4
		mov r2, #147 ; Queenly Majesty ID
		mov r3, #1
		bl 0x2332a0c
		cmp r0, 1h
		beq ApplyQueenly
		mov r0, r9
		mov r1, r4
		mov r2, #136 ; Armor Tail ID
		mov r3, #1
		bl 0x2332a0c
		cmp r0, 1h
		beq ApplyArmorTail
		b 0x232f270

	ApplyQueenly:
		push r5
		mov r5, #0
		b CommonHook
	ApplyArmorTail:
		push r5
		mov r5, #1
	CommonHook:
		push r1-r3
		mov r0, r8
		mov r1, 0x0
		bl 0x2013840
		; ret r0: move range*16 [0,15]
		mov r1, #16
		bl 0x0208FEA4 ; Euclidian Division
		pop r1-r3
		cmp r0, #4
		beq DamageImmune
		cmp r0, #5
		beq DamageImmune
		cmp r0, #9
		beq DamageImmune
		pop r5
		b 0x232f270

	DamageImmune:
	    mov r1, r4
	    mov r0, #0x1
	    mov r2, #0x0
	    bl 0x022E2AD8
	    cmp r5, #0
	    pop r5
	    ldreq r2, =#1421 ; Queenly String
	    ldrne r2, =#1447 ; Armor String
	    mov r0, r9
	    mov r1, r4
	    bl 0x234B350
	    mov r11, #0x0
		b 0x232f270
		.pool

	; isPowderMove: Spore (4f), Stun Spore (7c), Poison Powder (c7), Sleep Powder (e7), Cotton Spore (15F)
	isPowderMove:
		ldrh r2, [r0, 4h]
		mov r0, #0
		and r0, r0, 0xff
		cmp r2, 0x4f ; Spore
		moveq r0, #1
		cmp r2, 0x7c ; Stun Spore
		moveq r0, #1
		cmp r2, 0xc7 ; Poison Powder
		moveq r0, #1
		cmp r2, 0xe7 ; Sleep Powder
		moveq r0, #1
		add r1, r1, 78h ; Cotton Spore
		cmp r2, r1
		moveq r0, #1
		bx lr

	; Sheer Force
	SheerForceHook1:
		mov r0, r6
		mov r1, #162 ; Sheer Force ID
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		bne 0x02324a10 ; ReturnZeroUT
		cmp r4,#0
		b NoSheerForceEnd1

	SheerForceHook2:
		mov r0,r5
		mov r1, #162 ; Sheer Force ID
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		movne r0,#0
		popne r3-r5,r15
		cmp r4,#0
		b NoSheerForceEnd2

	SheerForceHook3:
		push r0-r3,r14
		mov r4,r3 ; Original instruction
		mov r1, #162 ; Sheer Force ID
		bl 0x02301D78 ; AbilityIsActiveVeneer
		cmp r0,#0
		popeq r0-r3,r15
		ldr r1,=SHEER_FORCE_MOVE_IDS
	sheer_force_loop:
		ldrh r0,[r1],#+0x2
		cmp r0,#0
		popeq r0-r3,r15
		cmp r0,r5
		addeq r4,r4,#0x30
		popeq r0-r3,r15
		b sheer_force_loop

	CheckCheekPouch:
		mov r0, r7
		mov r1, #155 ; Cheek Pouch ID
		bl 0x2301D10
		cmp r0, 1h
		bne 0x231cb9c
		b 0x231cb50

	CalcMaxHPPouch:
		ldrsh r0, [r5, 12h]
		ldrsh r2, [r5, 16h]
		add r2, r0, r2
		b 0x231cb6c

	VanillaAbilities:
		pop r0-r3
	    cmp r0, 258h
	    subgt r0, r0, 258h
	    mov r2, #37 ; Vulpix
		cmp r0, r2
		cmpeq r1, #1
		moveq r0, #49
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #243 ; Treecko
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #84
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Grovyle
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #84
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Sceptile
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #84
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Torchic
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #11
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Combusken
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #11
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Blaziken
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #11
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #43 ; Skitty
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #107
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Delcatty
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #107
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #216 ; Vulpix-A
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #120
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Ninetales-A
	    cmp r0, r2
		cmpeq r1, #1
		moveq r0, #120
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    b 0x22fdea8

	ExpertAbilities:
	    mov r0, 0x0
	    mov r1, 0x4E
	    mov r2, 0x12
	    bl 0x204B678
	    cmp r0, 1h
	    pop r0-r3
	    beq 0x22fdea8
	    cmp r0, 258h
	    subgt r0, r0, 258h
	    mov r2, #1 ; Bulbasaur
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #39
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Ivysaur
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #39
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Venusaur
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #39
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #24 ; Sandshrew
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #19
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Sandslash
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #19
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #9 ; Vulpix
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #68
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Ninetales
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #68
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #16 ; Psyduck
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #41
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Golduck
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #41
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #11 ; Machop
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #31
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Machoke
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #31
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Machamp
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #31
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #48 ; Horsea
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #21
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Seadra
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #21
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #109 ; Ursaluna
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #153
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #18 ; Ursaring
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #153
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #13 ; Kingdra
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #21
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Phanpy
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #29
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Donphan
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #29
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #102 ; Swablu
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #130
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Altaria
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #130
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #95 ; Buizel
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #81
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Floatzel
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #81
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #32 ; Lucario
	    cmp r0, r2
		cmpeq r1, #0
	    moveq r0, #87
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #54 ; Vulpix-A
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #68
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    add r2, r2, #1 ; Ninetales-A
	    cmp r0, r2
		cmpeq r1, #1
	    moveq r0, #68
	    addeq r7, r10, r8
	    beq 0x22fdeb0
	    b 0x22fdea8

	.pool
	PROTO_PTR:
		.word 0x0
	BOOST_BYTE_LOCATIONS:
		.byte 0x30, 0x31, 0x36, 0x37
	.align
	SHEER_FORCE_MOVE_IDS:
		.halfword 0x1, 0x10, 0x19, 0x1e, 0x20, 0x2a, 0x2e, 0x34, 0x35, 0x3e, 0x3f, 0x40, 0x41, 0x45, 0x47, 0x49, 0x4e, 0x52, 0x56, 0x5d, 0x60, 0x61, 0x64, 0x65, 0x67, 0x6b, 0x6d, 0x72, 0x78, 0x7d, 0x7f, 0x81, 0x85, 0x8b, 0x8f, 0x90, 0x92, 0x93, 0x95, 0x9d, 0x9e, 0x9f, 0xa2, 0xa4, 0xa8, 0xb1, 0xbc, 0xc1, 0xc6, 0xc8, 0xcd, 0xcf, 0xd5, 0xdd, 0xe2, 0xe6, 0xea, 0xeb, 0xf4, 0xf6, 0xff, 0x105, 0x106, 0x107, 0x108, 0x10e, 0x10f, 0x113, 0x114, 0x117, 0x118, 0x11b, 0x121, 0x123, 0x124, 0x12b, 0x12f, 0x133, 0x135, 0x136, 0x145, 0x14c, 0x14f, 0x156, 0x158, 0x159, 0x162, 0x19b, 0x19f, 0x1a0, 0x1a3, 0x1a4, 0x1a8, 0x1aa, 0x1ab, 0x1af, 0x1b4, 0x1b5, 0x1ba, 0x1bb, 0x1be, 0x1c4, 0x1c6, 0x1cb, 0x1cd, 0x1d4, 0x1d9, 0x1e4, 0x1e5, 0x1e9, 0x1ef, 0x1f2, 0x1f5, 0x1fb, 0x205, 0x207, 0x209, 0x20a, 0x20c, 0x212, 0x218, 0x21d, 0x220, 0x224, 0x226, 0x229, 0x22C, 0x22E, 0x0
	.align

	.endarea
.close