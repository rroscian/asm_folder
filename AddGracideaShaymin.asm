
.nds
.open "arm9.bin", 0x2000000

	.org 0x205407c
	.area 0x20
		ldr r2, [0x205424c] ; 0x3d6
		cmp r0, 0x470
		addeq r0, r2, 8Bh
		bxeq lr
		sub r1, r2, 3h ; Invalid Castform
		cmp r0, r1
		subeq r0, r0, 258h
		bxeq lr
	.endarea

	.org 0x205424c
	.area 0x4
		.word 0x3d6
	.endarea

	.org 0x20541c0
	.area 0x4
		sub r1, r3, 92h
	.endarea

	.org 0x20541dc
	.area 0x4
		sub r1, r3, 90h
	.endarea

	.org 0x20541f8
	.area 0x4
		sub r1, r3, 68h
	.endarea

	.org 0x2054228
	.area 0x4
		sub r1, r3, 1Eh
	.endarea

	.org 0x205423c
	.area 0x4
		sub r1, r3, 24h
	.endarea

	.org 0x2054398
	.area 0xC0 ; 55 instructions
		push r4
		mov r4, r0
		ldr r2, [0x2054460] ; r2: 3D6
		ldr r3, [0x205445c] ; r3: 235
		sub r1, r2, 3h ; Invalid Castform
		cmp r0, r1
		ldreq r4, [0x2054458]
		cmp r0, 234h ; Castform
		ldreq r4, [0x2054458]
		cmp r0, r3 ; Castform
		ldreq r4, [0x2054458]
		add r1, r3, 1h
		cmp r0, r1 ; Castform
		ldreq r4, [0x2054458]
		add r1, r2, 99h ; Shaymin-Sky Shiny
		cmp r0, r1
		subeq r4, r1, 1h
		sub r1, r1, 258h ; Shaymin-Sky Normal
		cmp r0, r1
		subeq r4, r1, 1h
		cmp r0, 218h ; Giratina-O Normal
		subeq r4, r3, 24h
		cmp r0, 470h ; Giratina-O Shiny
		addeq r4, r2, 93h
		sub r1, r3, 68h ; Cherrim Female
		cmp r0, r1
		moveq r4, 1CCh
		add r1, r2, 4Fh ; Cherrim Sunshine Female
		cmp r0, r1
		addeq r4, r2, 4Eh
		sub r1, r3, 92h ; Deoxys Attack
		cmp r0, r1
		subeq r4, r2, 234h
		cmp r0, 1A4h ; Deoxys Defense
		sub r1, r3, 90h
		cmp r0, r1 ; Deoxys Speed
		subeq r4, r2, 234h
		mov r0, r4
		pop r4
		bx lr
	.endarea

	.org 0x2054AA4
	.area 0x30
		ldr r2,=-534
		add r1,r0,r2
		cmp r1,1h
		movls r0,1
		bxls lr
		subhi r2,r2,258h
		addhi r0,r0,r2
		cmphi r0,1h
		movls r0,1
		movhi r0,0
		bx lr
		.pool ; 2 literals
	.endarea

	.org 0x2054ad4
	.area 0x40
		ldr r2, [0x2054b24] ; 0x17B
		cmp r0, r2
		movne r1, 0x234
		cmpne r0, r1
		addne r1, r1, #0x1
		cmpne r0, r1
		addne r1, r1, #0x1
		cmpne r0, r1
		addne r2, r2, 258h
		cmpne r0, r2
		moveq r0, #1
		movne r0, #0
		bx lr
	.endarea

	.org 0x20585d8
	.area 0x4
		push r4-r9, lr
	.endarea

	.org 0x20585dc
	.area 0xC
		nop
		nop
		nop
	.endarea

	.org 0x2058620
	.area 0x4
		b AddGiratina
	.endarea

	.org 0x205863c
	.area 0x4
		pop r4-r9, pc
	.endarea

	.org 0x20586b4
	.area 0x8
		b CheckGiratina
		cmp r1, 218h
	.endarea
.close

.open "overlay_0029.bin", 0x22DC240

; 22F7254: read value
.org 0x22f7248
	.area 0x4
		b CheckShinymin
	.endarea

.org 0x22fe0d8
	.area 0x4
		ldrls r0, [0x22fe188]
	.endarea

.org 0x231b520
	.area 0x4
		bl CheckShaymin
	.endarea

.org 0x231b560
	.area 0x4
		bl CheckShaymin
	.endarea

.org 0x231b624
	.area 0x4
		b AddSkyminCheck
	.endarea

.org 0x23352a4
	.area 0x4
		blt 0x23352b8
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2E6C0
	.area 0xA0
	AddGiratina:
		cmp r1, r4
		beq 0x2058624
		addne r9, r4, 258h
		cmpne r1, r9
		addeq r9, r5, 258h
		streqh r9, [r0, 0xc]
		b 0x2058628

	CheckGiratina:
		ldrsh r1, [r0, 0xc]
		cmp r1, 0x470
		ldreq r1, =469h
		streqh r1, [r0, #0xc]
		popeq r3-r5, pc
		b 0x20586b8
	.pool

	CheckShinymin:
		beq 0x22f726c
		cmp r0, 2h
		addeq r11, r11, 258h
		b 0x22f724C

	CheckShaymin:
		push lr
		cmp r4, 0x258
		addgt r0, r0, 0x258
		cmp r4, r0
		pop pc

	AddSkyminCheck:
		cmp r5, 0x258
		addgt r0, r0, 0x258
		cmp r5, r0
		b 0x231b628
	.endarea
.close