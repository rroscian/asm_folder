.nds
.open "overlay_0029.bin", 0x22DC240
    
    .org 0x22E7138
    .area 0x4
        b FloorManagement
    .endarea

.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34980
.area 0x34F70 - 0x34980

FloorManagement:
	; sub r3, r3, 0x20 ; Copied data struct in [r3, r3+20h]
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x2F ; Floor Randomizer
    bl 0x204B678
    cmp r0, 0x1
    popne r0-r3
    bne addMysteriositySettings
    ; bne return

    pop r0-r3
	push r0-r8
	ldr r8, =286B2h
	ldr r7, =2353538h
	ldr r7, [r7]
	add r7, r7, r8
	mov r8, #255
    ldr r5, =TableRandomLimits
	mov r6, 0x0 ; Loop Counter
LoopFloorManagement:
	ldrb r0, [r5, r6]
	cmp r0, 0x0
	beq nextIterFloorManagement
    bl 0x22EAA98
    cmp r0, 0x2
    bne continueRandoFloor
    cmp r6, 0xC
    moveq r0, 0x10
    cmp r6, 0x1A
    moveq r0, 0xFF
continueRandoFloor:
	cmp r0, 0x100
	strgeh r0, [r7, r6]
	strltb r0, [r7, r6]
	
nextIterFloorManagement:
	cmp r6, 0x1C
	addge r6, r6, 0x2
	addlt r6, r6, 0x1
	cmp r6, 0x20
	bge addMysteriositySettings
	b LoopFloorManagement

; 1: Higher enemy density, higher item density, higher trap density, 1-pokemon floors
; 2: Random effect between: Embargo, Seal 1st move slot, Heal Block, Gastro Acid. Can force a MH
; 3: Locked rooms can appear and contain great items if you open them with a key, you can also get Golden Rooms
; 4: Glided Halls can appear, transforming the floor into Golden Rooms from time to time
; 5: Enemies have x1.5 in Atk, Def, SpA, SpD. You can warp to a Terra Incognita from here (maybe)

addMysteriositySettings:
	push r0-r3
	ldr r1, =22AB0D5h ; Mysteriosity degree
	ldrb r1, [r1]
	cmp r1, 0h
	beq popEverything
    cmp r1, #255
    beq popEverything 
    push r4-r5, r7-r8
	ldr r8, =286B2h
	ldr r7, =2353538h
	ldr r7, [r7]
	add r7, r7, r8
   	ldrb r5, [r7, 12h]
   	cmp r5, 0h
   	bne popTemp
    mov r5, r1 
	cmp r5, 4h
	bge Mysteriosity4Plus
	cmp r5, 3h
	bge Mysteriosity3Plus
	cmp r5, 2h
	bge Mysteriosity2Plus
	cmp r5, 1h
	bge Mysteriosity1Plus

Mysteriosity4Plus:
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    cmp r0, #5
    bge Mysteriosity3Plus
    ; Golden Hall: Ground Items are Sitrus Berries, Golden Apples, Gold Thorns, Joy Seeds, Lost Loots, Secret Slabs and Money
    cmp r0, #1
    bge CursedHall
    blt GoldenHall
	b Mysteriosity3Plus

GoldenHall:
	mov r0, #7 
	strb r0, [r7] ; Floor Structure
    mov r0, #60
	strb r0, [r7, 2h] ; Tileset ID
	mov r0, #121
	strb r0, [r7, 3h] ; Music ID
	mov r0, #0
	strb r0, [r7, 6h] ; Enemy Density
	mov r0, #24
	strb r0, [r7, 0Fh] ; Max Item amount
	mov r0, #0
	strb r0, [r7, 10h] ; Trap Density
	mov r0, #255
	strb r0, [r7, 17h] ; Max Money amount
	b Mysteriosity3Plus

CursedHall:
	mov r0, #16
	strb r0, [r7, 1h]
	mov r0, #167
	strb r0, [r7, 2h]
	mov r0, #110
	strb r0, [r7, 3h]
	mov r0, #3
	strb r0, [r7, 4h]
	mov r0, #20
	strb r0, [r7, 5h]
	mov r0, #15
	strb r0, [r7, 13h]
	mov r0, #16
	strb r0, [r7, 6h]
	mov r0, #100
	strb r0, [r7, 8h]
	strb r0, [r7, 19h]
	mov r0, #0
	strb r0, [r7]
	strb r0, [r7, 7h]
	strb r0, [r7, 0Dh]
	strb r0, [r7, 0Fh]
	strb r0, [r7, 1Bh]
	mov r0, #2
	strb r0, [r7, 16h]
	b Mysteriosity3Plus

Mysteriosity3Plus:
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    cmp r0, #10
    bge Mysteriosity2Plus
    ; Random Sealed Room (IDs 170-180) or Golden Room (ID 111)
    mov r0, #12 ; argument #0 Higher bound
    bl 0x22EAA98
    cmp r0, #11
    movne r1, #170
    addne r1, r1, r0
    moveq r1, #111
    moveq r0, #60
	streqb r0, [r7, 2h] ; Tileset ID
   	strb r1, [r7, 12h]

Mysteriosity2Plus:
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    cmp r0, #10
	bge Mysteriosity1Plus
	; Force a Monster House
	mov r0, #100
	strb r0, [r7, 8h]

