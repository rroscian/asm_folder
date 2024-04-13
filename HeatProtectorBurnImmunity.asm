
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x23123cc
	.area 0x4
		beq getLavaAvoider
	.endarea

	.org 0x2312458
	.area 0x4
		beq 0x231247c
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x32F00
.area 0x32F80 - 0x32F00

getLavaAvoider:
	mov r0,r9
	mov r1,#20
	bl 0x2301F80 ; HasIQSkillEnabled
	cmp r0, 0h
	beq getWaterBubble
	cmp r8, 0h
	beq 0x23123e8
	mov r0,#0
	mov r1,r9
	mov r2,#0
	bl 0x22E2AD8
    mov r0, r9
    ldr r1, =#1526
    bl 0x234B498
    b 0x23123e8

getWaterBubble:
	mov r0, r9
	mov r1, #156
	bl 0x02301D10 ; HasAbility
	cmp r0, 0h
	beq 0x23123f0
	cmp r8, 0h
	beq 0x23123e8
	mov r0,#0
	mov r1,r9
	mov r2,#0
	bl 0x22E2AD8
    mov r0, r9
    ldr r1, =#1541
    bl 0x234B498
    b 0x23123e8

.pool
.endarea
.close