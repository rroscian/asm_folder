;0x23438a0: Call to 0x22fd084
;    r0: Pointer to a struct in the stack that contains some info about the fixed pokémon to spawn
;        0-1: Pokémon ID
;        4: (?) Moved to (pokémon struct)+120h when initializing it
;        8-9: Pokémon level
;    r1: (?) 1 in this particular call

; Implement dynamic entries in Fixed Rooms
.nds
.open "overlay_0029.bin", 0x22DC240

    .org 0x2343898
    .area 0xC
		add r0, sp, #0x24
		bl FixedRoomTweak1
		bl 0x22FD084
    .endarea

   	.org 0x2343eb8
   	.area 0x4
   		bl FixedRoomTweak2
   	.endarea

   	.org 0x2343fa0
   	.area 0xC
   		ldrb r3, [r6, 2h]
   		cmp r3, 0h
   		blne FixedRoomTweak3
   	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33000
.area 0x33580 - 0x33000

FixedRoomTweak1:
	mov r1, 1h
	push {r0-r7, lr}
	mov r6, r0
	b Check1
FixedRoomTweak2:
	ldrsh r0, [r6]
	push {r1-r7, lr}
	b Check2
FixedRoomTweak3:
	ldrsh r1, [r6]
	push {r0, r2-r7, lr}
	b Check3

Check1:
	ldrh r4, [r6, 0h] ; Load Pokemon ID
	ldr r2, =PokeID
	cmp r4, 7h
	strneh r4, [r2]
	bleq LegendaryBoss
	ldr r3, [r2]
	cmp r3, 4h
	bne Difficulties
	cmp r4, 4h
	strneh r4, [r2]
	bleq GridBoss ; Insérer Hook 2
	b Difficulties

Check2:
	ldr r2, =PokeID
	cmp r0, 7h
	strneh r0, [r2]
	bleq LegendaryBoss
	ldr r3, [r2]
	cmp r3, 4h
	bne return2
	cmp r0, 4h
	strneh r0, [r2]
	bleq GridBoss ; Insérer Hook 2
	b return2

Check3:
	ldr r2, =PokeID
	cmp r1, 7h
	strneh r1, [r2]
	bleq LegendaryBoss
	ldr r3, [r2]
	cmp r3, 4h
	bne return3
	cmp r1, 4h
	strneh r1, [r2]
	bleq GridBoss ; Insérer Hook 2
	b return3

