
; Battle Armor (ID 12) -> Royal Majesty
; White Smoke (ID 24) -> Adaptate (TO DO)
; Pure Power (ID 75) -> Strong Jaws
; Solid Rock (ID 108) -> Blade Mastery

; Strings:
; 3865: Royal Majesty halved damages taken !
; 3866: [pokemon]'s move became [type] thanks to Adaptate !

; Illusion: Ability 0x7D / 125

; Illusion: Zorua-H/Zoroark 
; Poison Touch: Grimer-A/Muk-A, Croagunk/Toxicroak, Stunky/Skuntank, Sneasel-H/Sneasler 
; Triage: Bellossom, Shaymin-Land (Shiny) 
; Corrosion: Bellsprout/Weepinbell/Victreebel, Eternatus 
; Contrary: Spinda 
; Overcoat: Pineco/Forretress 
; Regenerator: Tangrowth-line, Ho-Oh, Celebi, Uxie 
; Sand Rush: Sandshrew/Sandslash, Phanpy/Donphan 
; Analytic: Porygon/Porygon2/Porygon-Z(Shiny), Staryu/Starmie (Shiny), Probopass, Genesect (Shiny) 
; Infiltrator (Gen VI behavior): Zubat/Golbat/Crobat, Ninjask, Spiritomb, Azelf, Darkrai 
; Magic Bounce: Misdreavus/Mismagius, Xatu, Spoink/Grumpig, Mesprit, Cresselia 
; Armor Tail: Farigiraf 
; Prankster: Chimecho, Delibird, Sableye Male, Volbeat, Mew (Shiny), Marshadow (Shiny)
; Sand Force: Nidoking/Nidoqueen (normal), Diglett-A/Dugtrio-A, Gible/Gabite/Garchomp, Hippopotas/Hippowdon 
; Marvel Veil (Fur Coat): Beautifly, Mantine 
; Wonder Veil (Ice Scales): Dustox, Dewgong 
; Bulletproof: Rhyperior-line Female 
; Sky Pact: Pidgeotto/Pidgeot, Shaymin-Sky (Shiny)
; MegaLauncher: Blastoise, Magmortar, Lucario, Genesect (Shiny) 
; Tough Claws: Zangoose, Anorith/Armaldo, Metagross (Shiny) 
; Slush Rush: Swinub/Piloswine/Mamoswine, Glaceon 
; Unseen Fist: Hitmonchan, Marshadow 
; QueenMajesty: Vespiquen (Shiny)
; Sound Waves: Chatot 
; Cursed Body: Gengar-line, Cursola-line 
; Defiant: Purugly-line, Rapidash-K, Infernape, Annihilape 
; Competitive: Wigglytuff-line, Rapidash-G, Empoleon, Girafarig 
; Perish Body (Cursola-line) 
; Guiding Star (Jirachi) 
; Mirror Armor: Skarmory 
; Cheek Pouch: Pachirisu 
; Water Bubble: Whiscash 
; Overload: Plusle, Minun 
; Flower Veil: Cherrim (2 forms), Shaymin-Land 
; Pastel Veil: Ponyta-G/Rapidash-G 
; Neutralizing Gas: Koffing/Weezing 
; Sap Sipper: Miltank, Azurill/Marill/Azumarill 
; Sheer Force: Krabby/Kingler, Nidoqueen/Nidoking (Shiny), Totodile/Croconaw/Feraligatr, Mewtwo (Shiny)
; Unnerve: Houndour/Houndoom, Tyranitar, Surskit/Masquerain 
; Friend Guard: Happiny/Chansey/Blissey, Jirachi (Shiny) 
; Protean: Kecleon, Purple Kecleon 
; Imposter: Ditto 

.nds
.open "overlay_0029.bin", 0x22DC240
; 0x22DC240 is the load address of overlay_0029
	.org 0x22fad0c
	.area 0x4
		beq RegenCheck
	.endarea

	.org 0x22fff98
	.area 0x4
		bne SandRushCheck
	.endarea

	.org 0x2300010
	.area 0x4
		beq LastMoveCheck
	.endarea

	.org 0x2301958
	.area 0x4
		b InfiltratorSafeguardCheck
	.endarea

	.org 0x2301b74
	.area 0x4
		b InfiltratorMistCheck
	.endarea

	.org 0x230ccb8
	.area 0x4
		beq InfiltratorReflectCheck
	.endarea

	.org 0x230cd04
	.area 0x4
		beq InfiltratorLightScreenCheck
	.endarea

	.org 0x2312750
	.area 0x4
		b CheckCorrosionPoison
	.endarea

	.org 0x2312a28
	.area 0x4
		b CheckCorrosionBadPoison
	.endarea

	.org 0x23220ec 
	.area 0x4
		beq 0x232211c
	.endarea

	.org 0x232756c
	.area 0x8
		b CheckTriage1
		nop
		; cmp r0, 0h
		; movne r5, r5, lsl 1h
	.endarea

	.org 0x23285e8
	.area 0x8
		b CheckTriage2
		nop
		; cmp r0, 0h
		; movne r6, r6, lsl 1h
	.endarea
    .org 0x232efa0
    .area 0x10
    	cmp r0, 5h
    	beq hasMagicCoat
    	bne checkMagicBounce
    	mov r0, r0
    .endarea

    .org 0x232f1b0
    .area 0x4
    	b UnseenFistCheck
    .endarea

    .org 0x2332b28
    .area 0x4
		bl FixAbilities
    .endarea

    .org 0x2332d9c
    .area 0x4
    	bl AddAbilityMessages
    .endarea

    .org 0x023480e4
    .area 0x8
    	b ItemThrowBulletproof
    	nop
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x8000
.area 0xA000 - 0x8000

