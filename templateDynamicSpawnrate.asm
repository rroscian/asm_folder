
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x230e6f8
	.area 0x4
		bl DynamicSpawnRate
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x8000 ; Define your starting point here
.area 0xA000 - 0x8000 ; Define your own area here

DynamicSpawnRate:
	push r0, lr
	ldr r0, =2353538h
    ldr r0, [r0]
    ldrb r0,[r0,748h] ; Get dungeon ID in r0
    mov r1, #36 ; Default Spawn Rate
    cmp r0, #1 ; Beach Cave
    moveq r1, #24
    cmp r0, #3 ; Drenched Bluff
    moveq r1, #48
    ; Those are mere examples, just check which dungeon you want your different spawn rate in and which spawn rate you want for this dungeon
    ; The way it's built, if no check passes the spawnrate is at its default, which is 36
	pop r0, pc
.pool
.endarea
.close