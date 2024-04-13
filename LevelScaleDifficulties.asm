.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x22E7700
    .area 0x4
        bl BranchLevel
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x32000
.area 0x32400 - 0x32000

; Implements an enemy level scale depending on your party max level
BranchLevel:
    push {r0-r8, lr} 
    ; Check the special episode value      
    ; bl 0x0204C938
	; mvn r1, #0
	; cmp r0, r1
	; bne return

	ldr r4,=0x2353538
    ldr r2,[r4,#+0x0]
	ldrb r2,[r2, #+0x748]
    cmp r2, #101 ; Zero Isle West
    beq return
    cmp r2, #102 ; Zero Isle South
    beq return
    cmp r2, #133 ; Barren Valley
    beq return
    cmp r2, #162 ; Glass Cannon Trial
    beq return
    cmp r2, #163 ; Pacifist Trial
    beq return
    cmp r2, #164 ; Time Attack Trial
    beq return
    cmp r2, #167 ; Sandbox Trial
    beq return
    cmp r2, #177 ; Realm of Ascension
    beq return
	cmp r0, #0
	beq return
    bl StartScale
    b ContinueScale

StartScale:
    push lr
    mov r1,0h ; r1: Loop counter
loopLevelScale:
	mov r0, r1
	push {r1-r4}
    bl 0x205638c ; Checks the entity
	pop {r1-r4}
    cmp r0,0h
    beq nextIterScaling
    ldrb r4, [r0]
    tst r4,1h
    beq nextIterScaling
    ldrb r2, [r0, 2h]
    cmp r1, #0
    moveq r3, #0
    cmp r2, r3
    movgt r3, r2
nextIterScaling:
    add r1,r1,1h
    cmp r1,0x3
    blt loopLevelScale
    pop pc

; Checks if the level has to scale
ContinueScale:
	mov r6, #0
	add r3, r3, r3
    mov r7, r3
	ldr r4,=2353538h
	ldr r5, [r4]
	add r5, r5, #0x1
	add r5, r5, #0x164
	add r5, r5, #0x2c800

LoopScale:
	ldrb r4, [r5]
	cmp r4, #0
	beq CountScale 

CheckDifficulties:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38
    bl 0x204B678
    cmp r0, 1h
    beq Vanilla  
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x39
    bl 0x204B678
    cmp r0, 1h
    beq Difficult
    b Expert

; Vanilla Scaling: if eLevel > aLevel, eLevel = aLevel
Vanilla:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x37
    bl 0x204B678
    cmp r0, 1h
    bne VanillaScale
    mov r3, r7
    cmp r4, r3
    movgt r4, r3
; Vanilla Nerf: eLevel = 0.8 eLevel
VanillaScale:
    mov r0, #4
    mul r0, r4, r0
    mov r1, #10
    bl 0x0208FEA4
    ; mov r3, r4
    add r4, r0, r0
    cmp r4, #1
    movle r4, #2
    strb r4, [r5]
    b CountScale

Difficult:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x37
    bl 0x204B678
    cmp r0, 1h
    bne CountScale
    mov r3, r7
    mov r4, r3
    strb r4, [r5]
    b CountScale

Expert:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x37
    bl 0x204B678
    cmp r0, 1h
    bne CountScale
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x11 ; Temporal Tower saved
    bl 0x204B678
    cmp r0, 1h
    bne ExpertScale
    ; Hidden Land code kek
    ldr r2,=0x2353538
    ldr r0,[r2,#+0x0]
    ldrb r0,[r0, #+0x748]
    cmp r0, #43
    bgt ExpertScale
    cmp r0, #38
    blt ExpertScale
    mov r2, #200
    strb r2, [r5]
    b CountScale
ExpertScale:
    cmp r4, r7
    strltb r7, [r5]

CountScale:
    add r5, r5, 8h
    add r6, r6, 1h
	cmp r6, #16
	blt LoopScale

SpeciesRandomizer:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x31
    bl 0x204B678
    cmp r0, 1h
    bne MysteriosityRoom

; Initialize Randomizer loop
    mov r6, #0
    ldr r4,=2353538h
    ldr r5, [r4]
    add r5, r5, #0x6
    add r5, r5, #0x164
    add r5, r5, #0x2c800

LoopRando:
    ldrh r1, [r5]
    cmp r1, #132 ; 1st Ditto
    cmpne r1, #732 ; 2nd Ditto
    ldreq r4, =22AB486h ; 1 if escape failed
    ldreqb r4, [r4]
    cmpeq r4, 1h
    ldreq r1, =#330 ; Sableye
    streqh r1, [r5]
CheckRando:
    ldr r2, =#383
    cmp r1, r2
    beq CountRando
    ldr r0, =#1151 ; argument #0 Higher bound
    bl 0x22EAA98
    add r0, r0, #1
    ldr r1, =#552
    cmp r0, r1
    strleh r0, [r5]
    ble CountRando
    ldr r1, =#601
    cmp r0, r1
    strgeh r0, [r5]
    bge CountRando
    b LoopRando
CountRando:
    add r5, r5, 8h
    add r6, r6, 1h
    cmp r6, #16
    blt LoopRando

; 1-species floors
MysteriosityRoom:
    ldr r1, =22AB495h ; Mysteriosity degree
    ldrb r1, [r1]
    cmp r1, 0h
    beq return
    cmp r1, 5h
    beq return
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    cmp r0, #15
    bge return

; Get the number of species able to spawn in the room
    ldr r4,=2353538h
    ldr r5, [r4]
    add r5, r5, #0x2
    add r5, r5, #0x164
    add r5, r5, #0x2c800 ; Spawn Weights in r5
    mov r7, r5 ; Backup of Spawn Weights in r7
    mov r6, #0 ; Number of species
LoopGetNbSpecies:
    ldrh r0, [r7, 4h]
    ldr r1, =17Fh ; Kecleon
    cmp r0, r1
    addeq r7, r7, 8h
    beq LoopGetNbSpecies
    ldr r1, =229h ; 553
    cmp r0, r1
    beq endLoopNbSpecies
    ldrh r0, [r7]
    cmp r0, 0h
    addne r6, r6, 1h
    add r7, r7, 8h
    b LoopGetNbSpecies 

endLoopNbSpecies:
    mov r0, r6 ; Nb of species in the table in r0
    bl 0x22EAA98
    mov r4, r0 ; r4: species index that will be the unique spawn
    mov r7, #0
LoopSearchFixedSpecies:
    ldrh r0, [r5]
    cmp r0, #0
    addeq r5, r5, 8h
    beq LoopSearchFixedSpecies
    cmp r4, r7
    mov r0, #0
    strneh r0, [r5]
    strneh r0, [r5, 2h]
    addne r5, r5, 8h
    addne r7, r7, 1h
    bne CheckExitLoop
    ldr r0, =#10000
    strh r0, [r5]
    strh r0, [r5, 2h]
    add r7, r7, 1h
CheckExitLoop:
    cmp r6, r7
    bne LoopSearchFixedSpecies
return:
    pop {r0-r8, lr}
    b 0x23361D4

.pool
.endarea
.close