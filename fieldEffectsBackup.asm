.nds
.open "overlay_0029.bin", 0x22DC240
;.definelabel SendMessageWithStringLog, 0x0234B4BC
;.definelabel fn_CheckProgressList, 204B678h
;.definelabel fn_EndTurn, 22ebd10h

    .org 0x22ebd10
    .area 0x4
        bl Challenges
    .endarea

    .org 0x2311104
    .area 0x1C
        ldrsh r0, [r7, #0x2]
        bl 0x2052890 ; GetHPRegen
        mov r4, r0
        ldrb r0, [r7, #0x6]
        cmp r0, #0
        bne BossRecovery
        nop
    .endarea

    .org 0x2311218
    .area 0x18
        cmp r4, 0x190
        movgt r4, 0x190 ; Regen min: 1/400
        add r3, r2, r1
        cmp r4, 0x14
        ldr r0, [0x2311814]
        movlt r4, 0x14  ; Regen max: 1/20
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2000
.area 0x6000 - 0x2000

; Team affecting effects
Challenges:
    mov r4, r0
    push r0-r8, lr

    ldr r8, =2353538h
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    ldr r3, =0x22AB47F
    strb r0, [r3]

; Check if updated, if not, infinite loop
    ldr r3, =0x22AB497
    ldrb r0, [r3]
    cmp r0, #255
    beq CursedHall
UpdateYourGame:
    ldr r1, =#1550
    bl 0x234B498
    b UpdateYourGame

; If Cursed Hall, Belly depletes 2.5x faster
CursedHall:
    ldr r5, =286B2h
    ldr r7, [r8]
    add r7, r7, r5
    ldrb r0, [r7, 2h] ; Tileset ID
    cmp r0, #167
    ldr r7, =2310A70h
    ldreq r5, =5000h
    streqh r5, [r7]
    beq ProvideBoosts
; If Level Reset and IQ Group S (cheated entries), Belly depletes 4x faster
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    cmp r0, #102
    ldrne r5, =2000h
    strneh r5, [r7]
    bne ProvideBoosts
    bl 0x22E9618 ; GetLeaderMonster
    ldrh r0, [r0, #+0x2] ; Pokemon ID
    bl 0x2052B28 ; GetIQGroup
    cmp r0, #12 ; IQ Group S
    ldreq r5, =8000h
    streqh r5, [r7]
    beq ProvideBoosts
    bl 0x22E9618
    ldrh r0, [r0, #+0x2]
    cmp r0, #600
    subge r0, r0, #600
    addlt r0, r0, #600
    bl 0x2052B28
    cmp r0, #12 ; IQ Group S
    ldreq r5, =8000h
    streqh r5, [r7]
    
ProvideBoosts:
    ; 5) Perfect: Life Seeds/Sitrus Berries Upgrades for Money (HP Boost: Life Seed: 22C44F8 + Sitrus Berry: 22C45F4, Oran HP Boost: 22C44F4)
    ; Gold Upgrade: Lv6 = x2 Exp Boost (1.6, 1.7, 1.8, 1.9, 2.0)
    ; Diamond Upgrade: Lv6 = 5x Recovery (+50 -> +250 / +200 -> +1000)
    ; Emerald Upgrade: Lv6 = 3x damage (1.5, 2.0, 2.5, 3.0)
    ; Expert Upgrade: Lv6 = 5x Boost (+8 -> +40)
    ; Master Upgrade: Lv6 = +5 Boost (+3 -> +8)
    ; Alpha Upgrade: Lv6 = 5x Boost (+5 -> +25)
    bl 0x0204C938
    mvn r1, #0
    cmp r0, r1 ; Check the special episode value
    bne StartAbility
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    cmp r0, #99
    cmpne r0, #100
    cmpne r0, #101
    cmpne r0, #102
    cmpne r0, #103
    cmpne r0, #104
    cmpne r0, #105
    moveq r1, #1
    beq StartAbility
    ldr r5, =UpgradeTable
    ldr r6, =22AB488h
    mov r7, #0
LoopGetUpgrades:
    ldrb r1, [r6, r7]
    ; r1 = Upgrade Level
    cmp r1, #0
    beq NextIterUpgrades
UpgradeFind:
    sub r1, r1, #1
    cmp r7, #0
    beq ExpUpgrade
    cmp r7, #1
    beq OranUpgrade
    cmp r7, #2
    beq AmmoUpgrade
    cmp r7, #3
    beq BandUpgrade
    cmp r7, #4
    beq VitaminUpgrade
    cmp r7, #5
    beq GummiesUpgrade
    cmp r7, #6
    beq HPBoostUpgrade
    cmp r7, #7
    beq ExpShareUpgrade
    b nextIterUpgrades

; 0) Gold: Exclusive Items/Wonder Chest/Miracle Chest/Exp. Elite Upgrade (22C458C: Exclusive, 22C4698: Miracle, 22C469C: Wonder, 22C44A8: Exp Elite)
ExpUpgrade: ; +0
    mov r2, #12 ; Base Exp Value
    ldrb r3, [r5, r1] ; Multiplicateur
    mul r4, r2, r3
    lsr r4, 4h
    ldr r0, =22C458Ch
    strb r4, [r0]
    ldr r0, =22C44A8h
    strb r4, [r0]
    lsl r4, 1h
    ldr r0, =22C4698h
    strb r4, [r0]
    lsl r4, 1h
    ldr r0, =22C469Ch
    strb r4, [r0]
    b NextIterUpgrades

; 1) Diamond: Berries Upgrades for Money (Oran: 22C45EC, Sitrus: 22C4478)
OranUpgrade: ; +1
    mov r2, #80 ; Base HP Recovery from Oran
    ldrb r3, [r5, r1]
    add r4, r2, r3
    ldr r0, =22C45ECh
    strh r4, [r0]
    mov r2, #250 ; Base HP Recovery from Sitrus
    add r4, r2, r3
    ldr r0, =22C4478h
    strh r4, [r0]
    b nextIterUpgrades

; 2) Emerald: Ammo Upgrades for Money (22C46B4: Geo Pebble, 22C46B8: Gravelerock, 22C46BC: Rare Fossil, 22C4624: Stick, 22C46E8: Iron Thorn, 22C46E4: Silver Spike, 22C44D0: Gold Thorn, 22C46E0: Gold Fang)
AmmoUpgrade: ; +2
    mov r2, #10 ; Base Geo Pebble Value
    ldrb r3, [r5, r1]
    mul r4, r2, r3
    lsr r4, 4h
    ldr r0, =22C46B4h
    strh r4, [r0]
    lsl r4, 1h
    ldr r0, =22C46B8h
    strh r4, [r0]
    lsl r4, 2h
    ldr r0, =22C46BCh
    strh r4, [r0]
    mov r2, #1 ; Base Stick Value
    add r4, r2, r1
    add r4, r4, #1
    ldr r0, =22C4624h
    strb r4, [r0]
    lsl r4, 2h
    ldr r0, =22C46E8h
    strb r4, [r0]
    lsl r4, 1h
    ldr r0, =22C46E4h
    strb r4, [r0]
    lsl r1, 1h
    ldr r0, =22C44D0h
    strb r4, [r0]
    ldr r0, =22C46E0h
    strb r4, [r0]
    b nextIterUpgrades

; 3) Expert: Bands Upgrades for Money (20A186C, 20A187C, 20A18A8, 20A18AC, 20A18B4)
BandUpgrade: ; +3
    mov r2, #12
    ldrb r3, [r5, r1]
    ldr r0, =20A186Ch
    strb r3, [r0]
    ldr r0, =20A187Ch
    strb r3, [r0]
    ldr r0, =20A18A8h
    strb r3, [r0]
    ldr r0, =20A18ACh
    strb r3, [r0]
    ldr r0, =20A18B4h
    strb r3, [r0]
    b nextIterUpgrades

; 4) Master: Vitamin Upgrades for Money (22C4420, 22C46C8, 22C46CC, 22C46C4)
VitaminUpgrade: ; +4
    mov r2, #3
    ldrb r3, [r5, r1]
    add r4, r2, r3
    ldr r0, =22C4420h
    strb r4, [r0]
    ldr r0, =22C46C8h
    strb r4, [r0]
    ldr r0, =22C46CCh
    strb r4, [r0]
    ldr r0, =22C46C4h
    strb r4, [r0]
    b nextIterUpgrades

; 5) Alpha: Gummies Stat Boosts Upgrades for Money (20A1888)
GummiesUpgrade: ; +5
    mov r2, #1
    ldrb r3, [r5, r1]
    add r4, r2, r3
    ldr r0, =20A1888h
    strb r4, [r0]
    b nextIterUpgrades

; 6) Perfect: Life Seeds/Sitrus Berries Upgrades for Money (HP Boost: Life Seed: 22C44F8 + Sitrus Berry: 22C45F4, Oran HP Boost: 22C44F4)
HPBoostUpgrade: ; +6
    ldr r0, =22C44F4h
    cmp r1, #1
    streqb r1, [r0]
    beq OtherHPUpgrades
    mov r2, #1
    sub r4, r1, #1
    ldrb r3, [r5, r4]
    add r4, r2, r3
    strb r4, [r0]
OtherHPUpgrades: ; +7
    mov r2, #2 ; Sitrus Berry base boost
    ldrb r3, [r5, r1]
    add r4, r2, r3
    ldr r0, =22C45F4h
    strb r4, [r0]
    lsl r4, 1h
    ldr r0, =22C44F8h
    strb r4, [r0]

ExpShareUpgrade:
    mov r2, #0 ; Base Exp Share boost
    ldrb r3, [r5, r1]
    add r4, r2, r3
    ldr r0, =2097E34h
    strb r4, [r0]

NextIterUpgrades:
    cmp r7, #7
    addlt r7, r7, #1
    addlt r5, r5, #10
    blt LoopGetUpgrades
    b StartAbility

UpgradeTable:
    ; Exp. Boosts
    .dcb 0x13
    .dcb 0x16
    .dcb 0x19
    .dcb 0x1C
    .dcb 0x20
    ; Overdrive Upgrades
    .dcb 0x40
    .dcb 0x58
    .dcb 0x70
    .dcb 0x88
    .dcb 0xA0

    ; HP Recovery
    .dcb 0x28
    .dcb 0x50
    .dcb 0x78
    .dcb 0xA0
    .dcb 0xC8
    ; Overdrive Upgrades
    .dcb 0xC8
    .dcb 0xC8
    .dcb 0xC8
    .dcb 0xC8
    .dcb 0xC8

    ; Ammo Multiplier
    .dcb 0x14
    .dcb 0x18
    .dcb 0x24
    .dcb 0x30
    .dcb 0x40
    ; Overdrive Upgrades
    .dcb 0x60
    .dcb 0x60
    .dcb 0x60
    .dcb 0x60
    .dcb 0x60

    ; Band Stats
    .dcb 0x0C
    .dcb 0x0F
    .dcb 0x12
    .dcb 0x15
    .dcb 0x18
    ; Overdrive Upgrades
    .dcb 0x20
    .dcb 0x20
    .dcb 0x20
    .dcb 0x20
    .dcb 0x20

    ; Vitamin Boosts
    .dcb 0x1
    .dcb 0x2
    .dcb 0x3
    .dcb 0x4
    .dcb 0x5
    ; Overdrive Boosts
    .dcb 0x8
    .dcb 0xC
    .dcb 0x10
    .dcb 0x14
    .dcb 0x18

    ; Gummies Boosts
    .dcb 0x1
    .dcb 0x2
    .dcb 0x3
    .dcb 0x4
    .dcb 0x7
    ; Overdrive Upgrades
    .dcb 0x0B
    .dcb 0x0B
    .dcb 0x0B
    .dcb 0x0B
    .dcb 0x0B

    ; HP Boosts
    .dcb 0x2
    .dcb 0x3
    .dcb 0x4
    .dcb 0x5
    .dcb 0x6
    ; Overdrive Upgrades
    .dcb 0x09
    .dcb 0x0C
    .dcb 0x10
    .dcb 0x14
    .dcb 0x18

    ; Exp Share
    .dcb 0x0A
    .dcb 0x14
    .dcb 0x1E
    .dcb 0x28
    .dcb 0x32
    ; Overdrive Upgrades
    .dcb 0x3C
    .dcb 0x46
    .dcb 0x50
    .dcb 0x5A
    .dcb 0x64
.pool

; Fix Abilities
StartAbility:
    mov r5,0h ; r5: Loop counter
