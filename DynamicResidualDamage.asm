; 0x23101e0: Weather damage: 1/16
; 0x231027c: Weather damage: 1/16
; 0x23102e8: Solar Power: 1/16
; 0x2310348: Dry Skin: 1/16

; 0x231055c: Burn/Frostbite damage: 1/16
; 0x2310c70: Leech Seed drain: 1/16

.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x23101e0
	.area 0x4
		bl RatioedDamage16 ; r5: entity taking damage from weather
	.endarea

	.org 0x23101e8
	.area 0x4
		mov r1, r0
	.endarea

	.org 0x231027c
	.area 0x4
		bl RatioedDamage16 ; r5: entity taking damage from weather
	.endarea

	.org 0x2310284
	.area 0x4
		mov r1, r0
	.endarea

	.org 0x23102e8
	.area 0x4
		bl RatioedDamage16 ; r5: entity affected by Solar Power
	.endarea

	.org 0x23102f0
	.area 0x4
		mov r1, r0
	.endarea

	.org 0x2310348
	.area 0x4
		bl RatioedDamage16 ; r5: entity affected by Dry Skin
	.endarea

	.org 0x2310350
	.area 0x4
		mov r1, r0
	.endarea

	.org 0x231055c
	.area 0x4
		bl RatioedDamage16Alt ; r4: entity affected by Burn and Frostbite
	.endarea

	.org 0x2310564
	.area 0x4
		mov r1, r0
	.endarea

	.org 0x2310c70
	.area 0x4
		bl RatioedDamage16Alt ; r4: entity affected by leech seed
	.endarea

	.org 0x2310c78
	.area 0x4
		mov r6, r0
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2FF00
.area 0x30000 - 0x2FF00

; 0x23D6F80
RatioedDamage164:
	push r1-r4, lr
	ldr r4, [r4, #+0xb4]
	ldrsh r1, [r4, 012h]
	ldrsh r2, [r4, 016h]
	add r1, r1, r2
	mov r0, r1, lsr 4h
	ldrb r2, [r4, #0x100]
	cmp r2, #1
	lsreq r0, r0, 2h
	add r0, r0, 1h
	pop r1-r4, pc

; 0x23D6FAC
RatioedDamage16:
	push r1-r5, lr
	ldr r4, [r5, #+0xb4]
	ldrsh r1, [r4, 012h]
	ldrsh r2, [r4, 016h]
	add r1, r1, r2
	mov r0, r1, lsr 4h
	ldrb r2, [r4, #0x100]
	cmp r2, #1
	lsreq r0, r0, 2h
	add r0, r0, 1h
	pop r1-r5, pc

; 0x23d6fd8
RatioedDamage16Alt:
	push r1-r4, lr
	ldrsh r1, [r4, 012h]
	ldrsh r2, [r4, 016h]
	add r1, r1, r2
	mov r0, r1, lsr 4h
	ldrb r2, [r4, #0x100]
	cmp r2, #1
	lsreq r0, r0, 2h
	add r0, r0, 1h
	pop r1-r4, pc
.fill 0x023D6F80+0x100-., 0xCC
.endarea
.close