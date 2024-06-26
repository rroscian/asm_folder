.nds
.open "arm9.bin", 0x02000000

; Revamps the starters list
; Base patch made by Irdkwia, modified by Mond to add a full table

	.org 0x02053568
	.area 0x8C
		stmdb  r13!,{r3,r4,r5,r14}
		mov  r5,r0
		ldr r4,=pkmn_table
		b loop_find
	next_turn:
		ldrsh r1,[r5, #+0x4]
		bl 0x02054DC4
		cmp r0,#0x0
		bne found_move
		add  r4,r4,#0x6
	loop_find:
		ldrsh r0,[r4, #+0x0]
		cmp r0,#0x0
		bne next_turn
		ldmia  r13!,{r3,r4,r5,r15}
	found_move:
		add  r0,r5,#0x22
		bl 0x02013C64
		cmp r0,#0x4
		bne no_search
		ldrsh r1,[r4, #+0x4]
		add  r0,r5,#0x22
		bl 0x02013CAC
		mvn  r1,#0x0
		cmp r0,r1
		ldmeqia  r13!,{r3,r4,r5,r15}
	no_search:
		mov  r1,#0x6
		mla  r3,r0,r1,r5
		add  r0,r3,#0x22
		mov  r2,#0x0
		strb r2,[r0]
		ldrh r1,[r4, #+0x2]
		bl 0x02013828
		ldmia  r13!,{r3,r4,r5,r15}
		.pool
	.endarea

	.area 0x34
		.fill 0x20, 0x0
	.endarea

	.org 0x020A3258
	.area 0x20
		.fill 0x20, 0x0
	.endarea

	.org 0x020A32D4
	.area 0x24
		.fill 0x24, 0x0
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x35180
.area 0x280
	pkmn_table:
		.dcw 0x1
		.dcw 0x117
		.dcw 0
		.dcw 0x4
		.dcw 0xD0
		.dcw 0
		.dcw 0x7
		.dcw 0x1D9
		.dcw 0
		.dcw 0x19
		.dcw 0x4D
		.dcw 0
		.dcw 0x1B
		.dcw 0x1EB
		.dcw 0
		.dcw 0x25
		.dcw 0xA7
		.dcw 0
		.dcw 0x34
		.dcw 0x1BD
		.dcw 0
		.dcw 0x36
		.dcw 0x1D9
		.dcw 0
		.dcw 0x38
		.dcw 0xB3
		.dcw 0
		.dcw 0x3A
		.dcw 0x1C4
		.dcw 0
		.dcw 0x3F
		.dcw 0x1E9
		.dcw 0
		.dcw 0x42
		.dcw 0x1FE
		.dcw 0
		.dcw 0x4D
		.dcw 0xDE
		.dcw 0
		.dcw 0x4F
		.dcw 0x1D9
		.dcw 0
		.dcw 0x68
		.dcw 0x1BD
		.dcw 0
		.dcw 0x74
		.dcw 0x93
		.dcw 0
		.dcw 0x7B
		.dcw 0x211
		.dcw 0
		.dcw 0x85
		.dcw 0x79
		.dcw 0
		.dcw 0x93
		.dcw 0x1B0
		.dcw 0
		.dcw 0x98
		.dcw 0x5D
		.dcw 0
		.dcw 0x9B
		.dcw 0xD5
		.dcw 0
		.dcw 0x9E
		.dcw 0xB3
		.dcw 0
		.dcw 0xA1
		.dcw 0xA7
		.dcw 0
		.dcw 0xA5
		.dcw 0x1FE
		.dcw 0
		.dcw 0xAA
		.dcw 0xBC
		.dcw 0
		.dcw 0xAF
		.dcw 0xFD
		.dcw 0
		.dcw 0xB1
		.dcw 0xF4
		.dcw 0
		.dcw 0xB3
		.dcw 0x1
		.dcw 0
		.dcw 0xBE
		.dcw 0x1F5
		.dcw 0
		.dcw 0xC6
		.dcw 0xF4
		.dcw 0
		.dcw 0xF2
		.dcw 0xD5
		.dcw 0
		.dcw 0xF3
		.dcw 0xA7
		.dcw 0
		.dcw 0xFF
		.dcw 0x4D
		.dcw 0
		.dcw 0x102
		.dcw 0x5D
		.dcw 0
		.dcw 0x107
		.dcw 0x12C
		.dcw 0
		.dcw 0x109
		.dcw 0xE2
		.dcw 0
		.dcw 0x10A
		.dcw 0x44
		.dcw 0
		.dcw 0x10B
		.dcw 0x44
		.dcw 0
		.dcw 0x118
		.dcw 0x3F
		.dcw 0
		.dcw 0x11B
		.dcw 0x4D
		.dcw 0
		.dcw 0x11E
		.dcw 0x5D
		.dcw 0
		.dcw 0x121
		.dcw 0xC6
		.dcw 0
		.dcw 0x130
		.dcw 0x2E
		.dcw 0
		.dcw 0x134
		.dcw 0x1C3
		.dcw 0
		.dcw 0x139
		.dcw 0x213
		.dcw 0
		.dcw 0x147
		.dcw 0x90
		.dcw 0
		.dcw 0x148
		.dcw 0x1D9
		.dcw 0
		.dcw 0x14C
		.dcw 0x1C
		.dcw 0
		.dcw 0x151
		.dcw 0x1
		.dcw 0
		.dcw 0x158
		.dcw 0xD5
		.dcw 0
		.dcw 0x15E
		.dcw 0x5D
		.dcw 0
		.dcw 0x164
		.dcw 0x39
		.dcw 0
		.dcw 0x167
		.dcw 0x14C
		.dcw 0
		.dcw 0x169
		.dcw 0xD5
		.dcw 0
		.dcw 0x189
		.dcw 0x21F
		.dcw 0
		.dcw 0x18B
		.dcw 0x227
		.dcw 0
		.dcw 0x193
		.dcw 0xB3
		.dcw 0
		.dcw 0x1A6
		.dcw 0xD5
		.dcw 0
		.dcw 0x1A9
		.dcw 0xDE
		.dcw 0
		.dcw 0x1AC
		.dcw 0x1E7
		.dcw 0
		.dcw 0x1AF
		.dcw 0x2E
		.dcw 0
		.dcw 0x1B6
		.dcw 0xBE
		.dcw 0
		.dcw 0x1B9
		.dcw 0xD5
		.dcw 0
		.dcw 0x1BB
		.dcw 0x1
		.dcw 0
		.dcw 0x1C8
		.dcw 0x22B
		.dcw 0
		.dcw 0x1C9
		.dcw 0xD5
		.dcw 0
		.dcw 0x1CB
		.dcw 0x22B
		.dcw 0
		.dcw 0x1D5
		.dcw 0x5C
		.dcw 0
		.dcw 0x1D9
		.dcw 0x3F
		.dcw 0
		.dcw 0x1E5
		.dcw 0x145
		.dcw 0
		.dcw 0x1E8
		.dcw 0x1D9
		.dcw 0
		.dcw 0x1E9
		.dcw 0x3F
		.dcw 0
		.dcw 0x1ED
		.dcw 0x1B1
		.dcw 0
		.dcw 0x220
		.dcw 0xA7
		.dcw 0
		.dcw 0x13
		.dcw 0x34
		.dcw 0
		.dcw 0xCA
		.dcw 0x34
		.dcw 0
		.dcw 0xCC
		.dcw 0x1EB
		.dcw 0
		.dcw 0xCE
		.dcw 0x1BD
		.dcw 0
		.dcw 0x23
		.dcw 0xFD
		.dcw 0
		.dcw 0xD2
		.dcw 0x1C4
		.dcw 0
		.dcw 0xD4
		.dcw 0xDE
		.dcw 0
		.dcw 0xBC
		.dcw 0x77
		.dcw 0
		.dcw 0xC2
		.dcw 0x5D
		.dcw 0
		.dcw 0xEA
		.dcw 0x211
		.dcw 0
		.dcw 0xDC
		.dcw 0x145
		.dcw 0
		.dcw 0x1E0
		.dcw 0x48
		.dcw 0
		.dcw 0x1E1
		.dcw 0x213
		.dcw 0
		.dcw 0x1E2
		.dcw 0x22B
		.dcw 0
		.dcw 0x1F2
		.dcw 0x120
		.dcw 0
		.dcw 0xDE
		.dcw 0x85
		.dcw 0
		.dcw 0x13B
	.align
	.endarea
.close