AbilityFixes:
    ldr r0,[r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne nextIterAbilityFixes
    mov r3, r6

    ; Run Away: adds +1 Speed boost while Terrified, 20% to wear off from Terrified every turn
    ; mov r0, r4
    ; mov r1, #74
    ; bl 0x02301D10
    ; cmp r0, 1h
    ; bleq ApplyRunAway
    ; Gluttony: minimal max Belly size is 120
Gluttony:
    mov r0, r3
    mov r1, #89
    bl 0x02301D10
    cmp r0, 1h
    beq ApplyGluttony
    b CheckUpgradeStatus

ApplyGluttony:
    ldr r0, [r8]
    ldrb r0, [r0,749h]
    cmp r0,1h
    bgt CheckUpgradeStatus
    ldr r2, [r8,#+0x0]
    ldrb r2, [r2, #+0x748]
    mov r0,r2
    bl 0x2051318
    cmp r0, #0
    bne CheckUpgradeStatus
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne CheckUpgradeStatus
    ldr r0, [r8]
    ldrb r0, [r0,749h]
    cmp r0,1h
    bgt CheckUpgradeStatus
    ldr r3, [r6, #+0xb4]
    mov r1, #120
    strb r1, [r3, #+0x146]
    strb r1, [r3, #+0x14A]

CheckUpgradeStatus:
    ldr r3, [r6, #+0xb4]
    add r7, r3, 100h
    ldrh r0, [r7, #+0x28]
    bl 0x20151C8 ; GetMoveCategory
    cmp r0, #2
    moveq r0, #0
    streqb r0, [r7, #+0x2b]
    ldrh r0, [r7, #+0x30]
    bl 0x20151C8 ; GetMoveCategory
    cmp r0, #2
    moveq r0, #0
    streqb r0, [r7, #+0x33]
    ldrh r0, [r7, #+0x38]
    bl 0x20151C8 ; GetMoveCategory
    cmp r0, #2
    moveq r0, #0
    streqb r0, [r7, #+0x3b]
    ldrh r0, [r7, #+0x40]
    bl 0x20151C8 ; GetMoveCategory
    cmp r0, #2
    moveq r0, #0
    streqb r0, [r7, #+0x43]

nextIterAbilityFixes:
    add r5,r5,1h  
    cmp r5,0x4
    blt AbilityFixes

    ; Check if turn 0
    ; ldr r4,=0x2353538
    ; ldr r4,[r4,#+0x0]
    ; ldrb r4,[r4, #+0x748]
    ; mov r0,r4
    ; bl 0x2051318
    ; cmp r0, #0
    ; bne return

    ; Keep Inventory in Vanilla, Sandbox and God Mode
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla
    bl 0x204B678
    cmp r0, 1h
    beq KeepInventory
    mov r1, 0x4E
    mov r2, 0x3E ; Sandbox
    bl 0x204B678
    cmp r0, 1h
    beq KeepInventory
    mov r1, 0x4E
    mov r2, 0x35 ; God Mode
    bl 0x204B678
    cmp r0, 1h
    beq KeepInventory
    b StartLoopChallenges

KeepInventory:
    ldr r4, =200cc34h
    ldr r5, =04B0h
    strh r5, [r4]

StartLoopChallenges:
; Check SE
    bl 0x0204C938
    mvn r1, #0
    cmp r0, r1 ; Check the special episode value
    bne return

    mov r5,0h ; r5: Loop counter
loopChallenges:
    ldr r0,[r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne nextIterChallenges
    ldr r4, [r6, #+0xb4] ; r4 = Pointer to the user's data
; Checks if Glass Cannon challenge is selected
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x32
    bl 0x204B678
    cmp r0, 1h
    beq GlassCannon
; Checks if Pacifist challenge is selected
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x33
    bl 0x204B678
    cmp r0, 1h
    beq Pacifist
; Checks if Time Attack challenge is selected  
    mov r0, 0x0
    mov r1, 0x4E  
    mov r2, 0x34
    bl 0x204B678
    cmp r0, 1h
    beq TimeAttack
; Checks if God Mode is enabled
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x35
    bl 0x204B678
    cmp r0, 1h
    beq GodMode
    b applyMysteriosity2

; Glass Cannon challenge
GlassCannon:
    mov r1, #1
    str r1, [r4, #+0x3c]
    str r1, [r4, #+0x40]
    ldrh r0, [r4, #+0x10]
    mov r1, #1
    cmp r0, r1
    strgeh r1, [r4, #+0x10]
    ldr r1, =#768
    str r1, [r4, #+0x34]   
    str r1, [r4, #+0x38]
    b applyMysteriosity2
; Pacifist challenge
Pacifist:
    push r0, r1
    bl 0x234934C
    cmp r0, #1
    pop r0, r1
    beq applyMysteriosity2
    mov r1, #1  
    strb r1, [r4, #+0xD0]
    mov r1, #2
    strb r1, [r4, #+0xD1] 
    ldr r1, =1
    str r1, [r4, #+0x34]   
    str r1, [r4, #+0x38]
    ldr r1, =#2048
    str r1, [r4, #+0x3c]   
    str r1, [r4, #+0x40]
    b applyMysteriosity2
; Time Attack challenge
TimeAttack:
    mov r1, 0x2
    strb r1, [r4, #+0xbf]
    mov r1, 0x7F
    strb r1, [r4, #+0xc0] 
    strb r1, [r4, #+0xc1] 
    b applyMysteriosity2
; God Mode enabled
GodMode:
    mov r1, 0x1
    strb r1, [r4, #+0xf9]
    strb r1, [r4, #+0xfa]
    mov r1, 0x2
    strb r1, [r4, #+0x110]
    strb r1, [r4, #+0x114]
    mov r1, 0x3
    strb r1, [r4, #+0xef]
    strb r1, [r4, #+0xf0]
    strb r1, [r4, #+0xf1]
    strb r1, [r4, #+0xf2]
    mov r1, #200
    strb r1, [r4, #+0x146]
    strb r1, [r4, #+0x14A]
    b applyMysteriosity2

; Random effect between: Embargo, Seal 1st move slot, Heal Block, Gastro Acid (15% of occurence in 2 and higher).
applyMysteriosity2:
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    bl IsMysteriosityLockedDungeon
    cmp r0, #1
    beq nextIterChallenges
    bl 0x0204C938
    mvn r1, #0
    cmp r0, r1
    bne nextIterChallenges
    ldr r0, [r8]
    add r0, r0, 4000h
    ldrb r0, [r0,0DAh]
    cmp r0, #111
    beq nextIterChallenges
    sub r0, r0, #170
    cmp r0, #10
    bls nextIterChallenges
    ldr r1, =22AB495h ; Mysteriosity degree
    ldrb r1, [r1]
    cmp r1, #255
    beq nextIterChallenges   
    cmp r1, 2h
    blt nextIterChallenges  
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0,[r0,084h]
    cmp r0, r1
    ldrne r1, =MysteriosityRoll
    ldrne r0, [r1]
    bne applyNerf
    cmp r5, #0
    ldrne r1, =MysteriosityRoll
    ldrne r0, [r1]
    bne applyNerf
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    ldr r1, =MysteriosityRoll
    str r0, [r1]

applyNerf:
    cmp r0, #18
    bge nextIterChallenges
    cmp r0, #1
    blt Embargo
    cmp r0, #5
    blt HealBlock
    cmp r0, #9
    blt DisableAbility
    cmp r0, #13
    blt Taunt
    cmp r0, #18
    blt Mist

Embargo:
    mov r1, #6
    strb r1, [r4, #+0xD8]
    mov r1, #255
    strb r1, [r4, #+0xDB]
    b nextIterChallenges

HealBlock:
    mov r1, #5
    strb r1, [r4, #+0xD8]
    mov r1, #255
    strb r1, [r4, #+0xDB]
    b nextIterChallenges

DisableAbility:
    mov r1, #4
    strb r1, [r4, #+0xD8]
    mov r1, #255
    strb r1, [r4, #+0xDB]
    b nextIterChallenges

Taunt:
    mov r1, #5
    strb r1, [r4, #+0xD0]
    mov r1, #255
    strb r1, [r4, #+0xD1]
    b nextIterChallenges

Mist:
    mov r1, #14
    strb r1, [r4, #+0xD5]
    mov r1, #255
    strb r1, [r4, #+0xD6]
    b nextIterChallenges

MysteriosityRoll:
    .dcd 0x0

nextIterChallenges:
    mov r0,r6
    bl 0x22E3AB4
    add r5,r5,1h
    cmp r5,0x4
    blt loopChallenges

; Checks if Exp. Share is enabled
ExpShare:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x36
    bl 0x204B678
    cmp r0, 1h
    bne Inverse
    mov r1, 0h
    ldr r3,=2097E34h
    strb r1, [r3]

; Checks if Inverse is enabled
Inverse:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3C
    bl 0x204B678
    cmp r0, 1h
    beq RockCheck
; Check if Inverse table has to be loaded
    ldr r0,=22c56d6h
    ldrb r0, [r0]
    cmp r0, 3h ; Check if Inverse conditions have to be turned off
    bne TimeGears
    b InitializeInverse

RockCheck:
    ldr r0,=22c56d6h
    ldrb r0, [r0]
    cmp r0, 1h ; Check if Rock-type is resisted
    bne TimeGears
; Initialize Inverse table  
InitializeInverse:
    ldr r0,=22c56b0h
    mov r1,0h
loopInverse:
    ldrb r2,[r0,r1]
    cmp r2,2h
    beq nextIterInverse
    movgt r2,1h ; 3 -> 1
    movlt r2,3h ; 0,1 -> 3
    strb r2,[r0,r1]
nextIterInverse:    
    add r1,r1,1h
    ldr r3, =#625
    cmp r1, r3
    blt loopInverse

; Checks if Time Gears are in the bag (Hidden Land + Temporal Tower boost)
TimeGears:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0, 3h
    bne Mastery
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x37
    bl 0x204B678
    cmp r0, 1h
    bne Mastery
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    beq Mastery
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne Mastery

    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x11 ; Temporal Tower saved
    bl 0x204B678
    cmp r0, 1h
    beq Mastery
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    cmp r0, 0x26 ; Hidden Land
    beq GearBoost
    cmp r0, 0x27 ; Hidden Highland
    beq GearBoost
    cmp r0, 0x28 ; Old Ruins
    beq GearBoost
    cmp r0, 0x29 ; Temporal Tower
    beq GearBoost
    cmp r0, 0x2A ; Temporal Spire
    beq GearBoost
    cmp r0, 0x2B ; Temporal Pinnacle
    beq GearBoost
    b Mastery

GearBoost:
    mov r5,0h ; r5: Loop counter
; Get party to apply the boost
loopGearBoosts:
    ldr r0,[r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne nextIterTimeGears
    ldr r2, [r6, #+0xb4] ; r2 = Pointer to the user's data
    ldr r1, =#280
    str r1, [r2, #+0x34]
    str r1, [r2, #+0x38]
    str r1, [r2, #+0x3C]
    str r1, [r2, #+0x40]

    cmp r5, 0h
    bne nextIterTimeGears
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne nextIterTimeGears

nextIterTimeGears:
    add r5,r5,1h
    cmp r5,0x4
    blt loopGearBoosts

Mastery:
    ldr r0, [r8]
    ldrb r0,[r0,748h]

; Tower of Mastery stat boost
    cmp r0, #13 ; Trial of Mastery
    bne Destiny

    mov r5,0h ; r5: Loop counter
LoopMastery:
    ldr r0, [r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne NextIterMastery
    ldr r2, [r6, #+0xb4] ; r2 = Pointer to the user's data
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne VanillaNerf
    ldr r0, [r4]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r4]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne VanillaNerf
    ldr r0, [r4]
    ldrb r0, [r0,749h]
    cmp r0, 50h
    beq finalFloor
    cmp r0, 28h
    bgt lastFloors
    cmple r0, 14h
    bge firstFloors
    b NextIterMastery
firstFloors:
    ldrh r0, [r2, #+0x12]
    ldr r1, =#998
    cmp r0, r1
    addlt r0, r0, 2h
    ldr r1, =#999
    movge r0, r1
    strh r0, [r2, #+0x12]
    ldrb r0, [r2, #+0x1a]
    cmp r0, #255
    addne r0, r0, 1h
    strb r0, [r2, #+0x1a]
    ldrb r0, [r2, #+0x1b]
    cmp r0, #255
    addne r0, r0, 1h
    strb r0, [r2, #+0x1b]
    ldrb r0, [r2, #+0x1c]
    cmp r0, #255
    addne r0, r0, 1h
    strb r0, [r2, #+0x1c]
    ldrb r0, [r2, #+0x1d]
    cmp r0, #255
    addne r0, r0, 1h
    strb r0, [r2, #+0x1d]
    b NextIterMastery
lastFloors:
    ldrh r0, [r2, #+0x12]
    ldr r1, =#995
    cmp r0, r1
    addlt r0, r0, 5h
    ldr r1, =#999
    movge r0, r1
    strh r0, [r2, #+0x12]
    ldrb r0, [r2, #+0x1a]
    cmp r0, #254
    addlt r0, r0, 2h
    movge r0, #255
    strb r0, [r2, #+0x1a]
    ldrb r0, [r2, #+0x1b]
    cmp r0, #254
    addlt r0, r0, 2h
    movge r0, #255
    strb r0, [r2, #+0x1b]
    ldrb r0, [r2, #+0x1c]
    cmp r0, #254
    addlt r0, r0, 2h
    movge r0, #255
    strb r0, [r2, #+0x1c]
    ldrb r0, [r2, #+0x1d]
    cmp r0, #254
    addlt r0, r0, 2h
    movge r0, #255
    strb r0, [r2, #+0x1d]
    b NextIterMastery
finalFloor:
    ldrh r0, [r2, #+0x12]
    ldr r1, =#949
    cmp r0, r1
    addlt r0, r0, 32h
    ldr r1, =#999
    movge r0, r1
    strh r0, [r2, #+0x12]
    ldrb r0, [r2, #+0x1a]
    cmp r0, #235
    addlt r0, r0, 14h
    movge r0, #255
    strb r0, [r2, #+0x1a]
    ldrb r0, [r2, #+0x1b]
    cmp r0, #235
    addlt r0, r0, 14h
    movge r0, #255
    strb r0, [r2, #+0x1b]
    ldrb r0, [r2, #+0x1c]
    cmp r0, #235
    addlt r0, r0, 14h
    movge r0, #255
    strb r0, [r2, #+0x1c]
    ldrb r0, [r2, #+0x1d]
    cmp r0, #235
    addlt r0, r0, 14h
    movge r0, #255
    strb r0, [r2, #+0x1d]
NextIterMastery:
    add r5,r5,1h  
    cmp r5,0x4
    blt LoopMastery

; Destiny Tower damage reduction lifted
Destiny:
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    cmp r0, #104
    bne Perfection
    mov r0, #256
    ldr r5, =20a18e8h ; Enemy damage reduction
    strh r0, [r5]

    mov r5,4h ; r5: Loop counter
loopDT:
    ldr r0, [r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne nextIterDT
    ldr r7, [r6, #+0xb4] ; r7 = Pointer to the user's data
    mov r0, #284
    str r0, [r7, 34h]
    str r0, [r7, 38h]
    mov r0, #340
    str r0, [r7, 3Ch]
    str r0, [r7, 40h]
    add r7, r7, 100h
    mov r0, #15
    strb r0, [r7, #+0x02b]
    strb r0, [r7, #+0x033]
    strb r0, [r7, #+0x03b]
    strb r0, [r7, #+0x043]

nextIterDT:
    add r5,r5,1h  
    cmp r5,0x14
    blt loopDT

; Tower of Perfection special effect
Perfection:
    cmp r0, #165 ; Tower of Perfection
    bne VanillaNerf

    mov r5,4h ; r5: Loop counter
LoopPerfection:
    ldr r0, [r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne NextIterPerfection

NextIterPerfection:
    add r5,r5,1h  
    cmp r5,0x14
    blt LoopPerfection
    b VanillaNerf

.pool

; Implements a x1.15 boost on allies in Vanilla
VanillaNerf:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38
    bl 0x204B678
    cmp r0, 1h
    bne HardcoreNerf

    mov r5,0h ; r5: Loop counter
LoopVanillaNerf:
    ldr r0, [r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne NextIterVanillaNerf
    ldr r2, [r6, #+0xb4] ; r2 = Pointer to the user's data
    ldr r1, =#294
    str r1, [r2,034h]
    str r1, [r2,038h]
    str r1, [r2,03Ch]
    str r1, [r2,040h]
NextIterVanillaNerf:
    add r5,r5,1h  
    cmp r5,0x4
    blt LoopVanillaNerf

HardcoreNerf:
    mov r7, #0
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    beq SetCaps
    mov r1, 0x4E
    mov r2, 0x3A
    bl 0x204B678
    cmp r0, 1h
    bne Difficulties
    add r7, r7, #30

SetCaps:
    mov r5,0h ; r5: Loop counter
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x11 ; Temporal Tower saved
    bl 0x204B678
    cmp r0, 1h
    addne r7, #90 ; Stat Cap pre-Dialga, +50 in HP
    bne LoopHardcoreNerf
    mov r1, 0x4E
    mov r2, 0x12 ; Darkrai banished
    bl 0x204B678
    cmp r0, 1h
    beq Difficulties
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    add r7, #150 ; Stat Cap pre-Darkrai, +50 in HP

LoopHardcoreNerf:
    ldr r0, [r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne NextIterHardcoreNerf
    ldr r2, [r6, #+0xb4] ; r2 = Pointer to the user's data
    ldrh r1, [r2, 2h] ; Pokemon ID
    mov r0, #192
    cmp r0, r1
    beq NextIterHardcoreNerf
    ldr r0, =#530
    cmp r0, r1
    beq NextIterHardcoreNerf
    ldr r0, =#543
    cmp r0, r1
    beq NextIterHardcoreNerf
    ldrb r1, [r2,01Ah]
    cmp r1, r7
    strgeb r7, [r2,01Ah]
    ldrb r1, [r2,01Bh]
    cmp r1, r7
    strgeb r7, [r2,01Bh]
    ldrb r1, [r2,01Ch]
    cmp r1, r7
    strgeb r7, [r2,01Ch]
    ldrb r1, [r2,01Dh]
    cmp r1, r7
    strgeb r7, [r2,01Dh]
    add r3, r7, #50
    ldrh r1, [r2,012h]
    cmp r1, r3
    strgth r3, [r2, 012h]
    ldrh r1, [r2, 010h]
    ldrh r3, [r2, 012h]
    cmp r1, r3
    movgt r3, r1
    strgeh r3, [r2, 010h]
NextIterHardcoreNerf:
    add r5,r5,1h  
    cmp r5,0x4
    blt LoopHardcoreNerf

; Difficulty settings (Spawn Rate, Burn and Poison in Vanilla)
Difficulties:
    ldr r6, =22c44dch ; Spawn rate
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38
    bl 0x204B678
    cmp r0, 1h
    beq Vanilla  
    mov r1, 0x4E
    mov r2, 0x39
    bl 0x204B678
    cmp r0, 1h
    beq Difficult
    mov r1, 0x4E
    mov r2, 0x3A
    bl 0x204B678
    cmp r0, 1h
    beq Expert
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    beq Hardcore
    b Mysteriosity5

; Vanilla Values
Vanilla:
    mov r0, #36
    strb r0, [r6]
    mov r0, #50
    ldr r6, =22c4610h ; Burn CD
    strb r0, [r6]
    mov r0, #25
    ldr r6, =22c46a8h ; Poison CD
    strb r0, [r6]
    ldr r0, =#384
    ldr r6, =20a18e8h ; Enemy damage reduction
    strh r0, [r6]
    ;ldr r6, [r8]
    ;add r6, r6, 700h
    ;ldr r0, =#2000
    ;strh r0, [r6, 84h] ; Turn limit
    b Mysteriosity5

Difficult:
    mov r0, #24
    strb r0, [r6]
    ldr r0, =#340
    ldr r6, =20a18e8h ; Enemy damage reduction
    strh r0, [r6]
    b Mysteriosity5

Expert:
    mov r0, #18
    strb r0, [r6]
    ldr r0, =#320
    ldr r6, =20a18e8h ; Enemy damage reduction
    strh r0, [r6]
    b Mysteriosity5

Hardcore:
    mov r0, #6
    strb r0, [r6]
    mov r0, #15
    ldr r6, =22c4610h ; Burn CD
    strb r0, [r6]
    ldr r6, =22c46a8h ; Poison CD
    strb r0, [r6]
    ldr r0, =#294
    ldr r6, =20a18e8h ; Enemy damage reduction
    strh r0, [r6]

; If Mysteriosity 5, lift damage reduction
Mysteriosity5:
    ldr r2, =22AB495h ; Mysteriosity degree
    ldrb r0, [r2]
    cmp r0, 5h
    bne FixedRoomCheck
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    bl IsMysteriosityLockedDungeon
    cmp r0, #1
    beq FixedRoomCheck
    bl 0x0204C938
    mvn r1, #0
    cmp r0, r1
    bne FixedRoomCheck
    mov r0, #256
    ldr r2, =20a18e8h ; Enemy damage reduction
    strb r0, [r2]

; Checks if the floor is a Fixed Room
FixedRoomCheck:
    ldr r0, [r8]
    add r0,r0,4000h
    ldrb r0,[r0,0DAh]
    cmp r0, 0h
    beq return
    bl 0x22E0864 ; Fixed Room ID
    cmp r0, #0
    beq return
    bl 0x23492D4 ; Boss Challenge Floor
    cmp r0, #1
    beq return
    bl 0x23491C4 ; Normal Challenge Floor
    cmp r0, #1
    beq return
    bl 0x2349564 ; Treasure Memo Floor
    cmp r0, #1
    beq return

    ldr r0, =#340
    ldr r5, =20a18e8h ; Enemy damage reduction
    strh r0, [r5]
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3A
    bl 0x204B678
    cmp r0, 1h
    ldreq r0, =#280
    ldreq r5, =20a18e8h ; Enemy damage reduction
    streqh r0, [r5]
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    moveq r0, #256
    ldreq r5, =20a18e8h ; Enemy damage reduction
    streqh r0, [r5]

    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla difficulty
    bl 0x204B678
    cmp r0, 1h
    ldr r6, =22AB498h ; 1 if Field Effects enabled
    moveq r0, 0h
    streqb r0, [r6]
    movne r0, 1h
    strneb r0, [r6]
    ldr r6, =22AB498h ; 1 if Field Effects enabled
    ldrb r0, [r6]
    cmp r0, 1h
    bne continueAura

    mov r5, 0h
loopFieldEffects:
    ldr r0, [r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne nextIterFieldEffects
    ldr r7, [r6, #+0xb4] ; r7 = Pointer to the user's data
    mov r1, #1
    mov r3, #2
    ldr r0, [r8]
    ldrb r0, [r0,748h]

    cmp r0, #19 ; Amp Plains
    beq GastroAcid

    cmp r0, #53 ; Miracle Seabed
    beq GastroAcid

    cmp r0, #69 ; Dark Crater Pit
    beq Nightmares

    cmp r0, #73 ; Bottomless Sea
    beq PrimordialSea

    cmp r0, #75 ; Shimmer Desert
    beq DesolateLand

    cmp r0, #76 ; Genesis Island
    beq CrossEyed

    cmp r0, #77 ; Mt. Avalanche
    beq GastroAcid

    cmp r0, #78 ; Thundercap Mt.
    beq GastroAcid

    cmp r0, #79 ; Giant Volcano
    beq GastroAcid

    cmp r0, #80 ; Fire Field
    streqb r1, [r7, #+0xBF]
    moveq r1, 0x7F
    streqb r1, [r7, #+0xc0] 
    streqb r1, [r7, #+0xc1] 
    beq StartupAnimsPlayer

    cmp r0, #81 ; World Abyss
    streqb r1, [r7, #+0xD8]
    streqb r3, [r7, #+0xDB]
    beq StartupAnimsPlayer

    cmp r0, #83 ; Sky Stairway
    beq DeltaStream

    cmp r0, #84 ; Altar of Dreams
    beq Dreams

    cmp r0, #85 ; Mystery Jungle
    beq Daydream

    cmp r0, #106 ; Tomb of Nightmares
    beq Nightmares

    cmp r0, #122 ; Sky Peak
    streqb r3, [r7, #+0xbf] 
    moveq r3, 0x7F
    streqb r3, [r7, #+0xc0] 
    streqb r3, [r7, #+0xc1] 
    beq StartupAnimsPlayer

    cmp r0, #170 ; Sea Shrine
    beq RiptideField

    cmp r0, #173 ; Mount Tensei
    beq ZenithClouds

    b nextIterFieldEffects

StartupAnimsPlayer:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne nextIterFieldEffects
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne nextIterFieldEffects

    ldr r0, [r8]
    ldrb r0, [r0,748h]

    cmp r0, #19 ; Amp Plains
    ldreq r1, =#460

    cmp r0, #53 ; Miracle Seabed
    ldreq r1, =#460

    cmp r0, #73 ; Bottomless Sea
    moveq r1, #204

    cmp r0, #75 ; Shimmer Desert
    moveq r1, #244

    cmp r0, #76 ; Genesis Island
    ldreq r1, =#286

    cmp r0, #77 ; Mt. Avalanche
    ldreq r1, =#460

    cmp r0, #78 ; Thundercap Mt.
    ldreq r1, =#460

    cmp r0, #79 ; Giant Volcano
    ldreq r1, =#460

    cmp r0, #80 ; Fire Field
    moveq r1, #21

    cmp r0, #81 ; World Abyss
    moveq r1, #75

    cmp r0, #83 ; Sky Stairway
    moveq r1, #83

    cmp r0, #85 ; Mystery Jungle
    ldreq r1, =#286

    cmp r0, #122 ; Sky Peak
    ldreq r1, =#529

    cmp r0, #173 ; Mount Tensei
    moveq r1, #176

    mov r0, r1
    mov r1, r6
    bl 0x23AF080

nextIterFieldEffects:
    add r5,r5,1h  
    cmp r5,0x4
    blt loopFieldEffects
    b continueAura

; Primordial Sea: non-Water type Pokémon hit by Wave before warp. Damage is based on target's Special Attack (DoMoveMuddyWater)
PrimordialSea:
    push r0-r3
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h] ; Turns left
    mov r1, #3
    bl 0x0208FEA4 ; EuclidianDivision
    cmp r1, #1 ; If turns left is (3k+1)
    pop r0-r3
    bne nextIterFieldEffects
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0, 3h
    bne nextIterFieldEffects
    mov r0, r7
    mov r1, #3
    bl 0x2301E50 ; MonsterIsType
    cmp r0, #1
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, r7
    mov r2, #159 ; Muddy Water
    mov r3, #0
    bl 0x2329000
    cmp r0, #0
    beq StartupAnimsPlayer
    mov r0, r7
    mov r1, r7
    mov r2, #187 ; Teleport
    mov r3, #0
    bl 0x23296F8
    b StartupAnimsPlayer

; Desolate Land: non-Fire type Pokémon hit by Fire before warp. Damage is based on target's Attack (DoMoveSacredFire)
DesolateLand:
    push r0-r3
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h] ; Turns left
    mov r1, #3
    bl 0x0208FEA4 ; EuclidianDivision
    cmp r1, #1 ; If turns left is (3k+1)
    pop r0-r3
    bne nextIterFieldEffects
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0, 3h
    bne nextIterFieldEffects
    mov r0, r7
    mov r1, #2
    bl 0x2301E50 ; MonsterIsType
    cmp r0, #1
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, r7
    mov r2, #149 ; Sacred Fire
    mov r3, #0
    bl 0x2328B00
    cmp r0, #0
    beq StartupAnimsPlayer
    mov r0, r7
    mov r1, r7
    mov r2, #187 ; Teleport
    mov r3, #0
    bl 0x23296F8
    b StartupAnimsPlayer

; Desolate Land: non-Flying type Pokémon hit by Tornado before warp. Damage is based on target's Attack (DoMoveAirSlash)
DeltaStream:
    push r0-r3
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h] ; Turns left
    mov r1, #3
    bl 0x0208FEA4 ; EuclidianDivision
    cmp r1, #1 ; If turns left is (3k+1)
    pop r0-r3
    bne nextIterFieldEffects
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0, 3h
    bne nextIterFieldEffects
    mov r0, r7
    mov r1, #10
    bl 0x2301E50 ; MonsterIsType
    cmp r0, #1
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, r7
    ldr r2, =#442 ; Air Slash
    mov r3, #0
    bl 0x2326670
    cmp r0, #0
    beq StartupAnimsPlayer
    mov r0, r7
    mov r1, r7
    mov r2, #187 ; Teleport
    mov r3, #0
    bl 0x23296F8
    b StartupAnimsPlayer

; Ignore Abilities in certain dungeons
GastroAcid:
    mov r1, #4
    strb r1, [r7, #+0xD8]
    strb r1, [r7, #+0xDB]
    b StartupAnimsPlayer

CrossEyed:
    mov r1, #2
    strb r1, [r7, #+0xF1]
    strb r1, [r7, #+0xF2]
    b StartupAnimsPlayer

; Inflicts Taunt and Exposed to your party
ZenithClouds:
    mov r1, #5
    strb r1, [r7, #+0xD0]
    mov r1, #255
    strb r1, [r7, #+0xD1]
    mov r1, #1
    strb r1, [r7, #+0xFE]
    b StartupAnimsPlayer

; If an ally is asleep, Daydream heals it immediately
Daydream:
    ; String 1542 for Daydream
    ldr r0, [r6, #+0xb4]
    ldrb r0, [r0, #+0xbd]
    cmp r0, #0
    beq nextIterFieldEffects
    mov r0, #0
    mov r1, r6
    bl 0x0234B084
    ldr r1, =#1542      
    mov r0, r6 ; User
    bl 0x234B498
    mov r0, r6
    mov r1, r6
    ldr r2, =#339
    mov r3, #0
    bl 0x2326188 ; DoMoveRefresh
    mov r0, r6
    mov r1, r6
    mov r2, #117
    mov r3, #0
    bl 0x2328030 ; DoMoveRecover
    b StartupAnimsPlayer

; Altar of Dreams field
Dreams:
    mov r0, r7
    mov r1, #1
    bl 0x2301E50
    cmp r0, 1h
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, #11
    bl 0x2301E50
    cmp r0, 1h
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, #18
    bl 0x2301E50
    cmp r0, 1h
    beq nextIterFieldEffects
    b MoonEffect

; Tomb of Nightmares' field
Nightmares:
    mov r0, r7
    mov r1, #8
    bl 0x2301E50
    cmp r0, 1h
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, #14
    bl 0x2301E50
    cmp r0, 1h
    beq nextIterFieldEffects
    mov r0, r7
    mov r1, #16
    bl 0x2301E50
    cmp r0, 1h
    beq nextIterFieldEffects
    b MoonEffect

; Clear Moon and Blood Moon constant damage
MoonEffect:    
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    beq nextIterFieldEffects
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne nextIterFieldEffects
    ldrsh r1, [r7, #+0x12]
    ldrsh r0, [r7, #+0x16]
    add r0, r0, r1 ; Compute the user's Max HP
    mov r1, #10
    bl 0x0208FEA4 ; EuclidianDivision
    add r0, r0, #1 ; Round to upper bound
    ldrh r1, [r7, #+0x10]
    cmp r0, r1
    suble r1, r1, r0
    movgt r1, #1
    strh r1, [r7, #+0x10]
    ldr r0, =#592
    mov r1, r6
    bl 0x23AF080
    cmp r5, 0h
    bgt StartupAnimsPlayer
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    cmp r0, #84  
    ldreq r1, =#1486
    ldrne r1, =#1487
    bl 0x234B498
    b StartupAnimsPlayer
    
; Riptide: deals damage equal to half the dealt damage this turn. If no damage, heal 80 HP instead.
RiptideField:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne nextIterFieldEffects
    ldr r0, [r8] 
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    beq StoreFirstRiptide
    bl CheckCurrentRiptide
    cmp r0, #0
    bgt DamageRiptide

HealRiptide:
    cmp r5, #0
    ldreq r1, =#1522 ; Lugia string 
    moveq r0, r6 ; User
    bleq 0x234B498
    mov r0, r6
    mov r1, r6
    mov r2, #80
    bl 0x231526C
    ldr r0, =#454
    mov r1, r6
    bl 0x23AF080
    b StartupAnimsPlayer

DamageRiptide:
    cmp r5, #0
    ldreq r1, =#1525 ; Lugia string 
    moveq r0, r6 ; User
    bleq 0x234B498
    mov r0, r0, lsr 1h
    add r0, r0, 1h
    ldrh r1, [r7, #0x10]
    cmp r1, r0
    movlt r1, #1
    strlth r1, [r7, #0x10]
    ldr r0, =#265
    mov r1, r6
    bl 0x23AF080
    b StartupAnimsPlayer

StoreFirstRiptide:
    mov r1, #4
    ldr r0,[r8]
    add r0,r0,r1,lsl 2h
    add r0,r0,12000h
    ldr r0,[r0,0B28h]
    ldr r1, [r0, #+0xb4] ; r4 = Pointer to the user's data
    ldrh r0, [r1, 0x10]
    strh r0, [CurrentRiptideHP]
    ldr r1, [PreviousRiptideHP]
    cmp r1, #0
    streqh r0, [PreviousRiptideHP]
    b nextIterFieldEffects

CheckCurrentRiptide:
    push lr
    ldr r2, [CurrentRiptideHP]
    strh r2, [PreviousRiptideHP]
    mov r1, #4
    ldr r0,[r8]
    add r0,r0,r1,lsl 2h
    add r0,r0,12000h
    ldr r0,[r0,0B28h]
    ldr r1, [r0, #+0xb4] ; r4 = Pointer to the user's data
    ldrh r0, [r1, 0x10]
    strh r0, [CurrentRiptideHP]
    subs r0, r2, r0 ; r2 - r0
    pop pc

PreviousRiptideHP:
    .word 0x0

CurrentRiptideHP:
    .word 0x0

    .pool

; Bosses Aura Boosts and other stuff
continueAura:
    ; Check Mysteriosity Rooms
    mov r5,4h ; r5: Loop counter
CheckAura:
    ldr r0,[r8]
    ldrb r0, [r0,748h]
    cmp r0, #110
    blt initCheckAura
    cmp r0, #182
    ble nextIterAura
    bl 0x0204C938
    mvn r1, #0
    cmp r0, r1 ; Check the special episode value
    bne nextIterAura
initCheckAura:
    ldr r0,[r8]
    add r0,r0,4000h
    ldrb r0,[r0,0DAh]
    bl 0x22E0864
    cmp r0, #0
    beq nextIterAura
    ; Get Entity
    ldr r0,[r8]
    add r0,r0,r5,lsl 2h
    add r0,r0,12000h
    ldr r6,[r0,0B28h]
    mov r0,r6
    bl 0x22E95F4 ; Checks if the entity is valid
    cmp r0,1h
    bne nextIterAura
    ldr r7, [r6, #+0xb4] ; r7 = Pointer to the user's data
    ; Check Vanilla Difficulty
    add r3, r7, 100h
    ldrh r1, [r7, #+0x2]
    cmp r1, #94 ; Gengar
    beq GengarMoveset
    cmp r1, #135 ; Jolteon
    beq JolteonMoveset
    cmp r1, #196 ; Espeon
    beq EspeonMoveset
    ; cmp r1, #209 ; TO DO: re-do species
    ; beq UnownMoveset
    ldr r0, =#275 ; Tyranitar
    cmp r0, r1
    beq TyranitarMoveset
    ldr r0, =#358 ; Flygon
    cmp r0, r1
    beq FlygonMoveset
    mov r0, #388 ; Dusclops
    cmp r0, r1
    beq DusclopsMoveset
    ldr r0, =#490 ; Lucario
    cmp r0, r1
    beq LucarioMoveset
    mov r0, #520 ; Froslass
    cmp r0, r1
    beq FroslassMoveset
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla difficulty
    bl 0x204B678
    cmp r0, 1h
    beq vanillaBossNerf ; Add Boss Nerf on Vanilla
    
; Fixing Bosses movepool
    add r3, r7, 100h
    ldrh r1, [r7, #+0x2]
    cmp r1, #40 ; Wigglytuff
    beq WigglytuffMoveset
    cmp r1, #50 ; Diglett
    beq DiglettMoveset
    cmp r1, #51 ; Dugtrio
    beq DiglettMoveset
    ldr r0, =#547 ; Muk
    cmp r0, r1
    beq MukMoveset
    cmp r1, #130 ; Gyarados
    beq GyaradosMoveset
    cmp r1, #144 ; Articuno
    beq ArticunoMoveset
    cmp r1, #145 ; Zapdos
    beq ZapdosMoveset
    cmp r1, #146 ; Moltres
    beq MoltresMoveset
    ldr r0, =#746 ; Moltres
    cmp r0, r1
    beq MoltresMoveset
    cmp r1, #150 ; Mewtwo
    beq MewtwoMoveset
    cmp r1, #151 ; Mew
    beq MewMoveset
    mov r0, #792 ; Sunflora
    cmp r0, r1
    beq SunfloraMoveset
    ldr r0, =#269 ; Blissey
    cmp r0, r1
    beq BlisseyMoveset
    ldr r0, =#270 ; Raikou
    cmp r0, r1
    beq RaikouMoveset
    ldr r0, =#271 ; Entei
    cmp r0, r1
    beq EnteiMoveset
    ldr r0, =#871 ; Entei
    cmp r0, r1
    beq EnteiMoveset
    mov r0, #272 ; Suicune
    cmp r0, r1
    beq SuicuneMoveset
    mov r0, #276 ; Lugia
    cmp r0, r1
    beq LugiaMoveset
    ldr r0, =#277 ; Ho-Oh
    cmp r0, r1
    beq HoOhMoveset
    ldr r0, =#322 ; Loudred
    cmp r0, r1
    beq LoudredMoveset
    ldr r0, =#330 ; Sableye
    cmp r0, r1
    beq SableyeMoveset
    ldr r0, =#369 ; Corphish
    cmp r0, r1
    beq CorphishMoveset
    mov r0, #372 ; Claydol
    cmp r0, r1
    beq ClaydolMoveset
    mov r0, #380 ; Diancie
    cmp r0, r1
    beq DiancieMoveset
    ldr r0, =#381 ; Marshadow
    cmp r0, r1
    beq MarshadowMoveset
    ldr r0, =#382 ; Eternatus
    cmp r0, r1
    beq EternatusMoveset
    ldr r0, =#990 ; Chimecho
    cmp r0, r1
    beq ChimechoMoveset
    ldr r0, =#409 ; Regirock
    cmp r0, r1
    beq RegirockMoveset
    ldr r0, =#410 ; Regice
    cmp r0, r1
    beq RegiceMoveset
    ldr r0, =#411 ; Registeel
    cmp r0, r1
    beq RegisteelMoveset
    ldr r0, =#412 ; Latias
    cmp r0, r1
    beq LatiasMoveset
    ldr r0, =#1012 ; Latias
    cmp r0, r1
    beq LatiasMoveset
    ldr r0, =#413 ; Latios
    cmp r0, r1
    beq LatiosMoveset
    ldr r0, =#1013 ; Latios
    cmp r0, r1
    beq LatiosMoveset
    ldr r0, =#414 ; Kyogre
    cmp r0, r1
    beq KyogreMoveset
    ldr r0, =#415 ; Groudon
    cmp r0, r1
    beq GroudonMoveset
    ldr r0, =#416 ; Rayquaza
    cmp r0, r1
    beq RayquazaMoveset
    ldr r0, =#418 ; Deoxys-Normal
    cmp r0, r1
    beq DeoNMoveset
    ldr r0, =#1018 ; Deoxys-Normal
    cmp r0, r1
    beq SDeoNMoveset
    ldr r0, =#419 ; Deoxys-Attack
    cmp r0, r1
    beq DeoAMoveset
    ldr r0, =#420 ; Deoxys-Defense
    cmp r0, r1
    beq DeoDMoveset
    ldr r0, =#421 ; Deoxys-Speed
    cmp r0, r1
    beq DeoSMoveset
    ldr r0, =#464 ; Gastrodon
    cmp r0, r1
    beq GastroMoveset
    ldr r0, =#465 ; Zoroark-H
    cmp r0, r1
    beq ZoroarkMoveset
    ldr r0, =#468 ; Drifblim
    cmp r0, r1
    beq DrifblimMoveset
    ldr r0, =#479 ; Bronzong
    cmp r0, r1
    beq BronzongMoveset
    ldr r0, =#483 ; Chatot
    cmp r0, r1
    beq ChatotMoveset
    ldr r0, =#495 ; Croagunk
    cmp r0, r1
    beq CroagunkMoveset
    ldr r0, =#506 ; Rhyperior
    cmp r0, r1
    beq RhyperiorMoveset
    ldr r0, =#516 ; Porygon-Z
    cmp r0, r1
    beq PZMoveset
    ldr r0, =#228 ; Dusknoir-Shiny
    cmp r0, r1
    beq DusknoirMoveset
    ldr r0, =#545 ; Ninetales-Alola
    cmp r0, r1
    beq NinetalesMoveset
    ldr r0, =#522 ; Uxie
    cmp r0, r1
    beq LakesMoveset
    ldr r0, =#523 ; Mesprit
    cmp r0, r1
    beq LakesMoveset
    ldr r0, =#524 ; Azelf
    cmp r0, r1
    beq LakesMoveset
    ldr r0, =#525 ; Dialga
    cmp r0, r1
    beq DialgaMoveset
    ldr r0, =#526 ; Palkia
    cmp r0, r1
    beq PalkiaMoveset
    ldr r0, =#527 ; Heatran
    cmp r0, r1
    beq HeatranMoveset
    ldr r0, =#528 ; Regigigas
    cmp r0, r1
    beq GigasMoveset
    ldr r0, =#529 ; Giratina-Alternate
    cmp r0, r1
    beq GiraMoveset
    ldr r0, =#530 ; Cresselia
    cmp r0, r1
    beq CresseliaMoveset
    ldr r0, =#1130 ; Cresselia?
    cmp r0, r1
    beq DarkraiMoveset
    ldr r0, =#532 ; Manaphy
    cmp r0, r1
    beq ManaphyMoveset
    ldr r0, =#533 ; Darkrai-Antagonist
    cmp r0, r1
    beq DarkraiMoveset
    ldr r0, =#535 ; Shaymin-Sky
    cmp r0, r1
    beq ShayminMoveset
    ldr r0, =#536 ; Giratina-Origin
    cmp r0, r1
    beq GiraMoveset
    ldr r0, =#537 ; Arceus
    cmp r0, r1
    beq ArceusMoveset
    ldr r0, =#538 ; Regieleki
    cmp r0, r1
    beq ElekiMoveset
    ldr r0, =#539 ; Regidrago
    cmp r0, r1
    beq DragoMoveset
    ldr r0, =#1143 ; Partner Grovyle
    cmp r0, r1
    beq GrovyleMoveset
    ldr r0, =#548 ; Genesect
    cmp r0, r1
    beq GenoMoveset
    ldr r0, =#1148 ; Genesect
    cmp r0, r1
    beq GenoMoveset
    ldr r0, =#549 ; Darkrai (Antagonist)
    cmp r0, r1
    beq ADarkraiMoveset
    ldr r0, =#551 ; Palkia-Primal
    cmp r0, r1
    beq PPalkiaMoveset
    ldr r0, =#552 ; Dialga-Primal
    cmp r0, r1
    beq PDialgaMoveset

    b PPZero
    .pool
; Pokemon Movesets

WigglytuffMoveset:
    mov r1, #39
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    mov r1, #105
    strh r1, [r3, #+0x030]
    mov r1, #6
    strb r1, [r3, #+0x033]
    ldr r1, =#553
    strh r1, [r3, #+0x038]
    mov r1, #6
    strb r1, [r3, #+0x03B]
    ldr r1, =#301
    strh r1, [r3, #+0x040]
    b PPZero

DiglettMoveset:
    mov r1, #8
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    ldr r1, =#484
    strh r1, [r3, #+0x030]
    ldr r1, =#515
    strh r1, [r3, #+0x038]
    ldr r1, =#420
    strh r1, [r3, #+0x040]
    b PPZero

GengarMoveset:
    mov r1, #50
    strb r1, [r7, #+0xA]
    ldr r1, =#331
    strh r1, [r3, #+0x028]
    mov r1, #129
    strh r1, [r3, #+0x030]
    ldr r1, =#546
    strh r1, [r3, #+0x038]
    mov r1, #216
    strh r1, [r3, #+0x040]
    b PPZero

MukMoveset:
    ldr r1, =#495
    strh r1, [r3, #+0x028]
    mov r1, #72
    strh r1, [r3, #+0x030]
    mov r1, #53
    strh r1, [r3, #+0x038]
    ldr r1, =#424
    strh r1, [r3, #+0x040]
    b PPZero

GyaradosMoveset:
    ldr r1, =#550
    strh r1, [r3, #+0x028]
    ldr r1, =#416
    strh r1, [r3, #+0x030]
    mov r1, #219
    strh r1, [r3, #+0x038]
    ldr r1, =#345
    strh r1, [r3, #+0x040]
    mov r1, #12
    strb r1, [r7, #+0xd2]
    strb r1, [r7, #+0xd3]
    b PPZero

JolteonMoveset:
    mov r1, #35
    strb r1, [r7, #+0xA]
    ldr r1, =#489
    strh r1, [r3, #+0x028]
    mov r1, #222
    strh r1, [r3, #+0x030]
    ldr r1, =#527
    strh r1, [r3, #+0x038]
    mov r1, #190
    strh r1, [r3, #+0x040]
    b PPZero

ArticunoMoveset:
    ldr r1, =#270
    strh r1, [r3, #+0x028]
    ldr r1, =#442
    strh r1, [r3, #+0x030]
    mov r1, #97
    strh r1, [r3, #+0x038]
    ldr r1, =#509
    strh r1, [r3, #+0x040]
    b PPZero

ZapdosMoveset:
    mov r1, #64
    strh r1, [r3, #+0x028]
    ldr r1, =#442
    strh r1, [r3, #+0x030]
    mov r1, #31
    strh r1, [r3, #+0x038]
    ldr r1, =#521
    strh r1, [r3, #+0x040]
    b PPZero

MoltresMoveset:
    mov r1, #230
    strh r1, [r3, #+0x028]
    ldr r1, =#442
    strh r1, [r3, #+0x030]
    mov r1, #151
    strh r1, [r3, #+0x038]
    ldr r1, =#548
    strh r1, [r3, #+0x040]
    b PPZero

MewtwoMoveset:
    mov r1, #146
    strh r1, [r3, #+0x028]
    mov r1, #12
    strb r1, [r3, #+0x12B]
    ldr r1, =#508
    strh r1, [r3, #+0x030]
    mov r1, #72
    strh r1, [r3, #+0x038]
    mov r1, #117
    strh r1, [r3, #+0x040]
    b PPZero

MewMoveset:
    ldr r1, [r8]
    add r1,r1,4000h
    ldrb r1,[r1,0DAh]
    cmp r1, #211
    moveq r1, #60
    streqb r1, [r3, #+0xA]
    moveq r1, #120
    streqb r1, [r3, #+0x1A]
    streqb r1, [r3, #+0x1B]
    streqb r1, [r3, #+0x1C]
    streqb r1, [r3, #+0x1D]
    b PPZero

SunfloraMoveset:
    mov r1, #253
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    mov r1, #76
    strh r1, [r3, #+0x030]
    ldr r1, =#443
    strh r1, [r3, #+0x038]
    mov r1, #10
    strh r1, [r3, #+0x040]
    b PPZero

EspeonMoveset:
    ldr r1, =#424
    strh r1, [r3, #+0x028]
    mov r1, #93
    strh r1, [r3, #+0x030]
    ldr r1, =#419
    strh r1, [r3, #+0x038]
    ldr r1, =#452
    strh r1, [r3, #+0x040]
    b PPZero

UnownMoveset:
    mov r1, #133
    strh r1, [r3, #+0x028]
    mov r1, #108
    strh r1, [r3, #+0x030]
    mov r1, #93
    strh r1, [r3, #+0x038]
    mov r1, #99
    strh r1, [r3, #+0x040]
    b PPZero

BlisseyMoveset:
    mov r1, #140
    strh r1, [r3, #+0x028]
    mov r1, #250
    strh r1, [r3, #+0x030]
    mov r1, #39
    strh r1, [r3, #+0x038]
    mov r1, #166
    strh r1, [r3, #+0x040]
    b PPZero

RaikouMoveset:
    ldr r1, =#521
    strh r1, [r3, #+0x028]
    ldr r1, =#508
    strh r1, [r3, #+0x030]
    ldr r1, =#424
    strh r1, [r3, #+0x038]
    mov r1, #185
    strh r1, [r3, #+0x040]
    b PPZero
    
EnteiMoveset:
    mov r1, #149
    strh r1, [r3, #+0x028]
    ldr r1, =#420
    strh r1, [r3, #+0x030]
    ldr r1, =#424
    strh r1, [r3, #+0x038]
    ldr r1, =#338
    strh r1, [r3, #+0x040]
    b PPZero
    
SuicuneMoveset:
    mov r1, #219
    strh r1, [r3, #+0x028]
    ldr r1, =#345
    strh r1, [r3, #+0x030]
    ldr r1, =#424
    strh r1, [r3, #+0x038]
    ldr r1, =#444
    strh r1, [r3, #+0x040]
    b PPZero

TyranitarMoveset:
    mov r1, #40
    strb r1, [r7, #+0xA]
    ldr r1, =#424
    strh r1, [r3, #+0x028]
    mov r1, #93
    strh r1, [r3, #+0x030]
    ldr r1, =#419
    strh r1, [r3, #+0x038]
    ldr r1, =#452
    strh r1, [r3, #+0x040]
    b PPZero

LugiaMoveset:
    ldr r1, =#353
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    ldr r1, =#484
    strh r1, [r3, #+0x030]
    mov r1, #117
    strh r1, [r3, #+0x038]
    mov r1, #219
    strh r1, [r3, #+0x040]
    b PPZero
    
HoOhMoveset:
    mov r1, #149
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    mov r1, #118
    strh r1, [r3, #+0x030]
    mov r1, #117
    strh r1, [r3, #+0x038]
    mov r1, #76
    strh r1, [r3, #+0x040]
    b PPZero

LoudredMoveset:
    mov r1, #241
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    mov r1, #112
    strh r1, [r3, #+0x030]
    mov r1, #195
    strh r1, [r3, #+0x038]
    mov r1, #27
    strh r1, [r3, #+0x040]
    b PPZero
      
SableyeMoveset:
    mov r1, #185
    strh r1, [r3, #+0x028]
    ldr r1, =#424
    strh r1, [r3, #+0x030]
    mov r1, #47
    strh r1, [r3, #+0x038]
    ldr r1, =#339
    strh r1, [r3, #+0x040]
    b PPZero

FlygonMoveset:
    mov r1, #40
    strb r1, [r7, #+0xA]
    ldr r1, =#420
    strh r1, [r3, #+0x028]
    mov r1, #208
    strh r1, [r3, #+0x030]
    ldr r1, =#346
    strh r1, [r3, #+0x038]
    mov r1, #167
    strh r1, [r3, #+0x040]
    b PPZero

CorphishMoveset:
    mov r1, #87
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    mov r1, #240
    strh r1, [r3, #+0x030]
    ldr r1, =#470
    strh r1, [r3, #+0x038]
    ldr r1, =#491
    strh r1, [r3, #+0x040]
    b PPZero

ClaydolMoveset:
    mov r1, #107
    strh r1, [r3, #+0x028]
    mov r1, #186
    strh r1, [r3, #+0x030]
    ldr r1, =#551
    strh r1, [r3, #+0x038]
    ldr r1, =#548
    strh r1, [r3, #+0x040]
    b PPZero

DiancieMoveset:
    mov r1, #99
    strh r1, [r3, #+0x064]
    mov r1, #10
    strh r1, [r3, #+0x066]
    b PPZero

MarshadowMoveset:
    mov r1, #247
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    ldr r1, =#437
    strh r1, [r3, #+0x030]
    ldr r1, =#500
    strh r1, [r3, #+0x038]
    ldr r1, =#451
    strh r1, [r3, #+0x040]
    b PPZero

EternatusMoveset:
    mov r1, #150
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    ldr r1, =#280
    strh r1, [r3, #+0x030]
    mov r1, #117
    strh r1, [r3, #+0x038]
    mov r1, #99
    strh r1, [r3, #+0x040]
    b PPZero
  
DusclopsMoveset:
    mov r1, #216
    strh r1, [r3, #+0x028]
    ldr r1, =#301
    strh r1, [r3, #+0x030]
    ldr r1, =#313
    strh r1, [r3, #+0x038]
    ldr r1, =#503
    strh r1, [r3, #+0x040]
    b PPZero

ChimechoMoveset:
    mov r1, #109
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    mov r1, #114
    strh r1, [r3, #+0x030]
    mov r1, #117
    strh r1, [r3, #+0x038]
    mov r1, #26
    strh r1, [r3, #+0x040]
    b PPZero
  
RegirockMoveset:
    mov r1, #30
    strh r1, [r3, #+0x028]
    ldr r1, =#551
    strh r1, [r3, #+0x030]
    ldr r1, =#420
    strh r1, [r3, #+0x038]
    mov r1, #72
    strh r1, [r3, #+0x040]
    b PPZero
    
RegiceMoveset:
    ldr r1, =#270
    strh r1, [r3, #+0x028]
    mov r1, #129
    strh r1, [r3, #+0x030]
    ldr r1, =#536
    strh r1, [r3, #+0x038]
    mov r1, #97
    strh r1, [r3, #+0x040]
    b PPZero
    
RegisteelMoveset:
    ldr r1, =#536
    strh r1, [r3, #+0x028]
    mov r1, #129
    strh r1, [r3, #+0x030]
    ldr r1, =#420
    strh r1, [r3, #+0x038]
    mov r1, #30
    strh r1, [r3, #+0x040]
    b PPZero
    
LatiasMoveset:
    ldr r1, =#539
    strh r1, [r3, #+0x028]
    ldr r1, =#309
    strh r1, [r3, #+0x030]
    mov r1, #3
    strb r1, [r3, #+0x033]
    ldr r1, =#427
    strh r1, [r3, #+0x038]
    mov r1, #185
    strh r1, [r3, #+0x040]
    b PPZero
    
LatiosMoveset:
    ldr r1, =#539
    strh r1, [r3, #+0x028]
    ldr r1, =#335
    strh r1, [r3, #+0x030]
    mov r1, #3
    strb r1, [r3, #+0x033]
    ldr r1, =#427
    strh r1, [r3, #+0x038]
    mov r1, #95
    strh r1, [r3, #+0x040]
    b PPZero
    
KyogreMoveset:
    ldr r1, =#361
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    mov r1, #219
    strh r1, [r3, #+0x030]
    mov r1, #64
    strh r1, [r3, #+0x038]
    ldr r1, =#345
    strh r1, [r3, #+0x040]
    b PPZero
    
GroudonMoveset:
    ldr r1, =#362
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    ldr r1, =#292
    strh r1, [r3, #+0x030]
    mov r1, #30
    strh r1, [r3, #+0x038]
    mov r1, #72
    strh r1, [r3, #+0x040]
    b PPZero
    
RayquazaMoveset:
    ldr r1, =#404
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02B]
    ldr r1, =#538
    strh r1, [r3, #+0x030]
    mov r1, #157
    strh r1, [r3, #+0x038]
    mov r1, #91
    strh r1, [r3, #+0x040]
    b PPZero

DeoNMoveset:
    mov r1, #110
    strh r1, [r3, #+0x028]
    mov r1, #72
    strh r1, [r3, #+0x030]
    ldr r1, =#544
    strh r1, [r3, #+0x038]
    mov r1, #117
    strh r1, [r3, #+0x040]
    ldreq r1, =#308
    streq r1, [r7, #+0x34]
    streq r1, [r7, #+0x38]
    streq r1, [r7, #+0x3C]
    streq r1, [r7, #+0x40]
    b PPZero

SDeoNMoveset:
    ldr r1, [r8]
    add r1,r1,4000h
    ldrb r1,[r1,0DAh]
    cmp r1, #214
    moveq r1, #65
    streqb r1, [r7, #+0xA]
    moveq r1, #120
    streqb r1, [r7, #+0x1A]
    streqb r1, [r7, #+0x1B]
    streqb r1, [r7, #+0x1C]
    streqb r1, [r7, #+0x1D]
    b PPZero
    
DeoAMoveset:
    mov r1, #110
    strh r1, [r3, #+0x028]
    ldr r1, =#345
    strh r1, [r3, #+0x030]
    mov r1, #129
    strh r1, [r3, #+0x038]
    ldr r1, =#500
    strh r1, [r3, #+0x040]
    ldreq r1, =#384
    streq r1, [r7, #+0x34]
    streq r1, [r7, #+0x38]
    moveq r1, #128
    streq r1, [r7, #+0x3C]
    streq r1, [r7, #+0x40]
    b PPZero
    
DeoDMoveset:
    mov r1, #216
    strh r1, [r3, #+0x028]
    mov r1, #117
    strh r1, [r3, #+0x030]
    mov r1, #192
    strh r1, [r3, #+0x038]
    ldr r1, =#259
    strh r1, [r3, #+0x040]    
    moveq r1, #64
    streq r1, [r7, #+0x34]
    streq r1, [r7, #+0x38]
    ldreq r1, =#340
    streq r1, [r7, #+0x3C]
    streq r1, [r7, #+0x40]
    b PPZero
    
DeoSMoveset:
    mov r1, #110
    strh r1, [r3, #+0x028]
    mov r1, #216
    strh r1, [r3, #+0x030]
    mov r1, #117
    strh r1, [r3, #+0x038]
    mov r1, #95
    strh r1, [r3, #+0x040]
    moveq r1, 0x4
    streq r1, [r7, #+0x110]
    streq r1, [r7, #+0x114]
    moveq r1, 0x0
    streq r1, [r7, #+0x119]
    b PPZero
    
GastroMoveset:
    mov r1, #159
    strh r1, [r3, #+0x028]
    ldr r1, =#484
    strh r1, [r3, #+0x030]
    ldr r1, =#345
    strh r1, [r3, #+0x038]
    mov r1, #51
    strh r1, [r3, #+0x040]
    b PPZero

ZoroarkMoveset:
    mov r1, #90
    strb r1, [r7, #+0xA]
    ldr r1, =#293
    strh r1, [r3, #+0x028]
    mov r1, #121
    strh r1, [r3, #+0x030]
    ldr r1, =#437
    strh r1, [r3, #+0x038]
    ldr r1, =#312
    strh r1, [r3, #+0x040]
    b PPZero

DrifblimMoveset:
    ldr r1, =#437
    strh r1, [r3, #+0x028]
    mov r1, #127
    strh r1, [r3, #+0x030]
    mov r1, #97
    strh r1, [r3, #+0x038]
    ldr r1, =#444
    strh r1, [r3, #+0x040]
    b PPZero
    
BronzongMoveset:
    mov r1, #127
    strh r1, [r3, #+0x028]
    ldr r1, =#420
    strh r1, [r3, #+0x030]
    mov r1, #83
    strh r1, [r3, #+0x038]
    ldr r1, =#266
    strh r1, [r3, #+0x040]
    b PPZero
    
ChatotMoveset:
    ldr r1, =#442
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    mov r1, #230
    strh r1, [r3, #+0x030]
    mov r1, #241
    strh r1, [r3, #+0x038]
    ldr r1, =#444
    strh r1, [r3, #+0x040]
    b PPZero

LucarioMoveset:
    mov r1, #40
    strb r1, [r7, #+0xA]
    ldr r1, =#423
    strh r1, [r3, #+0x028]
    mov r1, #72
    strh r1, [r3, #+0x030]
    ldr r1, =#325
    strh r1, [r3, #+0x038]
    ldr r1, =#305
    strh r1, [r3, #+0x040]
    b PPZero

CroagunkMoveset:
    ldr r1, =#500
    strh r1, [r3, #+0x028]
    mov r1, #3
    strb r1, [r3, #+0x02B]
    ldr r1, =#280
    strh r1, [r3, #+0x030]
    ldr r1, =#515
    strh r1, [r3, #+0x038]
    mov r1, #51
    strh r1, [r3, #+0x040]
    b PPZero
      
RhyperiorMoveset:
    ldr r1, =#453
    strh r1, [r3, #+0x028]
    ldr r1, =#422
    strh r1, [r3, #+0x030]
    ldr r1, =#323
    strh r1, [r3, #+0x038]
    mov r1, #51
    strh r1, [r3, #+0x040]
    b PPZero
        
PZMoveset:
    ldr r1, =#521
    strh r1, [r3, #+0x028]
    ldr r1, =#345
    strh r1, [r3, #+0x030]
    ldr r1, =#436
    strh r1, [r3, #+0x038]
    ldr r1, =#298
    strh r1, [r3, #+0x040]
    b PPZero

DusknoirMoveset:
    ldr r1, =#451
    strh r1, [r3, #+0x028]
    ldr r1, =#500
    strh r1, [r3, #+0x030]
    mov r1, #216
    strh r1, [r3, #+0x038]
    mov r1, #35
    strh r1, [r3, #+0x040]
    ; Embargo
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r1, #2
    strb r1, [r7, #+0xDB]
    b PPZero

FroslassMoveset:
    mov r1, #40
    strb r1, [r7, #+0xA]
    ldr r1, =#543
    strh r1, [r3, #+0x028]
    mov r1, #97
    strh r1, [r3, #+0x030]
    ldr r1, =#531
    strh r1, [r3, #+0x038]
    ldr r1, =#331
    strh r1, [r3, #+0x040]
    b PPZero

NinetalesMoveset:
    ldr r1, =#270
    strh r1, [r3, #+0x028]
    ldr r1, =#544
    strh r1, [r3, #+0x030]
    mov r1, #97
    strh r1, [r3, #+0x038]
    ldr r1, =#545
    strh r1, [r3, #+0x040]
    b PPZero
    
LakesMoveset:
    ldr r1, =#463
    strh r1, [r3, #+0x028]
    ldr r1, =#508
    strh r1, [r3, #+0x030]
    ldr r1, =#402
    strh r1, [r3, #+0x038]
    mov r1, #3
    strh r1, [r3, #+0x040]
    b PPZero
    
DialgaMoveset:
    ldr r1, =#494
    strh r1, [r3, #+0x028]
    mov r1, #12
    strb r1, [r3, #+0x02b]
    ldr r1, =#536
    strh r1, [r3, #+0x030]
    mov r1, #72
    strh r1, [r3, #+0x038]
    ldr r1, =#345
    strh r1, [r3, #+0x040]
    b PPZero
    
PalkiaMoveset:
    ldr r1, =#435
    strh r1, [r3, #+0x028]
    mov r1, #12
    strb r1, [r3, #+0x02b]
    mov r1, #219
    strh r1, [r3, #+0x030]
    mov r1, #72
    strh r1, [r3, #+0x038]
    mov r1, #53
    strh r1, [r3, #+0x040]
    b PPZero
    
HeatranMoveset:
    mov r1, #230
    strh r1, [r3, #+0x028]
    mov r1, #151
    strh r1, [r3, #+0x030]
    ldr r1, =#484
    strh r1, [r3, #+0x038]
    ldr r1, =#532
    strh r1, [r3, #+0x040]
    b PPZero
    
GigasMoveset:
    ldr r1, =#455
    strh r1, [r3, #+0x028]
    ldr r1, =#420
    strh r1, [r3, #+0x030]
    ldr r1, =#500
    strh r1, [r3, #+0x038]
    mov r1, #30
    strh r1, [r3, #+0x040]
    b PPZero

CresseliaMoveset:
    ldr r1, =#544
    strh r1, [r3, #+0x028]
    mov r1, #97
    strh r1, [r3, #+0x030]
    mov r1, #173
    strh r1, [r3, #+0x038]
    ldr r1, =#301
    strh r1, [r3, #+0x040]
    b PPZero
    
ManaphyMoveset:
    mov r1, #219
    strh r1, [r3, #+0x028]
    ldr r1, =#345
    strh r1, [r3, #+0x030]
    ldr r1, =#546
    strh r1, [r3, #+0x038]
    ldr r1, =#288
    strh r1, [r3, #+0x040]
    b PPZero
    
DarkraiMoveset:
    mov r1, #109
    strh r1, [r3, #+0x028]
    mov r1, #56
    strh r1, [r3, #+0x030]
    ldr r1, =#436
    strh r1, [r3, #+0x038]
    mov r1, #6
    strb r1, [r3, #+0x03b]
    ldr r1, =#483
    strh r1, [r3, #+0x040]
    b PPZero
    
ShayminMoveset:
    ldr r1, =#468
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02b]
    ldr r1, =#442
    strh r1, [r3, #+0x030]
    ldr r1, =#484
    strh r1, [r3, #+0x038]
    mov r1, #238
    strh r1, [r3, #+0x040]
    b PPZero
    
GiraMoveset:
    ldr r1, =#543
    strh r1, [r3, #+0x028]
    ldr r1, =#508
    strh r1, [r3, #+0x030]
    ldr r1, =#319
    strh r1, [r3, #+0x038]
    ldr r1, =#301
    strh r1, [r3, #+0x040]
    b PPZero

ElekiMoveset:
    ldr r1, =#521
    strh r1, [r3, #+0x028]
    mov r1, #131
    strh r1, [r3, #+0x030]
    mov r1, #42
    strh r1, [r3, #+0x038]
    mov r1, #95
    strh r1, [r3, #+0x040]
    b PPZero

DragoMoveset:
    mov r1, #150
    strh r1, [r3, #+0x028]
    mov r1, #91
    strh r1, [r3, #+0x030]
    mov r1, #157
    strh r1, [r3, #+0x038]
    mov r1, #104
    strh r1, [r3, #+0x040]
    b PPZero

GrovyleMoveset:
    ldr r1, =#340
    str r1, [r3, #+0x34]
    str r1, [r3, #+0x38]
    str r1, [r3, #+0x3C]
    str r1, [r3, #+0x40]
    ldr r1, =#336
    strh r1, [r3, #+0x028]
    mov r1, #76
    strh r1, [r3, #+0x030]
    mov r1, #8
    strh r1, [r3, #+0x038]
    ldr r1, =#442
    strh r1, [r3, #+0x040]
    ; Embargo
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r1, #2
    strb r1, [r7, #+0xDB]
    ; X-Ray Specs
    mov r1, #1
    strh r1, [r7, #+0x62]
    mov r1, #0
    strh r1, [r7, #+0x64]
    mov r1, #24
    strh r1, [r7, #+0x66]
    strh r1, [r7, #+0x68]
    b PPZero

GenoMoveset:
    mov r1, #54
    strh r1, [r3, #+0x028]
    mov r1, #6
    strb r1, [r3, #+0x02b]
    mov r1, #80
    strh r1, [r3, #+0x030]
    ldr r1, =#270
    strh r1, [r3, #+0x038]
    mov r1, #93
    strh r1, [r3, #+0x040]
    b PPZero

ArceusMoveset:
    ldr r1, =#467
    strh r1, [r3, #+0x028]
    mov r1, #255
    strb r1, [r3, #+0x02b]
    mov r1, #117
    strh r1, [r3, #+0x030]
    mov r1, #255
    strb r1, [r3, #+0x033]
    mov r1, #99
    strh r1, [r3, #+0x038]
    mov r1, #255
    strb r1, [r3, #+0x03b]
    ldr r1, =#301
    strh r1, [r3, #+0x040]
    mov r1, #255
    strb r1, [r3, #+0x043]
    ; Embargo
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r1, #2
    strb r1, [r7, #+0xDB]
    b PPZero
    
ADarkraiMoveset:
    ldr r1, =#436
    strh r1, [r3, #+0x038]
    mov r1, #6
    strb r1, [r3, #+0x03b]
    ldr r1, =#483
    strh r1, [r3, #+0x040]
    ; Embargo
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r1, #2
    strb r1, [r7, #+0xDB]
    b PPZero
    
PPalkiaMoveset:
    ldr r1, =#435
    strh r1, [r3, #+0x038]
    mov r1, #3
    strb r1, [r3, #+0x03b]
    mov r1, #219
    strh r1, [r3, #+0x040]
    b PPZero
    
PDialgaMoveset:
    ldr r1, =#494
    strh r1, [r3, #+0x038]
    mov r1, #3
    strb r1, [r3, #+0x03b]
    ldr r1, =#536
    strh r1, [r3, #+0x040]
    b PPZero
    .pool
; Anti PP-Zero code
PPZero:
    mov r1, #3
    strb r1, [r7, #+0x12a]
    strb r1, [r7, #+0x132]
    strb r1, [r7, #+0x13a]
    strb r1, [r7, #+0x142]

; Field effects depending on the dungeon
    ldr r0, [r8]
    ldrb r0,[r0,748h]

    cmp r0, #16 ; Fogbound Lake
    beq Lakes

    cmp r0, #19 ; Amp Clearing
    moveq r3, #255

    cmp r0, #23 ; Underground Lake
    beq Lakes

    cmp r0, #26 ; Crystal Lake
    beq Lakes

    cmp r0, #37 ; Brine Cave Pit
    beq Kabutops

    cmp r0, #40 ; Old Ruins
    beq Dusknoir

    cmp r0, #43 ; Temporal Pinnacle
    beq fieldDP

    cmp r0, #45 ; Mystifying Forest
    beq Friendship

    cmp r0, #49 ; Crevice Cave
    beq Froslass

    cmp r0, #53 ; Miracle Seabed
    moveq r3, #255

    cmp r0, #55 ; Ice Aegis Cave
    beq Regice

    cmp r0, #57 ; Rock Aegis Cave
    beq Regirock

    cmp r0, #59 ; Steel Aegis Cave
    beq Registeel

    cmp r0, #11 ; SplitDecision Aegis Cave
    beq SplitDecision

    cmp r0, #61 ; Aegis Cave Pit
    beq Regigigas

    cmp r0, #63 ; The Nightmare
    beq Illusion

    cmp r0, #66 ; Spacial Rift Bottom
    beq fieldDP

    cmp r0, #69 ; Dark Crater Pit
    moveq r3, #255
    ldreq r1,[r8]
    addeq r1,r1,4000h
    ldreqb r1,[r1,0DAh]
    cmpeq r1, #77
    streqb r3, [r7, #+0x1A]
    streqb r3, [r7, #+0x1B]
    streqb r3, [r7, #+0x1C]
    streqb r3, [r7, #+0x1D]
    beq CheckStatus

    cmp r0, #71 ; Training Grounds
    moveq r1, #2
    streqb r1, [r7, #+0x34]
    streqb r1, [r7, #+0x38]
    streqb r1, [r7, #+0x3C]
    streqb r1, [r7, #+0x40]

    cmp r0, #73  ; Bottomless Sea
    beq Kyogre

    cmp r0, #74 ; Flower Paradise
    beq SpeedBoost

    cmp r0, #75 ; Shimmer Desert
    beq Groudon

    cmp r0, #76 ; Genesis Island
    moveq r3, #255

    cmp r0, #77 ; Mt. Avalanche
    ldreq r1, =#340
    streqb r1, [r7, #+0x3C]
    streqb r1, [r7, #+0x40]
    moveq r3, #255
    beq CheckStatus

    cmp r0, #78 ; Thundercap Mt.
    beq Zapdos

    cmp r0, #79 ; Giant Volcano
    ldreq r1, =#340
    streqb r1, [r7, #+0x34]
    streqb r1, [r7, #+0x38]
    moveq r3, #255
    beq CheckStatus

    cmp r0, #80 ; Fire Field
    moveq r3, #255

    cmp r0, #81 ; World Abyss
    moveq r3, #255

    cmp r0, #82 ; Trackless Forest
    beq Omniboost

    cmp r0, #83 ; Sky Stairway
    beq Rayquaza

    cmp r0, #84 ; Altar of Dreams
    moveq r3, #255
    beq CheckStatus

    cmp r0, #85 ; Mystery Jungle
    moveq r3, #255
    beq CelebiDaydream

    cmp r0, #86 ; Mysterious Geoglyph
    beq SplitDecision

    cmp r0, #105 ; Destiny Pinnacle
    beq Arceus

    cmp r0, #106 ; Tomb of Nightmares
    moveq r3, #255
    beq CheckStatus

    cmp r0, #122 ; Sky Peak
    moveq r3, #255

    cmp r0, #161 ; Fallen Star Remains
    moveq r3, #255
    beq PorygonZ

    cmp r0, #166 ; Fallen Star Remains
    beq Deoxys

    cmp r0, #169 ; Mirage Island
    ldreq r1, =#384
    streq r1, [r7, #+0x38]
    streq r1, [r7, #+0x40]
    moveq r3, #255
    ldreq r1,[r8]
    addeq r1,r1,4000h
    ldreqb r1,[r1,0DAh]
    cmpeq r1, #46
    streqb r3, [r7, #+0x1A]
    streqb r3, [r7, #+0x1B]
    streqb r3, [r7, #+0x1C]
    streqb r3, [r7, #+0x1D]
    beq CheckStatus

    cmp r0, #171 ; Mineral Crust
    beq MineralCrust

    cmp r0, #172 ; Peak of Renewal
    beq RainbowField

    cmp r0, #173 ; Mount Tensei
    moveq r3, #255
    beq CheckStatus

    cmp r0, #175
    beq DarkestDay

    cmp r0, #179 ; Wishing Room
    beq PeriodicOrbit
    b difficultBossNerf

; Shows Aura Boost message and the exact Aura message accordingly
CheckStatus:    
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne ClearStatus
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne ClearStatus
    cmp r3, #255
    bne difficultBossNerf
    cmp r5, 4h
    bgt StartupAnims
    ldr r1, =#1490
    bl 0x234B498
    ldr r0, [r8]
    ldrb r0,[r0,748h]

    cmp r0, 0x10 ; Fogbound Lake
    ldreq r1, =#1491

    cmp r0, 0x13 ; Amp Plains
    ldreq r1, =#1492

    cmp r0, 0x17 ; Underground Lake
    ldreq r1, =#1491

    cmp r0, 0x1a ; Crystal Lake
    ldreq r1, =#1491

    cmp r0, 0x25 ; Brine Cave Pit
    ldreq r1, =#1493

    cmp r0, 0x28 ; Old Ruins
    ldreq r1, =#1494

    cmp r0, 0x2B ; Temporal Pinnacle
    ldreq r1, =#1495

    cmp r0, 0x31 ; Crevice Cave
    ldreq r1, =#1496

    cmp r0, 0x35 ; Miracle Seabed
    ldreq r1, =#1492

    cmp r0, 0x37 ; Ice Aegis Cave
    ldreq r1, =#1497

    cmp r0, 0x39 ; Rock Aegis Cave
    ldreq r1, =#1498

    cmp r0, 0x3B ; Steel Aegis Cave
    ldreq r1, =#1499

    cmp r0, 0x0B ; Split Decision Aegis Cave
    ldreq r1, =#1500

    cmp r0, 0x3D ; Aegis Cave Pit
    ldreq r1, =#1501

    cmp r0, 0x42 ; Spacial Rift Bottom
    ldreq r1, =#1502

    cmp r0, 0x45 ; Dark Crater Pit
    ldreq r1, =#1503

    cmp r0, 0x49  ; Bottomless Sea
    ldreq r1, =#1504

    cmp r0, 0x4A ; Flower Paradise
    ldreq r1, =#1505

    cmp r0, 0x4B ; Shimmer Desert
    ldreq r1, =#1506

    cmp r0, 0x4C ; Genesis Island
    ldreq r1, =#1507

    cmp r0, 0x4D ; Mt. Avalanche
    ldreq r1, =#1508

    cmp r0, 0x4e ; Thundercap Mt.
    ldreq r1, =#1509

    cmp r0, 0x4F ; Giant Volcano
    ldreq r1, =#1510

    cmp r0, 0x50 ; Fire Field
    ldreq r1, =#1511

    cmp r0, 0x51 ; World Abyss
    ldreq r1, =#1512

    cmp r0, 0x52 ; Trackless Forest
    ldreq r1, =#1501

    cmp r0, 0x53 ; Sky Stairway
    ldreq r1, =#1513

    cmp r0, 0x54 ; Altar of Dreams
    ldreq r1, =#1514

    cmp r0, 0x55 ; Mystery Jungle
    ldreq r1, =#1543 ; Daydream Field String

    cmp r0, 0x56 ; Mysterious Geoglyph
    ldreq r1, =#1540

    cmp r0, 0x69 ; Destiny Pinnacle
    ldreq r1, =#1515

    cmp r0, 0x6a ; Tomb of Nightmares
    ldreq r1, =#1503

    cmp r0, 0x7a ; Sky Peak
    ldreq r1, =#1516

    cmp r0, 0xa1 ; Rift Boundary
    ldreq r1, =#1517

    cmp r0, 0xa6 ; Fallen Star Remains
    ldreq r1, =#1518

    cmp r0, 0xa9 ; Mirage Island
    ldreq r1, =#1519

    cmp r0, 0xaa ; Sea Shrine
    ldreq r1, =#1520

    cmp r0, 0xab ; Mineral Crust
    ldreq r1, =#1527

    cmp r0, 0xac ; Peak of Renewal
    ldreq r1, =#1521

    cmp r0, 0xad ; Mount Tensei
    ldreq r1, =#1528

    cmp r0, 0xaf ; Atomic Wastes
    ldreq r1, =#1529

    cmp r0, 0xb3 ; Wishing Room
    ldreq r1, =#1524

    bl 0x234B498

; Field effect anims upon entering the floor
StartupAnims:
    ldr r0, [r8]
    ldrb r0,[r0,748h]

    cmp r0, 0x10 ; Fogbound Lake
    ldreq r1, =#321

    cmp r0, 0x13 ; Amp Clearing
    moveq r1, #0

    cmp r0, 0x17 ; Underground Lake
    ldreq r1, =#321

    cmp r0, 0x1a ; Crystal Lake
    ldreq r1, =#321

    cmp r0, 0x25 ; Brine Cave Pit
    moveq r1, #130

    cmp r0, 0x28 ; Old Ruins
    ldreq r1, =#321

    cmp r0, 0x2B ; Temporal Pinnacle
    moveq r1, #81

    cmp r0, 0x31 ; Crevice Cave
    moveq r1, #232

    cmp r0, 0x35 ; Miracle Seabed
    moveq r1, #0

    cmp r0, 0x37 ; Ice Aegis Cave
    ldreq r1, =#313

    cmp r0, 0x39 ; Rock Aegis Cave
    ldreq r1, =#313

    cmp r0, 0x3B ; Steel Aegis Cave
    ldreq r1, =#313

    cmp r0, 0x0B ; Split Decision Aegis Cave
    ldreq r1, =#425

    cmp r0, 0x3D ; Aegis Cave Pit
    ldreq r1, =#319

    cmp r0, 0x42 ; Spacial Rift Bottom
    moveq r1, #81

    cmp r0, 0x49  ; Bottomless Sea
    ldreq r1, =#425

    cmp r0, 0x4A ; Flower Paradise
    ldreq r1, =#427

    cmp r0, 0x4B ; Shimmer Desert
    ldreq r1, =#425

    cmp r0, 0x4C ; Genesis Island
    moveq r1, #0

    cmp r0, 0x4D ; Mt. Avalanche
    ldreq r1, =#321

    cmp r0, 0x4e ; Thundercap Mt.
    ldreq r1, =#421

    cmp r0, 0x4F ; Giant Volcano
    moveq r1, #130

    cmp r0, 0x50 ; Fire Field
    moveq r1, #0

    cmp r0, 0x51 ; World Abyss
    moveq r1, #0    

    cmp r0, 0x52 ; Trackless Forest
    ldreq r1, =#319

    cmp r0, 0x53 ; Sky Stairway
    ldreq r1, =#425    

    cmp r0, 0x54 ; Altar of Dreams
    moveq r1, #0

    cmp r0, 0x55 ; Mystery Jungle
    moveq r1, #0

    cmp r0, 0x56 ; Mysterious Geoglyph
    ldreq r1, =#425

    cmp r0, 0x69 ; Destiny Pinnacle
    ldreq r1, =#428

    cmp r0, 0x6a ; Tomb of Nightmares
    moveq r1, #0   

    cmp r0, 0x7a ; Sky Peak
    moveq r1, #0

    cmp r0, 0xa1 ; Rift Boundary
    ldreq r1, =#285

    cmp r0, 0xa6 ; Fallen Star Remains
    ldreq r1, =#521

    cmp r0, 0xa9 ; Mirage Island
    ldreq r1, =#471

    cmp r0, 0xaa ; Sea Shrine
    ldreq r1, =0x1b8

    cmp r0, 0xac ; Peak of Renewal
    ldreq r1, =0x1bd

    cmp r0, 0xaf ; Atomic Wastes
    moveq r1, #85

    cmp r0, 0xb3 ; Wishing Room
    moveq r1, #151

    mov r0, r1
    mov r1, r6
    bl 0x23AF080

    mov r0, r6
    bl 0x22E3AB4
; Checks if statuses are cleared
ClearStatus:
    cmp r5, 4h
    beq ContinueClearStatus
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x39
    bl 0x204B678
    cmp r0, 1h
    beq difficultBossNerf
ContinueClearStatus:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne difficultBossNerf
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    cmp r0, 2h
    beq difficultBossNerf
    cmp r0, 5h
    beq difficultBossNerf
    cmp r0, 13h
    beq difficultBossNerf
    cmp r0, 25h
    beq difficultBossNerf
    cmp r0, 28h
    beq difficultBossNerf
    cmp r0, 31h
    beq difficultBossNerf
    cmp r0, 35h
    beq difficultBossNerf
    cmp r0, 7Ah
    beq difficultBossNerf

; Random Number function
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x39
    bl 0x204B678
    cmp r0, 1h
    moveq r2, #12
    beq RandomChance
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3A
    bl 0x204B678
    cmp r0, 1h
    moveq r2, #25
    beq RandomChance
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    moveq r2, #50
    beq RandomChance

RandomChance:
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    cmp r0, r2
    bge difficultBossNerf   
    mov  r1, r6
    mov  r0, #0x1
    mov  r2, #0x0
    bl 0x022E2AD8
    mov r0, r6 ; User
    mov r1, r6
    ldr r2, =#1488
    bl 0x234B350

; Clear Statuses
ProceedClear:
    push r0-r3
    mov r0, r6
    mov r1, r6
    ldr r2, =#339
    mov r3, #0
    bl 0x2326188 ; DoMoveRefresh
    cmp r0, #1
    pop r0-r3
    bne difficultBossNerf
    /*mov r0, #0
    strb r0, [r7, #+0xBD]
    strb r0, [r7, #+0xBF]
    strb r0, [r7, #+0xC4]
    strb r0, [r7, #+0xD0]
    strb r0, [r7, #+0xD8]
    strb r0, [r7, #+0xF1]
    strb r0, [r7, #+0x104]*/
    ldr r0, =0x30
    mov r1, r6
    bl 0x23AF080

difficultBossNerf:
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne nextIterAura
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne nextIterAura
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x39
    bl 0x204B678
    cmp r0, 1h
    bne nextIterAura
    ldrb r3, [r7, #+0x1A]
    mov r0, #8
    mul r0, r3, r0
    mov r1, #9
    bl 0x208FEA4
    strb r0, [r7, #+0x1A]
    ldrb r3, [r7, #+0x1B]
    mov r0, #8
    mul r0, r3, r0
    mov r1, #9
    bl 0x208FEA4
    strb r0, [r7, #+0x1B]
    ldrb r3, [r7, #+0x1C]
    mov r0, #8
    mul r0, r3, r0
    mov r1, #9
    bl 0x208FEA4
    strb r0, [r7, #+0x1C]
    ldrb r3, [r7, #+0x1D]
    mov r0, #8
    mul r0, r3, r0
    mov r1, #9
    bl 0x208FEA4
    strb r0, [r7, #+0x1D]
    b nextIterAura

vanillaBossNerf:
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    bne nextIterAura
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne nextIterAura
    ldrb r3, [r7, #+0x1A]
    add r3, r3, r3, lsl 1h
    lsr r3, 2h
    strb r3, [r7, #+0x1A]
    ldrb r3, [r7, #+0x1B]
    add r3, r3, r3, lsl 1h
    lsr r3, 2h
    strb r3, [r7, #+0x1B]
    ldrb r3, [r7, #+0x1C]
    add r3, r3, r3, lsl 1h
    lsr r3, 2h
    strb r3, [r7, #+0x1C]
    ldrb r3, [r7, #+0x1D]
    add r3, r3, r3, lsl 1h
    lsr r3, 2h
    strb r3, [r7, #+0x1D]

nextIterAura:
    ; code ici
    add r5,r5,1h
    cmp r5,0x14
    blt CheckAura
    ldr r1, =EntitiesAlive
    mov r0, #0
    strb r0, [r1]
    b return

; Lake fights
Lakes:
    mov r1, #14
    strb r1, [r7, #+0xD5]
    mov r1, #2
    strb r1, [r7, #+0xD6]
    strb r1, [r7, #+0xD7]
    mov r3, #255
    b CheckStatus

; Kabutops' aura boost
Kabutops:
    mov r1, #4
    strb r1, [r7, #+0xEC]
    strb r1, [r7, #+0xED]
    mov r3, #255
    b CheckStatus

; Old Ruins' field effect
Dusknoir:
    mov r1, #10
    strb r1, [r7, #+0xD5]
    mov r1, #2
    strb r1, [r7, #+0xD6]
    strb r1, [r7, #+0xD7]
    mov r3, #255
    b CheckStatus

; Guild's aura boost
Friendship:
    ldr r1, =#296
    str r1, [r7, #+0x3C]
    str r1, [r7, #+0x40]
    b MemoryBoost

; Froslass' aura boost
Froslass:
    bl 0x22F92D8 ; Try Activate Artificial Weather Abilities
    mov r1, #12
    strh r1, [r7, #+0x2e]
    mov r3, #255
    b MemoryBoost

; Regice's aura boost
Regice:
    ldr r1, =#512
    str r1, [r7, #+0x40]
    mov r3, #255
    b CheckStatus

; Regirock's aura boost
Regirock:
    ldr r1, =#512
    str r1, [r7, #+0x3C]
    mov r3, #255
    b CheckStatus

; Registeel's' aura boost
Registeel:
    ldr r1, =#320
    str r1, [r7, #+0x3C]
    str r1, [r7, #+0x40]
    mov r3, #255
    b CheckStatus

; Celebi's Daydream
CelebiDaydream:
    push r0-r3
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h] ; Turns left
    mov r1, #4
    bl 0x0208FEA4 ; EuclidianDivision
    cmp r1, #1 ; If turns left is (4k+1)
    pop r0-r3
    bne CheckStatus
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0, 3h
    bne CheckStatus
    ; String 1542 for Daydream
    mov r0, #0
    mov r1, r6
    bl 0x0234B084
    ldr r1, =#1542      
    mov r0, r6 ; User
    bl 0x234B498
    mov r0, r6
    mov r1, r6
    ldr r2, =#339
    mov r3, #0
    bl 0x2326188 ; DoMoveRefresh
    mov r0, r6
    mov r1, r6
    mov r2, #117
    mov r3, #0
    bl 0x2328030 ; DoMoveRecover
    b CheckStatus

; Regidrago + Regieleki aura boost
SplitDecision:
    ldr r1, =#320
    str r1, [r7, #+0x34]
    str r1, [r7, #+0x38]
    mov r3, #255
    b CheckStatus

; Regigigas' field boost
Regigigas:
    b Omniboost

; Dialga + Palkia effect
fieldDP:
    mov r1, #1
    strb r1, [r7, #+0xEC]
    mov r1, #2
    strb r1, [r7, #+0xD5]
    strb r1, [r7, #+0xD6]
    strb r1, [r7, #+0xDB]
    strb r1, [r7, #+0xED]
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r3, #255
    b CheckStatus

; Illusory Cresselia
Illusion:
    mov r1, #16
    strb r1, [r7, #+0x5e]
    strb r1, [r7, #+0x5f]
    ldr r1, =#340
    str r1, [r7, #+0x34]
    str r1, [r7, #+0x38]
    str r1, [r7, #+0x3C]
    str r1, [r7, #+0x40]
    mov r1, 0x3
    strb r1, [r7, #+0x110]
    strb r1, [r7, #+0x114]
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r1, #2
    strb r1, [r7, #+0xDB]
    b CheckStatus

; Memory Battle Boost
MemoryBoost:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x12 ; Darkrai banished
    bl 0x204B678
    cmp r0, 1h
    bne CheckStatus
    ldr r1, =#340
    str r1, [r7, #+0x34]
    str r1, [r7, #+0x38]
    str r1, [r7, #+0x3C]
    str r1, [r7, #+0x40]
    b CheckStatus

; Kyogre's aura boost
Kyogre:
    bl 0x22F92D8 ; Try Activate Artificial Weather Abilities
    mov r1, #3
    strb r1, [r7, #+0x12b]
    strb r1, [r7, #+0x133]
    strb r1, [r7, #+0x13b]
    strb r1, [r7, #+0x143]
    b CheckStatus

; Groudon's aura boost
Groudon:
    bl 0x22F92D8 ; Try Activate Artificial Weather Abilities
    mov r1, #3
    strb r1, [r7, #+0x12b]
    strb r1, [r7, #+0x133]
    strb r1, [r7, #+0x13b]
    strb r1, [r7, #+0x143]
    b CheckStatus

; Zapdos' aura boost
Zapdos:
    mov r1, #11
    strb r1, [r7, #+0xD2]
    strb r1, [r7, #+0xD3]
    mov r3, #255
    b CheckStatus

; Rayquaza's aura boost
Rayquaza:
    mov r1, #3
    strb r1, [r7, #+0x12b]
    strb r1, [r7, #+0x133]
    strb r1, [r7, #+0x13b]
    strb r1, [r7, #+0x143]
    mov r3, #255
    b CheckStatus

; Arceus' buff
Arceus:
    ldr r1, =#408
    str r1, [r7, #+0x34]
    str r1, [r7, #+0x38]
    str r1, [r7, #+0x3C]
    str r1, [r7, #+0x40]
    mov r1, #2
    strb r1, [r7, #+0xD5]
    strb r1, [r7, #+0xD6]
    strb r1, [r7, #+0xD7]
    mov r1, #3
    strb r1, [r7, #+0x110]
    strb r1, [r7, #+0x114]
    mov r1, 0x0
    strb r1, [r7, #+0x119]
    strb r1, [r7, #+0x5e]
    strb r1, [r7, #+0x5f]
    mov r1, #6
    strb r1, [r7, #+0xD8]
    mov r1, #2
    strb r1, [r7, #+0xDB]
    mov r3, #255
    b CheckStatus

; Cases for Deoxys formes
Deoxys:
    mov r3, #255
    b CheckStatus

; Gives an Omniboost to the boss
Omniboost:
    ldr r1, =#308
    str r1, [r7, #+0x34]
    str r1, [r7, #+0x38]
    str r1, [r7, #+0x3c]
    str r1, [r7, #+0x40]
    mov r3, #255
    b CheckStatus

; Gives a Speed Boost to the boss
SpeedBoost:
    mov r1, 0x2
    str r1, [r7, #+0x110]
    str r1, [r7, #+0x114]
    mov r3, #255
    b CheckStatus

; Gives a Speed Boost to the boss
PorygonZ:
    mov r1, #107
    strb r1, [r7, #+0x61]
    mov r3, #255
    b MemoryBoost

; Heals the boss from 80 HP each turn
RainbowField:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne CheckStatus
    ldr r0, [r8] 
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    moveq r3, #255
    beq CheckStatus
    ldr r0, [r7, 10h] ; Target current HP
    cmp r0, #920
    movge r3, #255
    bge CheckStatus
    mov r0, r6
    mov r1, r6
    mov r2, #80
    bl 0x231526C
    ldr r1, =#1523 ; Ho-Oh string 
    mov r0, r6 ; User
    bl 0x234B498
    mov r0, 0DDh
    mov r1, r6
    bl 0x23AF080
    mov r3, #255
    b CheckStatus

; Gives Diancie ammo to play with
MineralCrust:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne CheckStatus
    ldr r0, [r8]
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0,[r0,084h]
    cmp r0, r1
    moveq r3, #255
    beq CheckStatus
    mov r1, #4
    strb r1, [r7, #+0xD5]
    mov r1, #2
    strb r1, [r7, #+0xD6]
    strb r1, [r7, #+0xD7]
    mov r0, #1
    strh r0, [r7, #+0x62]
    mov r0, #99
    strh r0, [r7, #+0x64]
    mov r0, #10
    strh r0, [r7, #+0x66]
    strh r0, [r7, #+0x68]
    b CheckStatus

; Prevents the boss from taking damage if a subordinate is alive. Gains SpAtk boosts every turn.
DarkestDay:
    ldr r0, [r8] 
    ldrb r0,[r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0,[r0,084h]
    cmp r0, r1
    moveq r3, #255
    beq CheckStatus
    ldrh r0, [r7, #+0x2]
    ldr r1, =#382
    cmp r0, r1
    bne getLivingAttendants
    ldr r1, =EntitiesAlive
    ldrb r0, [r1]
    cmp r0, #0
    moveq r1, #0
    streqb r1, [r7, #+0xD5]
    streqb r1, [r7, #+0xD6]
    ldreq r1, =#256
    streq r1, [r7, #+0x3C]
    streq r1, [r7, #+0x40]
    beq CheckStatus
    ldr r1, =TimerBoost
    ldrb r1, [r1]
    subs r0, r1, r0
    cmp r0, 0h
    bgt InvincibleBoss
    ldrh r0, [r7, #+0x26]
    cmp r0, #10
    movlt r0, #10
    add r0, r0, 1h
    strh r0, [r7, #+0x26]
    mov r0, #11
    ldr r1, =TimerBoost
    strb r0, [r1]
InvincibleBoss:
    ldrb r1, [r7, #+0xD5]
    cmp r1, #7
    movne r0, r6
    movne r1, r6
    ldrne r2, =#301
    movne r3, #0
    blne 0x232B7D0 ; DoMoveProtect
    moveq r1, #3
    streqb r1, [r7, #+0xD6]
    ldr r1, =#999
    strh r1, [r7, #+0x10]
    b CheckStatus

getLivingAttendants:
    ldr r1, =EntitiesAlive
    ldrb r0, [r1]
    add r0, r0, 1h
    strb r0, [r1]
    b CheckStatus

EntitiesAlive:
    dcb 0

TimerBoost:
    dcb 11

Padding:
    dcb 0
    dcb 0

; Increases the boss Atk. and Sp. Atk by 1 stage each turn
PeriodicOrbit:
    ldr r0, [r8]
    ldrb r0, [r0,780h]
    tst r0,3h
    bne CheckStatus
    ldr r0, [r8]
    ldrb r0, [r0,748h]
    bl 0x20512B0
    mov r1, r0
    ldr r0, [r8]
    add r0, r0, 700h
    ldrh r0, [r0,084h]
    cmp r0, r1
    moveq r3, #255
    beq CheckStatus
    ldrh r0, [r7, #+0x24]
    cmp r0, #10
    movlt r0, #10
    add r0, r0, 1h
    strh r0, [r7, #+0x24]
    ldrh r0, [r7, #+0x26]
    cmp r0, #10
    movlt r0, #10
    add r0, r0, 1h
    strh r0, [r7, #+0x26]
    mov r0, r6 ; User
    ldr r1, =#1489
    bl 0x234B498
    ldr r0, =0x1da
    mov r1, r6
    bl 0x23AF080
    mov r3, #255
    b SpeedBoost

return:
    pop r0-r8,pc 
    .pool   
    .align
.endarea

AddDungeonCheck:
    ldr r1, =23B3140h
    mov r0, #0
    str r0, [r1]
    ldr r0, =2353538h
    ldr r0, [r0]
    ldrb r0, [r0,748h]
    bl IsMysteriosityLockedDungeon
    cmp r0, #1
    beq 0x23dbc68
    bl 0x204c938
    b AfterDungeonCheck

.pool
    
IsMysteriosityLockedDungeon:
    push r1
    mov r1, r0
    mov r0, #0
    cmp r1, #27
    moveq r0, #1
    cmp r1, #28
    moveq r0, #1
    cmp r1, #29
    moveq r0, #1
    cmp r1, #30
    moveq r0, #1
    cmp r1, #31
    moveq r0, #1
    cmp r1, #32
    moveq r0, #1
    cmp r1, #33
    moveq r0, #1
    cmp r1, #38
    moveq r0, #1
    cmp r1, #39
    moveq r0, #1
    cmp r1, #40
    moveq r0, #1
    cmp r1, #41
    moveq r0, #1
    cmp r1, #42
    moveq r0, #1
    cmp r1, #43
    moveq r0, #1
    cmp r1, #54
    moveq r0, #1
    cmp r1, #55
    moveq r0, #1
    cmp r1, #56
    moveq r0, #1
    cmp r1, #57
    moveq r0, #1
    cmp r1, #58
    moveq r0, #1
    cmp r1, #59
    moveq r0, #1
    cmp r1, #60
    moveq r0, #1
    cmp r1, #61
    moveq r0, #1
    cmp r1, #9
    moveq r0, #1
    cmp r1, #11
    moveq r0, #1
    cmp r1, #63
    moveq r0, #1
    cmp r1, #64
    moveq r0, #1
    cmp r1, #65
    moveq r0, #1
    cmp r1, #66
    moveq r0, #1
    cmp r1, #71
    moveq r0, #1
    cmp r1, #86
    moveq r0, #1
    cmp r1, #93
    moveq r0, #1
    cmp r1, #99
    moveq r0, #1
    cmp r1, #100
    moveq r0, #1
    cmp r1, #101
    moveq r0, #1
    cmp r1, #102
    moveq r0, #1
    cmp r1, #103
    moveq r0, #1
    cmp r1, #104
    moveq r0, #1
    cmp r1, #105
    moveq r0, #1
    cmp r1, #159
    moveq r0, #1
    cmp r1, #160
    moveq r0, #1
    cmp r1, #161
    moveq r0, #1
    cmp r1, #162
    moveq r0, #1
    cmp r1, #163
    moveq r0, #1
    cmp r1, #164
    moveq r0, #1
    cmp r1, #165
    moveq r0, #1
    cmp r1, #166
    moveq r0, #1
    cmp r1, #167
    moveq r0, #1
    cmp r1, #175
    moveq r0, #1
    cmp r1, #177
    moveq r0, #1
    cmp r1, #180
    moveq r0, #1
    cmp r1, #181
    moveq r0, #1
    cmp r1, #182
    moveq r0, #1
    cmp r1, #183
    moveq r0, #1
    cmp r1, #184
    moveq r0, #1
    cmp r1, #185
    moveq r0, #1
    cmp r1, #186
    moveq r0, #1
    cmp r1, #187
    moveq r0, #1
    cmp r1, #188
    moveq r0, #1
    cmp r1, #189
    moveq r0, #1
    cmp r1, #190
    moveq r0, #1
    cmp r1, #191
    moveq r0, #1
    pop r1
    bx lr

.org 0x23DBA94
.area 0x4
    b AddDungeonCheck
AfterDungeonCheck:
.endarea

.orga 0xEF00
.area 0xF000 - 0xEF00

BossRecovery:
    push r0-r3
    ldr r0, =2353538h
    ldr r0, [r0]
    add r0,r0,4000h
    ldrb r0,[r0,0DAh]
    cmp r0, #6 ; Grovyle room
    lsreq r4, r4, 2h
    popeq r0-r3
    beq 0x2311120
    bl 0x22E0864 ; IsBossFight
    cmp r0, #0
    popeq r0-r3
    beq 0x2311120
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla
    bl 0x204B678
    cmp r0, 1h
    popeq r0-r3
    beq 0x2311120
    mov r1, 0x4E
    mov r2, 0x39 ; Difficult
    bl 0x204B678
    cmp r0, 1h
    popeq r0-r3
    mov r1, 0x4E
    mov r2, 0x3B ; Hardcore
    bl 0x204B678
    cmp r0, 1h
    lsreq r4, r4, 1h
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x0F ; Future clear
    bl 0x204B678
    cmp r0, 1h
    lsreq r4, r4, 1h
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x13 ; Regigigas clear
    bl 0x204B678
    cmp r0, 1h
    lsreq r4, r4, 1h
    pop r0-r3
    b 0x2311120

.pool
.endarea
.close