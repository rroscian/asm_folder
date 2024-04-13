; Implement dynamic entries in Fixed Rooms
.nds
.open "overlay_0029.bin", 0x22DC240

    .org 0x2343898
    .area 0xC
		add r0, sp, #0x24
		bl FixedRoomTweak
		bl 0x22FD084
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33300
.area 0x33580 - 0x33300 ; ?

FixedRoomTweak:
	mov r1, 1h
	push {r0-r7, lr}
	mov r6, r0
	mov r7, r14
	ldrh r4, [r6, 0h] ; Load Pokemon ID
	cmp r4, 1h
	beq LegendaryBoss
	/*ldr r1, =#1153
	cmp r4, r1
	beq MemoryBoss*/
	//b Difficulties

LegendaryBoss:
	ldr r5, =2353538h
	ldr r5, [r5,#+0x0]
	ldrb r1, [r5, 748h]
	cmp r1, #1 ; Beach Cave
	ldreq r2, =#477
	streqh r2, [r6, 0h]
	cmp r1, #16 ; Steam Cave Peak
	ldreq r2, =#522
	streqh r2, [r6, 0h]
	cmp r1, #23 ; Underground Lake
	ldreq r2, =#523
	streqh r2, [r6, 0h]
	cmp r1, #26 ; Crystal Lake
	ldreq r2, =#524
	streqh r2, [r6, 0h]
	cmp r1, #43 ; Temporal Pinnacle
	ldreq r2, =#525
	streqh r2, [r6, 0h]
	cmp r1, #66 ; Spacial Rift -Bottom
	ldreq r2, =#526
	streqh r2, [r6, 0h]
	cmp r1, #73 ; Bottomless Sea
	ldreq r2, =#414
	streqh r2, [r6, 0h]
	cmp r1, #74 ; Flower Paradise
	ldreq r2, =#535
	streqh r2, [r6, 0h]
	cmp r1, #75 ; Shimmer Desert
	ldreq r2, =#415
	streqh r2, [r6, 0h]
	cmp r1, #76 ; Genesis Island
	moveq r1, #151
	streqh r2, [r6, 0h]
	cmp r1, #77 ; Mt. Avalanche
	moveq r2, #144
	streqh r2, [r6, 0h]
	cmp r1, #78 ; Thundercap Mt.
	moveq r2, #145
	streqh r2, [r6, 0h]
	cmp r1, #79 ; Giant Volcano
	moveq r2, #146
	streqh r2, [r6, 0h]
	cmp r1, #80 ; Fire Field
	ldreq r2, =#527
	streqh r2, [r6, 0h]
	cmp r1, #81 ; World Abyss
	ldreq r2, =#536
	streqh r2, [r6, 0h]
	cmp r1, #83 ; Sky Stairway
	ldreq r2, =#416
	streqh r2, [r6, 0h]
	cmp r1, #84 ; Altar of Dreams
	ldreq r2, =#530
	streqh r2, [r6, 0h]
	cmp r1, #85 ; Mystery Jungle
	ldreq r2, =#278
	streqh r2, [r6, 0h]
	cmp r1, #106 ; Tomb of Nightmares
	ldreq r2, =#533
	streqh r2, [r6, 0h]
	cmp r1, #170 ; Sea Shrine
	ldreq r2, =#276
	streqh r2, [r6, 0h]
	cmp r1, #171 ; Mineral Crust
	ldreq r2, =#380
	streqh r2, [r6, 0h]
	cmp r1, #172 ; Revival Mountain
	ldreq r2, =#277
	streqh r2, [r6, 0h]
	cmp r1, #173 ; Mount Tensei
	ldreq r2, =#381
	streqh r2, [r6, 0h]
	cmp r1, #175 ; Atomic Wastes
	ldreq r2, =#382
	streqh r2, [r6, 0h]
	cmp r1, #179 ; Starglow Cavern
	ldreq r2, =#1017
	streqh r2, [r6, 0h]
/*
Difficulties:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38
    bl 0x204B678
    cmp r0, 1h
    bne return
	ldrh r0, [r6, 8h]
	mov r1, 5h
    bl 0x208FEA4
    mov r1, 4h
    mul r0, r0, r1
    strh r0, [r6, 8h]*/

/*MemoryBoss:
	ldr r5, =2353538h
	ldr r3, [r5]
    add r3, r3, 4000h
    ldrb r3, [r3,0DAh]
	cmp r1, =#66 ; Mt. Bristle Peak*/

return:
	mov r14, r7
	pop {r0-r7, pc}

.pool
.endarea
.close