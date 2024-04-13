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
.orga 0x8B0
.area 0x100
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
		.dcw 0x25
		.dcw 0xA7
		.dcw 0
		.dcw 0x85
		.dcw 0x79
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
		.dcw 0x102
		.dcw 0x5D
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
		.dcw 0x148
		.dcw 0x1D9
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
		.dcw 0x1B6
		.dcw 0xBE
		.dcw 0
		.dcw 0x1E8
		.dcw 0x1D9
		.dcw 0
		.dcw 0x1E9
		.dcw 0x3F
		.dcw 0
		.dcw 0x220
		.dcw 0xA7
		.dcw 0
		.fill 0x80, 0x0
		.dcw 0x13B
	.endarea
.close