
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x231454c
	.area 0x4
		mov r9, r1
	.endarea

	.org 0x2314564
	.area 0x4
		cmp r0, #0
	.endarea

	.org 0x23145c0
	.area 0x4
		beq getTypeElectr
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080

	.orga 0x339B8
	.area 0x33A00 - 0x339B8

getTypeElectr:
	mov r0, r9
	mov r1, #5
	bl 0x2301E50
	cmp r0, 0h
	beq 0x23145f4
	cmp r8, 0h
	beq 0x23145ec
	mov r0,#0
	mov r1,r9
	mov r2,#0
	bl 0x22E2AD8
    mov r0, r9
    ldr r1, =#3130
    bl 0x234B498
	beq 0x23145ec

	.pool
	.endarea
.close