; 0x8000 / 0x23AF080
LoadPlayAnimation:
	push r0-r5, lr
	mov r4, r0 ; Anim ID in r4
	mov r5, r1 ; Entity Pointer in r5
	sub sp, sp, #16
	mov r2, #2
	str r2, [sp, #0] ; sp + 0 is now the first argument

	ldr r2, =#0xffff ; I think you might need to use a ldr for this instead
	str r2, [sp, #8] ; sp + 8 is the third argument

	mov r2, #0
	str r2, [sp, #4] ; sp + 4 is the second argument, and so on...
	str r2, [sp, #12] ; sp + 12 is the fourth argument

	mov r0, r4
    ;ldr r0,=0x1a8
	bl 0x22bdeb4 ; LoadAnimation

	; Pass the first 4 arguments normally...
	mov r3, r0 ; Slot
	mov r0, r5 ; Entity
	mov r1, r4 ; Anim ID
	; ldr r1, =#0x1a8
	mov r2, #0 ; r2 = 0

	bl 0x22e35e4 ; PlayAnimation

	; Make sure to give back the bytes you grabbed the stack afterwards!!!
	add sp, sp, #16
	pop r0-r5, pc

MoveCategory:
	.word 0x0

MoveType:
	.word 0x0

RegenCheck:
	mov r0, r10
	mov r1, 0x83 ; Regenerator ID
	bl 0x2301D78
	cmp r0, #0x0
	beq 0x22fad28
	b 0x22fad10

SandRushCheck:
	cmp r8, #2
	bne SlushRushCheck
	mov r0, r10
	mov r1, 0x84 ; Sand Rush ID
	bl 0x2301D78
	cmp r0, #0x0
	bne 0x22fffcc
	b 0x22fffd8

SlushRushCheck:
	cmp r8, #5
	bne 0x22fffb8
	mov r0, r10
	mov r1, 0x91 ; Slush Rush ID
	bl 0x2301D78
	cmp r0, #0x0
	bne 0x22fffcc
	b 0x22fffd8

LastMoveCheck:
	mov r0, r10
	mov r1, 0x8E ; Sky Pact ID
	bl 0x2301D78
	cmp r0, #0x1
	bne FarigirafCheck
	ldr r0, [MoveType]
	cmp r0, #10 ; Flying-type
	beq HastyAttack
FarigirafCheck:
	ldr r0, [r10, #0xb4]
	ldrh r0, [r0, 0x2]
	cmp r0, #225
	beq TwinBeamCheck
	b PranksterCheck
HastyAttack:
	mov r5, #1
	mov r6, r5
	b 0x2300028

PranksterCheck:
	mov r0, r10
	mov r1, 0x89 ; Prankster ID
	bl 0x2301D78
	cmp r0, #0x0
	beq 0x2300028
	ldr r1, [r10, #0xb4]
; Check last move
	add r1, r1, 0x124
	ldrb r0, [r1] ; Move 1 field 1
	tst r0, 10h
	addne r1, r1, #4
	bne CheckMoveCategory
	add r1, r1, #8
	ldrb r0, [r1] ; Move 2 field 1
	tst r0, 10h
	addne r1, r1, #4
	bne CheckMoveCategory
	add r1, r1, #8
	ldrb r0, [r1] ; Move 3 field 1
	tst r0, 10h
	addne r1, r1, #4
	bne CheckMoveCategory
	add r1, r1, #8
	ldrb r0, [r1] ; Move 4 field 1
	tst r0, 10h
	addne r1, r1, #4
	bne CheckMoveCategory
	b 0x2300028

CheckMoveCategory:
	ldrh r0, [r1]
	bl 0x20151C8 ; GetMoveCategory
	cmp r0, #2 ; Status move
	moveq r5, #1
	moveq r6, r5
	b 0x2300028

TwinBeamCheck:
	ldr r1, [r10, #0xb4]
	add r1, r1, 0x124
	ldrh r0, [r1, 04h] ; Move 1 ID
	cmp r0, #107
	beq CheckLastUsed
	moveq r5, #1
	moveq r6, r5
	beq 0x2300028
	add r1, r1, #8
	ldrh r0, [r1, 04h] ; Move 2 ID
	cmp r0, #107
	beq CheckLastUsed
	moveq r5, #1
	moveq r6, r5
	beq 0x2300028
	add r1, r1, #8
	ldrh r0, [r1, 04h] ; Move 3 ID
	cmp r0, #107
	beq CheckLastUsed
	add r1, r1, #8
	ldrh r0, [r1, 04h] ; Move 4 ID
	cmp r0, #107
	beq CheckLastUsed
	b 0x2300028

CheckLastUsed:
	ldrb r0, [r1] ; Move X field 1
	tst r0, 10h
	movne r5, #1
	movne r6, r5
	b 0x2300028


InfiltratorSafeguardCheck:
	bne 0x2301988
	push r0-r4
	mov r0, r5
	mov r1, 0x86
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	pop r0-r4
	beq 0x2301988
	push r0-r4
	mov r0, r5
	mov r1, #146 ; Unseen Fist ID
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	pop r0-r4
	bne 0x230195c
	ldr r0, [MoveCategory]
	cmp r0, #0
	beq 0x2301988
	bne 0x230195c

InfiltratorMistCheck:
	bne 0x2301b8c
	push r0-r4
	mov r0, r7
	mov r1, 0x86
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	pop r0-r4
	beq 0x2301b8c
	push r0-r4
	mov r0, r7
	mov r1, #146 ; Unseen Fist ID
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	pop r0-r4
	beq 0x2301b8c
	ldr r0, [MoveCategory]
	cmp r0, #0
	beq 0x2301b8c
	bne 0x2301b78

InfiltratorReflectCheck:
	push r0-r4
	mov r0, r10
	mov r1, 0x86
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	pop r0-r4
	bne 0x230ccd0
	push r0-r4
	mov r0, r10
	mov r1, #146 ; Unseen Fist ID
	bl 0x2301D78 ; HasAbility
	pop r0-r4
	cmp r0, #1
	bne 0x230ccd0
	beq 0x230ccbc

InfiltratorLightScreenCheck:
	push r0-r4
	mov r0, r10
	mov r1, 0x86
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	pop r0-r4
	bne 0x230cd1c
	beq 0x230cd08

checkMagicBounce:
	mov r0, r4
	mov r1, 0x87 ; Magic Bounce ID
	bl 0x02301D78
	cmp r0, 0h
	beq 0x232efb0
hasMagicCoat:
	mov r0, #1
	str r0, [sp, 44h]
	b 0x232efdc

UnseenFistCheck:
	beq 0x232f204
	mov r0, r9
	mov r1, #146 ; Unseen Fist ID
	bl 0x2301D78 ; HasAbility
	cmp r0, #1
	bne 0x232f1b4
	ldr r0, [MoveCategory]
	cmp r0, #0
	beq 0x232f204
	b 0x232f1b4

CheckCorrosionPoison:
	mov r0, r10
	mov r1, 0x80 ; Corrosion ID
	bl 0x2301D78
	cmp r0, 1h
	beq 0x23127a4
	mov r0, r9
	b 0x2312754

CheckCorrosionBadPoison:
	mov r0, r10
	mov r1, 0x80 ; Corrosion ID
	bl 0x2301D78
	cmp r0, 1h
	beq 0x2312a7c
	mov r0, r9
	b 0x2312a2c

CheckCursedBody:    
	mov r0, r10
    mov r1, r9
    mov r2, #149 ; Cursed Body
    mov r3, #0x1
    bl 0x230a940 ; DefenderAbilityIsActive
    cmp r0, #0x0
    beq CheckPerishBody ; Check Perish Body
    ldr r1, [r9, #0xb4]
    ldrsh r0, [r8, #0x2]
    ldrsh r1, [r1, #0x2]
    bl 0x2054ec8
    cmp r0, #0x0
    beq CheckPerishBody ; Check Perish Body
    cmp r4, #0x0
    bne CheckPerishBody
    mov r0, #0x64
    bl 0x22eaa98 ; RollRndmNumber
    cmp r0, #15 ; 15%
    addlt r0, r6, 0x100
    ldrlth r1, [r0, 92h]
    orrlt r1, r1, 0x1000
    strlth r1, [r0, 92h]

CheckPerishBody:
	mov r0, r10
    mov r1, r9
    mov r2, #152 ; Perish Body
    mov r3, #0x1
    bl 0x230a940 ; DefenderAbilityIsActive
    cmp r0, #0x0
    beq 0x2308e80 ; Check Stench
    ldr r1, [r9, #0xb4]
    ldrsh r0, [r8, #0x2]
    ldrsh r1, [r1, #0x2]
    bl 0x2054ec8
    cmp r0, #0x0
    beq 0x2308e80 ; Check Stench
    cmp r4, #0x0
    bne 0x2308e80
    mov r0, #0x64
    bl 0x22eaa98 ; RollRndmNumber
    cmp r0, #10 ; 10%
    addlt r0, r6, 0x100
    ldrlth r1, [r0, 92h]
    orrlt r1, r1, 0x2000
    strlth r1, [r0, 92h]
    b 0x2308e80 ; Check Stench

ApplyCursedBody:
    add r0, r4, #0x100
    ldrh r0, [r0, #0x92]
    tst r0, #0x1000
    beq ApplyPerishBody ; Return to normal code
    ldr r1, =#1441
    mov r0, r5
    bl 0x234b2a4
    mov r0, r5
    mov r1, r5
    mov r2, #0
    bl 0x2314ABC ; TrySealMove

ApplyPerishBody:
    add r0, r4, #0x100
    ldrh r0, [r0, #0x92]
    tst r0, #0x2000
    beq 0x2321cb0 ; Return to normal code
    ldr r1, =#1444
    mov r0, r5
    bl 0x234b2a4
    mov r0, r5
    mov r1, r5
    mov r2, #0
    bl 0x231662c ; TryAfflictPerishSong
    b 0x2321cb0

CheckTriage1:
	cmp r0, 0h
	movne r5, r5, lsl 1h
	bne 0x2327574
	mov r0, r9
	mov r1, 0x7F ; Triage ID
	bl 0x2301D78
	cmp r0, 0h
	movne r5, r5, lsl 1h
	b 0x2327574

CheckTriage2:
	cmp r0, 0h
	movne r6, r6, lsl 1h
	bne 0x23285F0
	mov r0, r7
	mov r1, 0x7F ; Triage ID
	bl 0x2301D78
	cmp r0, 0h
	movne r6, r6, lsl 1h
	b 0x23285F0

ItemThrowBulletproof:
	cmp r0, #1
	beq 0x23480ec
	mov r0, r4
	mov r1, #141 ; Bulletproof ID
	bl 0x2301D78
	cmp r0, #1
	beq 0x23480ec
	bne 0x23480f0

FixAbilities:
	push r0-r2, r4-r9, lr
	mov r9, r0 ; User
	mov r4, r1 ; Target
	mov r8, r2 ; Move Data
	mov r7, r3 ; Damage Multiplier
	mov r0, #0
	str r0, [DefAbilityTrigger]
	ldrh r0, [r8, #+0x4]
	bl 0x20151C8
	str r0, [MoveCategory]
	mov r0, r8
	bl 0x2013864
	ldr r1, [r9, #+0xb4]
	ldrb r0, [r1, #0xBF]
	cmp r0, #1
	bne CheckFrostbite
	ldr r0, [MoveCategory]
	cmp r0, 0h
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
	b CheckRange

CheckFrostbite:
	cmp r0, #5
	ldr r0, [MoveCategory]
	cmp r0, 1h
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
CheckRange:
	; Within 1-tile, room: x15/16
	push r1-r3
	mov r0, r8
	mov r1, 0x0
	bl 0x2013840
	; ret r0: move range*16 [0,15]
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	pop r1-r3
	cmp r0, #2 ; 8-tiles around
	moveq r1, r7, lsr 4h
	subeq r7, r7, r1
	cmp r0, #3 ; Room
	moveq r1, r7, lsr 4h
	subeq r7, r7, r1

CheckDiff:
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    pop r0-r3
    beq BellyNerf
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3A
    bl 0x204B678
    cmp r0, 1h
    pop r0-r3
    bne CheckCorrosion

BellyNerf:
	ldr r1, [r9, #+0xb4]
	ldr r2, =146h
	add r1, r1, r2
	ldrh r0, [r1]
	cmp r0, #0
	bne CheckCorrosion
	add r1, r1, #2
	ldrh r0, [r1]
	cmp r0, #0
	lsreq r7, r7, 2h

CheckCorrosion:
	mov r0, r9
	mov r1, 0x80 ; Corrosion ID
	bl 0x2301D78
	cmp r0, 1h
	moveq r0, #2
	beq storePoison
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3C ; Inverse
    bl 0x204B678
    cmp r0, 1h
	pop r0-r3
    moveq r0, #3
	movne r0, #0
storePoison:
	ldr r1, =22C5789h ; Poison effectiveness on Steel
	strb r0, [r1]

; Adaptate: Normal-type moves become your second type and deal 25% more damage
Adaptate:
	mov r0, r9
	mov r1, #24
	bl 0x02301D78
	cmp r0, 1h
	beq GetTypeTwo

; Regal Skin: Halves damage at full health
RegalSkin:
	mov r0, r4
	mov r1, #12
	bl 0x02301D78
	cmp r0, 1h
	beq ApplyRegal

; Swift Swim: damage reduction under Rain (75%)
SwiftSwim:
	mov r0, r9
	mov r1, #27
	bl 0x02301D78
	cmp r0, 1h
	beq GetRain

; Truant: reduces damages taken by 25% when Paused
Truant:
    mov r0, r4
    mov r1, #42
    bl 0x02301D78
    cmp r0, 1h
    beq GetPaused

; Chlorophyll: damage reduction under Sun (75%)
Chlorophyll:
	mov r0, r9
	mov r1, #74
	bl 0x02301D78
	cmp r0, 1h
	beq GetSun

; Strong Jaws: Biting moves deal 33% more damages
StrongJaws:
	mov r0, r9
	mov r1, #75
	bl 0x02301D78
	cmp r0, 1h
	beq GetBiting

; Stall: reduces damages taken by 20%
Stall:
	mov r0, r4
	mov r1, #78
	bl 0x02301D78
	cmp r0, 1h
	beq ApplyStall

; Frisk: deals 25% more damages if the target has an item
Frisk:
    mov r0, r9
    mov r1, #82
    bl 0x02301D78
    cmp r0, 1h
    beq ApplyFrisk

; Unburden: damage reduction if you hold no Item (75%)
Unburden:
	mov r0, r9
	mov r1, #84
	bl 0x02301D78
	cmp r0, 1h
	beq GetItem

; Anticipation: deals 50% more damages if the target has a Super Effective move against you	
Anticipation:
	mov r0, r9
	mov r1, #86
	bl 0x02301D78
	cmp r0, 1h
	beq ApplyAnticipation

; Normalize: Applies a 20% damage increase
Normalize:
	mov r0, r9
	mov r1, #107
	bl 0x02301D78
	cmp r0, 1h
	beq ApplyNormalize

; Blade Mastery: Blade moves deal 33% more damages
BladeMastery:
	mov r0, r9
	mov r1, #108
	bl 0x02301D78
	cmp r0, 1h
	beq GetBlade

; Klutz: Deals 25% more damage if holding an item but disables its effect
Klutz:
	mov r0, r9
	mov r1, #111
	bl 0x02301D78
	cmp r0, 1h
	beq ApplyKlutz

; Multitype: adds a 20% damage boost
Multitype:
	mov r0, r9
	mov r1, #116
	bl 0x02301D78
	cmp r0, 1h
	beq ApplyMultitype

; Sand Rush: damage reduction under Sand (75%)
SandRush:
	mov r0, r9
	mov r1, #132
	bl 0x02301D78
	cmp r0, 1h
	beq GetSand

; Sand Force: Rock, Ground, Steel-damage x1.5 if Sandstorm is active
SandForce:
	mov r0, r9
	mov r1, #138
	bl 0x02301D78
	cmp r0, 1h
	beq GetSandForce

; Analytic: Deals 25% damage with range moves
Analytic:
	mov r0, r9
	mov r1, #133
	bl 0x02301D78
	cmp r0, 1h
	beq GetAnalytic

; Marvel Veil: Physical moves deal halved damages
MarvelVeil:
	mov r0, r4
	mov r1, #139
	bl 0x02301D78
	cmp r0, 1h
	beq GetPhysical

; Wonder Veil: Special moves deal halved damages
WonderVeil:
	mov r0, r4
	mov r1, #140
	bl 0x02301D78
	cmp r0, 1h
	beq GetSpecial

; Bulletproof: If Ball or Bomb move, the move deals no damage
Bulletproof:
	mov r0, r4
	mov r1, #141
	bl 0x02301D78
	cmp r0, 1h
	beq IsBulletMove

; Mega Launcher: Pulse moves deal 33% more damages
MegaLauncher:
	mov r0, r9
	mov r1, #143
	bl 0x02301D78
	cmp r0, 1h
	beq IsPulseMove

; Sound Waves: Sound moves deal 50% more damages
SoundWaves:
	mov r0, r9
	mov r1, #148
	bl 0x02301D78
	cmp r0, 1h
	beq IsSoundMove

; Water Bubble: Water-type moves deal 2x more damages
WaterBubble:
	mov r0, r9
	mov r1, #156
	bl 0x02301D78
	cmp r0, 1h
	beq IsWaterMove

; Tough Claws: Contact moves deal 33% more damages
ToughClaws:
	mov r0, r9
	mov r1, #144
	bl 0x02301D78
	cmp r0, 1h
	beq GetContact

; Slush Rush: damage reduction under Hail (75%)
SlushRush:
	mov r0, r9
	mov r1, #145
	bl 0x02301D78
	cmp r0, 1h
	beq GetHail

; Friend Guard: damage x3/4 if an ally has the ability
FriendGuard:
	mov r0, r4
	mov r1, #164 ; Friend Guard
	mov r2, #0
	bl 0x23B3080 ; TryActivateAdjacentAbility
	cmp r0, 1h
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h

; FloorStatusWord: 0x23B3140
DeltaStream:
	ldr r0, =23B3140h
	ldrb r0, [r0]
	cmp r0, #3
	bne MarowakCheck
	ldr r0, [r4, #+0xb4]
	ldrb r0, [r0,#+0x5E]
	cmp r0, #10
	beq StringDeltaStream
	ldr r0, [r4, #+0xb4]
	ldrb r0, [r0,#+0x5F]
	cmp r0, #10
	beq StringDeltaStream
	b MarowakCheck

ApplyRegal:
	mov r0, r9
	mov r1, #83
	bl 0x02301D78
	cmp r0, 1h
	beq SwiftSwim
	ldr r6, [r4, #+0xb4]
	ldrsh r0,[r6,10h]
    ldrsh r1,[r6,12h]
    ldrsh r2,[r6,16h]
	adds r1, r1, r2
	ldr r2, =#999
	cmp r1, r2
	ldrgt r1, =#999
	cmp r0, r1
	bne SwiftSwim
	lsr r7, 1h
    ldr r2, =#3865
    str r2, [DefAbilityTrigger]
    b SwiftSwim
    .pool

GetTypeTwo:
	ldr r2, =20a6004h
	ldrb r1, [r2]
	cmp r1, 1h
	bne SwiftSwim
	ldr r6, [r9, #+0xb4]
	ldrb r1, [r6, #+0x5f]
	cmp r1, 0h
	ldreqb r1, [r6, #+0x5e]
	; It became [type:0]-type thanks to [CS:G]Adaptate[CR]!
    mov r0, #0
    bl 0x0234B084
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#3866
    bl 0x234B350
    ; damage x5/4
    mov r2, r7, lsl #2 
    add r7, r2, r7
	lsr r7,2h
	b SwiftSwim

GetRain:
	mov r0, r9
	bl 0x2334D08
	cmp r0, 4h
	; Damage x3/4
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
	b Truant

GetPaused:
	ldr r0,[r4,0B4h]
    ldrb r1,[r0,0D0h]
    cmp r1, 3h
	; Damage x3/4
	bne Chlorophyll
	add r7,r7,r7, lsl 1h
	lsr r7,2h
	b Chlorophyll

GetSun:
	mov r0, r9
	bl 0x2334D08
	cmp r0, 1h
	; Damage x3/4
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
	b StrongJaws

GetBiting:
	ldrh r0, [r8, #+0x4]
	cmp r0, #198
	beq BiteIncrease
	ldr r1, =#261
	cmp r0, r1
	beq BiteIncrease
	ldr r1, =#452
	cmp r0, r1
	beq BiteIncrease
	ldr r1, =#461
	cmp r0, r1
	beq BiteIncrease
	ldr r1, =#522
	cmp r0, r1
	beq BiteIncrease
	ldr r1, =#549
	cmp r0, r1
	beq BiteIncrease
	cmp r0, #62
	beq BiteIncrease
	cmp r0, #63
	beq BiteIncrease
	b Stall

BiteIncrease:
	; Damage x3/2
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1423
    bl 0x234B350
	add r7,r7,r7, lsl 1h
	lsr r7,1h
	nop
	nop
	b Stall

ApplyStall:
	; Damage x4/5
	mov r0, r7, lsl 2h
	mov r1, #5
	bl 0x0208FEA4
	mov r7, r0
	b Frisk

ApplyFrisk:
	ldr r0,[r4,0B4h]
    ldrb r1,[r0,62h]
    tst r1,1h
	; Damage x5/4
    movne r2, r7, lsl #2 
    addne r7, r2, r7
	lsrne r7,2h
	b Unburden

GetItem:    
	ldr r0,[r9,0B4h]
    ldrb r1,[r0,62h]
    tst r1,1h
	; Damage x3/4
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
	b Anticipation

ApplyAnticipation:
	mov r0, r9
	mov r1, r4
	mov r2, #1
	bl 0x22fb10c
	cmp r0, #0
	; Damage x3/2
	addne r7,r7,r7, lsl 1h
	lsrne r7,1h
	b Normalize

ApplyNormalize:
    ; Damage x6/5
	add r0,r7,r7, lsl 1h
	mov r0, r0, lsl 1h
	mov r1, 5h
	bl 0x0208FEA4
	mov r7, r0
	b Klutz

GetBlade:
	ldrh r0, [r8, #+0x4]
	cmp r0, #18
	beq BladeIncrease
	cmp r0, #36
	beq BladeIncrease
	cmp r0, #81
	beq BladeIncrease
	cmp r0, #179
	beq BladeIncrease
	cmp r0, #251
	beq BladeIncrease
	ldr r1, =#314
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#336
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#346
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#360
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#442
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#459
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#463
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#470
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#491
	cmp r0, r1
	beq BladeIncrease
	ldr r1, =#557
	cmp r0, r1
	beq BladeIncrease
	b Klutz

BladeIncrease:
	; Damage x4/3
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1424
    bl 0x234B350
	mov r0, r7, lsl 2h
	mov r1, 3h
	bl 0x0208FEA4
	mov r7, r0
	b Klutz

ApplyKlutz:
	ldr r0,[r9,0B4h]
    ldrb r1,[r0,62h]
    tst r1,1h
	; Damage x5/4
    movne r2, r7, lsl #2 
    addne r7, r2, r7
	lsrne r7,2h
	b Multitype

ApplyMultitype:
	; Apply a "Protean"
	ldr r6, [r9, #+0xb4]
    ldrh r5, [r6, #+0x2]
    ldr r0, =#537
    cmp r5, r0
    bne MarowakCheck
	ldrh r5, [r8, #+0x4]
	ldr r0, =#467
	cmp r5, r0
	beq MultitypeDamage
	mov r0, r9
	mov r1, r8
	bl 0x230227C
	cmp r0, 0h
	beq MultitypeDamage
	mov r5, r0
	ldr r6, [r9, #+0xb4]
	ldrb r0, [r6, #+0x5e]
	strb r5, [r6, #+0x5e]        
	mov r1, #1
    strb r1, [r6, #+0xff]
	cmp r0, r5
	beq MultitypeDamage
	; Change Sprite:
	; LoadPokemonSprite: 0x22f74d4
	; GetPokemonSpriteSlot: 0x22f7388
	; UpdateEntitySprite: 0x2304830
	; GetEntityAnimation: 0x2304ab4
	; UpdateEntityShadow: 0x2304bac
	; Get the entity ID
    cmp r5, 1h ; if Normal, load Arceus Normal
    ldreq r0, =#536
    nop
    ldrne r0, =#579 ; Load Arceus-Fire since r1 > 1, r0 >= 581
    addne r0, r0, r5 ; ... so we can load the right entity ID starting from Arceus-Fire
    ldr r1, [r9, #+0xb4]
    strh r0, [r1, 4h]
    mov r2, #0
	strb r2, [r0] ; If Illusion, set the ability to null!
    ldr r0,=0x1a8 ; Hidden stairs animation
    mov r1, r9
    bl 0x23AF080
	mov r0, r9
	ldr r1, [r9,#+0xb4]
	ldrh r1, [r1,#+0x4]
	bl ChangeMonsterSprite
    mov r1, r9
    mov r0, #0x1
    mov r2, #0x0
    bl 0x022E2AD8
    mov r0, #0
    mov r1, r5
    bl 0x0234B084
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#3822
    bl 0x234B350
    b MultitypeDamage

ChangeMonsterSprite: ; r0 = ent_ptr, r1 = target_species_id
; TO DO: pointer global
	push r4-r6,r14
	mov r5,r0
	mov r4,r1
	ldr r6, [r5,#+0xB4]
	mov r1,#1
	mov r0,r4
	bl 0x022F7654 ; LoadMonsterSprite
	mov r0,r4
	bl 0x022F7388 ; GetDungeonSpriteIndex
	strh r0, [r5,#+0xA8]
	strh r4, [r6,#+0x4]
	mov r0,r5
	bl 0x02304BAC ; UnkFunc4
	mov r0,r5
	bl 0x02304AB4 ; GetSleepAnimationId
	mov r1,r0
	mov r0,r5
	bl 0x02304830 ; UnkFunc6
	pop r4-r6,r15

	; Damage x6/5
MultitypeDamage:
	add r0,r7,r7, lsl 1h
	mov r0, r0, lsl 1h
	mov r1, 5h
	bl 0x0208FEA4
	mov r7, r0
	b SandRush

GetSand:
	mov r0, r9
	bl 0x2334D08
	cmp r0, 2h
	; Damage x3/4
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
	b SandForce

GetSandForce:
	mov r0, r9
	bl 0x2334D08
	cmp r0, 2h
	bne Analytic
	; If check passes, damage x3/2
	ldr r0, [MoveType]
	cmp r0, #9 ; Ground Type
	beq SandForceBoost
	cmp r0, #13 ; Rock Type
	beq SandForceBoost
	cmp r0, #17 ; Steel Type
	beq SandForceBoost
	b Analytic

SandForceBoost:
	add r7, r7, r7, lsl 1h
	lsr r7, 1h
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1422
    bl 0x234B350
    b Analytic

GetAnalytic:
	push r1-r3
	mov r0, r8
	mov r1, 0x0
	bl 0x2013840
	; ret r0: move range*16 [0,15]
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	pop r1-r3
	cmp r0, #4
	beq ApplyAnalytic
	cmp r0, #5
	beq ApplyAnalytic
	cmp r0, #9
	beq ApplyAnalytic
	b MarvelVeil

; damage x4/3
ApplyAnalytic:
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1425
    bl 0x234B350
	mov r0, r7, lsl 2h
	mov r1, 3h
	bl 0x0208FEA4
	mov r7, r0
	b MarvelVeil

GetPhysical:
	mov r0, r9
	mov r1, #83
	bl 0x02301D78
	cmp r0, 1h
	beq WonderVeil
	ldr r0, [MoveCategory]
	cmp r0, 0h
	; Damage x1/2
    moveq r0, r9 ; User
    moveq r1, r4
    ldreq r2, =#1426
    bleq 0x234B350
	lsreq r7, 1h
	b WonderVeil

GetSpecial:
	mov r0, r9
	mov r1, #83
	bl 0x02301D78
	cmp r0, 1h
	beq Bulletproof
	ldr r0, [MoveCategory]
	cmp r0, 1h
	; Damage x1/2
    moveq r0, r9 ; User
    moveq r1, r4
    ldreq r2, =#1427
    bleq 0x234B350
	lsreq r7, 1h
	b Bulletproof

IsBulletMove:
	mov r0, r9
	mov r1, #83
	bl 0x02301D78
	cmp r0, 1h
	beq MegaLauncher
	ldrh r0, [r8, #+0x4]
	cmp r0, #2
	beq ApplyBulletproof
	cmp r0, #31
	beq ApplyBulletproof
	cmp r0, #44
	beq ApplyBulletproof
	cmp r0, #127
	beq ApplyBulletproof
	cmp r0, #163
	beq ApplyBulletproof
	cmp r0, #166
	beq ApplyBulletproof
	cmp r0, #193
	beq ApplyBulletproof
	ldr r1, =#280
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#309
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#443
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#453
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#454
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#475
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#486
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#501
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#508
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#523
	cmp r0, r1
	beq ApplyBulletproof
	ldr r1, =#547
	cmp r0, r1
	beq ApplyBulletproof
	b return

ApplyBulletproof:
    mov r1, r4
    mov r0, #0x1
    mov r2, #0x0
    bl 0x022E2AD8
    mov r0, r4 ; Target
    mov r1, r4
    ldr r2, =#1420
    bl 0x234B350
    mov r7, #0
    b MegaLauncher

; All Beam moves, Flash Cannon, Hydro Cannon, TechnoBlast, Pulse moves, Aura Sphere
IsPulseMove:
	ldrh r0, [r8, #+0x4]
	cmp r0, #42
	beq ApplyLauncher
	cmp r0, #54
	beq ApplyLauncher
	cmp r0, #107
	beq ApplyLauncher
	cmp r0, #114
	beq ApplyLauncher
	cmp r0, #151
	beq ApplyLauncher
	cmp r0, #239
	beq ApplyLauncher
	cmp r0, #242
	beq ApplyLauncher
	ldr r1, =#310
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#345
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#361
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#436
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#489
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#508
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#536
	cmp r0, r1
	beq ApplyLauncher
	ldr r1, =#539
	cmp r0, r1
	beq ApplyLauncher
	b SoundWaves

; damage x4/3
ApplyLauncher:
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1428
    bl 0x234B350
	mov r0, r7, lsl 2h
	mov r1, 3h
	bl 0x0208FEA4
	mov r7, r0
	b SoundWaves

IsSoundMove:
	mov r0, r8
	bl 0x2013d5c ; IsSoundMove
	cmp r0, #1
	bne ToughClaws
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1440
    bl 0x234B350
; damage x3/2
	add r7,r7,r7, lsl 1h
	lsr r7,1h
	b WaterBubble

IsWaterMove:
	ldr r0, [MoveType]
	cmp r0, #3 ; Water-type
	lsleq r7, 1h
	b ToughClaws

GetContact:
	push r1-r3
	mov r0, r8
	mov r1, 0x0
	bl 0x2013840
	; ret r0: move range*16 [0,15]
	mov r1, #16
	bl 0x0208FEA4 ; Euclidian Division
	pop r1-r3
	cmp r0, #0
	bne SlushRush
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#1429
    bl 0x234B350
	mov r0, r7, lsl 2h
	mov r1, 3h
	bl 0x0208FEA4
	mov r7, r0
	b SlushRush

GetHail:
	mov r0, r9
	bl 0x2334D08
	cmp r0, 5h
	; Damage x3/4
	addeq r7,r7,r7, lsl 1h
	lsreq r7,2h
	b FriendGuard

StringDeltaStream:
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3C ; Inverse
    bl 0x204B678
    cmp r0, 1h
	pop r0-r3
	ldr r0, [MoveType]
	beq TypeCheckInverse

TypeCheckNormal:
	cmp r0, #5 ; Electric Type
	cmpne r0, #6 ; Ice Type
	cmpne r0, #13 ; Rock Type
	bne MarowakCheck
	b ApplyStrongWinds

TypeCheckInverse:
	cmp r0, #4 ; Grass Type
	cmpne r0, #7 ; Fighting Type
	cmpne r0, #9 ; Ground Type
	cmpne r0, #12 ; Bug Type
	bne MarowakCheck

ApplyStrongWinds:
	lsr r7, 1h
	mov r0, r9
	ldr r1, =#1463
	bl 0x0234B2A4 ; LogMessageByIdWithPopupCheckUser

MarowakCheck:
	ldr r6, [r9, #+0xb4]
    ldrh r0, [r6, #+0x2]
    cmp r0, 258h
    subge r0, r0, 258h
    cmp r0, #105 ; Marowak
    beq BoneDamage
    ldr r1, =#550 ; Marowak-Alola
    cmp r0, r1
    beq BoneDamage
    ldr r6, [r4, #+0xb4]
    ldrh r0, [r6, #+0x2]
    cmp r0, 258h
    subge r0, r0, 258h
    cmp r0, #224 ; Annihilape
    beq CheckRageStatus
    b VWave

CheckRageStatus:
    ldrb r0, [r6, #+0xd2]
    cmp r0, #12 ; Rage status
	moveq r7, r7, lsr 1h
	b VWave

BoneDamage:
	ldrh r5, [r8, #+0x4]
	ldr r0, =#285
	cmp r5, r0
	moveq r7, r7, lsl 1h
	ldr r0, =#289
	cmp r5, r0
	moveq r7, r7, lsl 1h
	ldr r0, =#290
	cmp r5, r0
	moveq r7, r7, lsl 1h
VWave:
	; disable V-Wave in vanilla difficulty
    push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla difficulty
    bl 0x204B678
    cmp r0, 1h
    pop r0-r3
    beq return
    ; type-exclusive dungeons: V-Wave always favors the dungeon type
    ldr r0, =2353538h
    ldr r0, [r0]
    ldrb r0, [r0,748h] ; dungeon ID
	mov r1, r9 ; entity pointer
    bl IsTypeInTypeExclusiveDungeon
    cmp r0, #1
	addeq r7, r7, r7, lsl 1h
	lsreq r7, 1h
	beq return
	; if before Darkrai, V-Wave is inactive
    push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x12
    bl 0x204B678
    cmp r0, 1h
    pop r0-r3
    bne return
	ldr r1, =22AB494h ; V-Wave type in save file
	ldrb r1, [r1]
	mov r0, r9
    bl 0x2301E50
	cmp r0, #1
	addeq r7, r7, r7, lsl 1h
	lsreq r7, 1h

return:
	mov r3, r7
	pop r0-r2, r4-r9, lr
	mov r5, r2
	bx lr

; param: r0: dungeon ID, r1: entity pointer, ret: 1 if it should be boosted
IsTypeInTypeExclusiveDungeon:
	push r2, r6, lr
	mov r6, r1
	cmp r0, #70 ; Rock, Ice, Steel-type
	beq CheckEntityMultiple
	cmp r0, #72 ; Normal-type
	moveq r2, #1
	beq CheckEntitySingle
	cmp r0, #89 ; Dragon, Fairy-type
	beq CheckEntityMultiple
	cmp r0, #94 ; Psychic-type
	moveq r2, #11
	beq CheckEntitySingle
	cmp r0, #95 ; Flying-type
	moveq r2, #10
	beq CheckEntitySingle
	cmp r0, #96 ; Ground-type
	moveq r2, #9
	beq CheckEntitySingle
	cmp r0, #97 ; Fighting-type
	moveq r2, #7
	beq CheckEntitySingle
	cmp r0, #98 ; Poison, Bug-type
	beq CheckEntityMultiple
	cmp r0, #107 ; Grass-type
	moveq r2, #4
	beq CheckEntitySingle
	cmp r0, #108 ; Water-type
	moveq r2, #3
	beq CheckEntitySingle
	cmp r0, #109 ; Electric-type
	moveq r2, #5
	beq CheckEntitySingle
	cmp r0, #110 ; Fire-type
	moveq r2, #2
	beq CheckEntitySingle
	cmp r0, #168 ; Ghost, Dark-type
	beq CheckEntityMultiple
	mov r0, #0
    pop r2, r6, pc

CheckEntitySingle:
	mov r0, r6
	mov r1, r2
	bl 0x2301E50 ; EntityHasType
	pop r2, r6, pc

CheckEntityMultiple:
	ldr r0, [r6, #+0xb4]
	ldrb r0, [r0, #+0x6] ; 1 if not ally
	pop r2, r6, pc

AddAbilityMessages:
	push r0-r3, lr
	push r5
	mov r5, r13
	mov r0, r8
	mov r1, r8
	ldr r2, [DefAbilityTrigger]
	cmp r2, #0
	beq AbilityPop
    bl 0x234B350
AbilityPop:
	mov r13, r5
	pop r5
    pop r0-r3, lr
    ldrh r1, [r5, 4h]
    bx lr

StackBackup:
	.word 0x0

DefAbilityTrigger:
	.word 0x0

.pool
.align
.endarea

.org 0x23D7A10 ; CheckCursedBody
.area 0x4
	beq CheckCursedBody ; beq 0x2308e80
.endarea

.org 0x23D7A28 ; CheckCursedBody
.area 0x4
	bne CheckCursedBody ; bne 0x2308e80
.endarea

.org 0x23D7A30 ; CheckCursedBody
.area 0x4
	bne CheckCursedBody ; bne 0x2308e80
.endarea

.org 0x23D7A50 ; CheckCursedBody
.area 0x4
	b CheckCursedBody ; b 0x2308e80
.endarea

.org 0x23D7A64 ; CursedBodyReturn
.area 0x4
	beq ApplyCursedBody ; beq 0x2321cb0
.endarea

.org 0x23D7A7C ; CursedBodyReturn
.area 0x4
	b ApplyCursedBody ; b 0x2321cb0
.endarea

.org 0x23D7B08 ; FixFrostbite
.area 0x8
	bl 0x23d6fd8
	mov r1, r0
.endarea

.org 0x23D7D08 ; FixFrostbite
.area 0x8
	bl 0x23d6fd8
	mov r1, r0
.endarea
.close