Mysteriosity1Plus:
    mov r0, #100 ; argument #0 Higher bound
    bl 0x22EAA98
    mov r4, r0
    cmp r4, #70
    bge popTemp
    ; Higher enemy density, higher item density, higher trap density, increased sticky chance, 1-pokemon floors
	; Item density x2
	ldrb r0, [r7, 0Fh]
	mov r0, r0, lsl 1h
	strb r0, [r7, 0Fh]
	; Enemy density x2
	cmp r4, #50
	ldrltb r0, [r7, 6h]
	movlt r0, r0, lsl 1h
	strltb r0, [r7, 6h]
	; Trap density x3/2
	cmp r4, #20
	ldrltb r0, [r7, 10h]
	addlt r0, r0, r0, lsl 1h
	lsrlt r0, 1h
	strgtb r0, [r7, 10h]
	; Sticky Item Chance +5
	cmp r4, #5
	ldrb r0, [r7, 0Ah]
	add r0, r0, 5h
	strb r0, [r7, 0Ah]
	; Pop the temporary registers
popTemp:
	pop r4-r5, r7-r8

popEverything:
	pop r0-r3

difficultySettings:
	ldr r7, =21EE486h
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla Difficulty
    bl 0x204B678
    cmp r0, 1h
    popeq r0-r3
    beq VanillaSettings
    mov r1, 0x4E
    mov r2, 0x3B ; Hardcore Difficulty
    bl 0x204B678
    cmp r0, 1h
    popeq r0-r3
    beq HardcoreSettings
    pop r0-r3
    b CheckRightReturn

; enemy density + trap density x1/2, MH chance x1/4, remove sticky item chance, halve IQ
VanillaSettings:
	; Enemy density
	ldrb r0, [r7, 6h]
	cmp r0, 1h
	movgt r0, r0, lsr 1h
	strgtb r0, [r7, 6h]
	; Trap density
	ldrb r0, [r7, 10h]
	cmp r0, 1h
	movgt r0, r0, lsr 1h
	strgtb r0, [r7, 10h]
	; MH chance
	ldrb r0, [r7, 8h]
	cmp r0, 4h
	movge r0, r0, lsr 2h
	strgeb r0, [r7, 8h]
	; Sticky chance
	ldrb r0, [r7, 0Ah]
	mov r0, 0h
	strb r0, [r7, 0Ah]
	; IQ value
	ldrh r0, [r7, 1Ch]
	cmp r0, 1h
	movgt r0, r0, lsr 1h
	strgth r0, [r7, 1Ch]
	b CheckRightReturn

; Trap density x3/2, MH chance x3/2, increase IQ
HardcoreSettings:
	; Trap density
	ldrb r0, [r7, 10h]
	mov r1, 0x3
	mul r0, r0, r1
	mov r0, r0, lsr 1h
	strb r0, [r7, 10h]
	; MH chance
	ldrb r0, [r7, 8h]
	mul r0, r0, r1
	mov r0, r0, lsr 1h
	strb r0, [r7, 8h]
	; IQ value
	ldr r2, =IQList
	mov r3, 0h
	ldrh r0, [r7, 1Ch]
LoopCheckIQ:
	ldrh r1, [r2, r3] ; Load IQ Table
	cmp r0, r1
	addle r3, r3, 2h
	ldrleh r0, [r2, r3]
	strleh r0, [r7, 1Ch]
	ble CheckRightReturn
	cmp r3, 3h
	addlt r3, r3, 2h
	blt LoopCheckIQ

CheckRightReturn:
	cmp r8, #255
	bne return
endFloorManagement:
	pop r0-r8
return:
	ldr r2,=286CEh
	b 0x22E713C
	.pool

TableRandomLimits:
	.dcb 0x10 ; floor structure
	.dcb 0x41 ; room density
	.dcb 0xAA ; tileset
	.dcb 0xA9 ; music
	.dcb 0x9 ; weather
	.dcb 0x97 ; floor connectivity
	.dcb 0x11 ; initial enemy density
	.dcb 0x65 ; kecleon shop chance
	.dcb 0x65 ; monster house chance
	.dcb 0x65 ; maze room chance
	.dcb 0x33 ; Sticky Item chance
	.dcb 0x2 ; dead end flags
	.dcb 0x3 ; secondary terrains (if 2, change to 10)
	.dcb 0x3 ; terrain bitflag
	.dcb 0x3 ; unknown
	.dcb 0x20 ; Item Density
	.dcb 0x20 ; Trap Density
	.dcb 0x0 ; Floor Number (NSTC)
	.dcb 0x0 ; Fixed Floor (NSTC)
	.dcb 0x41 ; Extra Hallway Density
	.dcb 0x41 ; Buried Item Density
	.dcb 0x81 ; Secondary Terrain Density
	.dcb 0x3 ; Darkness Level
	.dcb 0xFF ; Max Coin amount
	.dcb 0x10 ; Shop Item Position
	.dcb 0x0 ; Empty Monster House Chance
	.dcb 0x3 ; Hidden stairs content (if 2, change to 255)
	.dcb 0x65 ; Hidden Stairs Spawn Chance
	.dcb 0x0 ; Enemy IQ (read halfword)
	.dcw 0x32 ; IQ Booster increase (read halfword)
	.dcb 0x0

IQList:
	.dcw 0x1
	.dcw 0x96
	.dcw 0x014A
	.dcw 0x0258
	.dcw 0x03B6

.endarea
.close