LegendaryBoss:
	push lr
	ldr r5, =2353538h
	ldr r5, [r5,#+0x0]
	ldrb r1, [r5, 748h]
	cmp r1, #2 ; Beach Cave
	ldreq r2, =#477
	cmp r1, #16 ; Steam Cave Peak
	ldreq r2, =#522
	cmp r1, #23 ; Underground Lake
	ldreq r2, =#523
	cmp r1, #26 ; Crystal Lake
	ldreq r2, =#524
	cmp r1, #40 ; Old Ruins
	moveq r2, #228
	cmp r1, #43 ; Temporal Pinnacle
	ldreq r2, =#525
	cmp r1, #66 ; Spacial Rift -Bottom
	ldreq r2, =#526
	cmp r1, #73 ; Bottomless Sea
	ldreq r2, =#414
	cmp r1, #75 ; Shimmer Desert
	ldreq r2, =#415
	cmp r1, #76 ; Genesis Island
	moveq r1, #151
	cmp r1, #77 ; Mt. Avalanche
	moveq r2, #144
	cmp r1, #78 ; Thundercap Mt.
	moveq r2, #145
	cmp r1, #79 ; Giant Volcano
	moveq r2, #146
	cmp r1, #80 ; Fire Field
	ldreq r2, =#527
	cmp r1, #81 ; World Abyss
	ldreq r2, =#536
	cmp r1, #83 ; Sky Stairway
	ldreq r2, =#416
	cmp r1, #84 ; Altar of Dreams
	ldreq r2, =#530
	cmp r1, #85 ; Mystery Jungle
	ldreq r2, =#278
	cmp r1, #106 ; Tomb of Nightmares
	ldreq r2, =#533
	cmp r1, #170 ; Sea Shrine
	ldreq r2, =#276
	cmp r1, #171 ; Mineral Crust
	ldreq r2, =#380
	cmp r1, #172 ; Revival Mountain
	ldreq r2, =#277
	cmp r1, #173 ; Mount Tensei
	ldreq r2, =#381
	cmp r1, #179 ; Starglow Cavern
	ldreq r2, =#1017
	ldr r5, =PokeID
	strh r2, [r5]
	pop pc

GridBoss:
	push r8, lr
	ldr r5, =2353538h
	ldr r4, [r5]
	add r4, r4, 4000h
	ldrb r4, [r4, 0DAh]
	cmp r4, 0C8h
	moveq r2, 184h
	cmp r4, 0C9h
	ldreq r2, =1F2h
	cmp r4, 0CAh
	ldreq r2, =41Fh
	cmp r4, 0CBh
	ldreq r2, =1FDh
	cmp r4, 0CCh
	moveq r2, 87h
	cmp r4, 0CDh
	ldreq r2, =166h
	cmp r4, 0CEh
	ldreq r2, =113h
	cmp r4, 0CFh
	ldreq r2, =1EAh
	cmp r4, 0D0h
	ldreq r2, =208h
	cmp r4, 0D1h
	moveq r2, 5Eh
	cmp r4, 0D2h
	moveq r2, 0C4h
	cmp r4, 0D3h
	ldreq r2, =2EFh
	cmp r4, 0D4h
	ldreq r2, =3CCh
	cmp r4, 0D5h
	moveq r2, 0E1h
	cmp r4, 0D6h
	ldreq r2, =3FAh
	cmp r4, 0D7h
	ldreq r2, =36Eh
	cmp r4, 0D8h
	ldreq r2, =1D1h
	cmp r4, 0D9h
	ldreq r2, =47Ch
	cmp r4, 0DAh
	ldreq r2, =3F4h
	cmp r4, 0DBh
	ldreq r2, =3F5h
	cmp r4, 0DCh
	ldreq r2, =2EAh
	cmp r4, 0DDh
	ldreq r2, =367h
	cmp r4, 0DEh
	ldreq r2, =224h
	cmp r4, 0DFh
	ldreq r2, =1A2h
	cmp r4, 0E0h
	ldreq r2, =224h
	cmp r4, 0FAh
	ldreq r2, =224h
	cmp r4, 0FBh
	ldreq r2, =1A2h
	mov r8, r14
	cmp r4, 0F0h
	bleq TemporalGrid
	cmp r4, 0F1h
	bleq TemporalGrid
	cmp r4, 0F2h
	bleq HornGrid
	cmp r4, 0F3h
	bleq HornGrid
	cmp r4, 0F4h
	bleq DuskGrid
	cmp r4, 0F5h
	bleq DuskGrid
	cmp r4, 0F6h
	bleq DuskGrid
	cmp r4, 0F7h
	bleq TravailGrid
	cmp r4, 0F8h
	bleq TravailGrid
	ldr r4, =PokeID
	strh r2, [r4]
	mov r14, r8
	pop r8, pc

TemporalGrid:
	push r0, lr
	push r1-r3
	mov r0, #10
	bl 0x22EAA98
	pop r1-r3
	cmp r0, 5h
	ldrge r2, =16Eh
	ldrlt r2, =3C5h
	pop r0, pc

HornGrid:
	push r0, lr
	push r1-r3
	mov r0, #4
	bl 0x22EAA98
	pop r1-r3
	mov r2, 8Eh
	cmp r0, 0h
	moveq r2, 2Fh
	cmp r0, 1h
	moveq r2, 31h
	cmp r0, 2h
	moveq r2, 0A8h
	pop r0, pc

DuskGrid:
	push r0, lr
	push r1-r3
	mov r0, #3
	bl 0x22EAA98
	pop r1-r3
	mov r2, 200h
	cmp r0, 0h
	moveq r2, 0BDh
	cmp r0, 1h
	moveq r2, 1CCh
	pop r0, pc

TravailGrid:
	push r0, lr
	push r1-r3
	mov r0, #5
	bl 0x22EAA98
	pop r1-r3
	mov r2, 0EFh
	cmp r0, 0h
	moveq r2, #18
	cmp r0, 1h
	moveq r2, #68
	cmp r0, 2h
	moveq r2, 7Ah
	cmp r0, 3h
	moveq r2, #166
	pop r0, pc

Difficulties:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38
    bl 0x204B678
    cmp r0, 1h
	ldreqh r0, [r6, 8h]
	addeq r0, r0, r0, lsl 1h
    moveq r0, r0, lsr 2h
    streqh r0, [r6, 8h]

return1:
	ldr r3, =PokeID
	ldrh r3, [r3]
	strh r3, [r6, 0h]
	pop {r0-r7, pc}

return2:
	ldr r3, =PokeID
	ldrh r3, [r3]
	mov r0, r3
	pop {r1-r7, pc}

return3:
	ldr r3, =PokeID
	ldrh r3, [r3]
	mov r1, r3
	pop {r0, r2-r7, pc}

	.pool

PokeID:
	dcd 256

	.endarea
.close