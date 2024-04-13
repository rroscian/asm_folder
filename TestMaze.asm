.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x233aad4
    .area 0x10
    	mov r3, r0
    	strb r0, [sp, #0x8]
    	strb r1, [sp, #0x4]
    	bl MazeLayout
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33000
.area 0x332B0 - 0x33000

MazeLayout:
	mov r2, r9
	cmp r3, 0Bh
	blt 0x233B028
	stmdb sp!,{r4, r5, r6, lr}
	sub sp, sp, 0A60h
	sub sp, sp, 1000h
	mov r1, 1h
	add r0, sp, 0h
	mov r2, r1
	bl 0x233d004
	mov r5, 2h
	mov r1, 1h
	mov r0, 0h
	mov r3, 35h
	mov r2, 1Dh
	strh r5, [sp, 0h]
	strh r3, [sp, 04h]
	strh r5, [sp, 02h]
	strh r2, [sp, 6h]
	strh r1, [sp, 0Ah]
	strh r1, [sp, 0Bh]
	strh r0, [sp, 08h]
	b FollowCall1

Fct1:
	ldrsh r4, [sp, 2h]
	b Fct3

Fct2:
	mov r0, r5
	mov r1, r4
	bl 0x2336164
	ldrh r2, [r0, 0h]
	bic r2, r2, 3h
	orr r2, r2, 1h
	strh r2, [r0, 0h]
	add r4, r4, 1h

Fct3:
	ldrsh r0, [sp, 6h]
	cmp r4, r0
	blt Fct2
	add r5, r5, 1h

FollowCall1:
	ldrsh r0, [sp, 4h]
	cmp r5, r0
	blt Fct1
	add r0, sp, 0h
	mov r1, 0h
	bl 0x2340458
	mov r0, 0h
	mov r1, 2h
	mov r2, 2h
	bl Fct4
	mov r0, 1h
	mov r1, 2h
	mov r2, 1Ah
	bl Fct4
	mov r0, 2h
	mov r1, 32h
	mov r2, 2h
	bl Fct4
	mov r0, 3h
	mov r1, 2h
	mov r2, 1Ah
	bl Fct4
	mov r0, 4h
	mov r1, 1Ah
	mov r2, 0Eh
	bl Fct4
	mov r0, 2h
	mov r1, 2h
	bl Fct5
	mov r0, 2h
	mov r1, 4h
	bl Fct5
	mov r0, 4h
	mov r1, 2h
	bl Fct5
	mov r0, 4h
	mov r1, 4h
	bl Fct5
	mov r0, 2h
	mov r1, 1Ah
	bl Fct5
	mov r0, 2h
	mov r1, 1Ch
	bl Fct5
	mov r0, 4h
	mov r1, 1Ah
	bl Fct5
	mov r0, 4h
	mov r1, 1Ch
	bl Fct5
	mov r0, 32h
	mov r1, 2h
	bl Fct5
	mov r0, 32h
	mov r1, 4h
	bl Fct5
	mov r0, 34h
	mov r1, 2h
	bl Fct5
	mov r0, 34h
	mov r1, 4h
	bl Fct5
	mov r0, 32h
	mov r1, 1Ah
	bl Fct5
	mov r0, 32h
	mov r1, 1Ch
	bl Fct5
	mov r0, 34h
	mov r1, 1Ah
	bl Fct5
	mov r0, 34h
	mov r1, 1Ch
	bl Fct5
	mov r0, 1Ah
	mov r1, 0Eh
	bl Fct5
	mov r0, 1Ah
	mov r1, 10h
	bl Fct5
	mov r0, 1Ch
	mov r1, 0Eh
	bl Fct5
	mov r0, 1Ch
	mov r1, 10h
	bl Fct5
	add sp, sp, 0A60h
	add sp, sp, 1000h
	ldmia sp!,{r4, r5, r6, pc}

Fct4:
	stmdb sp!,{r4, r5, r6, r7, r8, r9, lr}
	mov r6, r0
	mov r7, r2
	mov r5, r1
	add r8, r1, 3h
	add r9, r2, 3h
	b FollowCall3

Fct6:
	mov r4, r7
	b FollowCall2

Fct7:
	mov r0, r5
	mov r1, r4
	bl 0x2336164
	ldrh r2, [r0, 0h]
	bic r2, r2, 3h
	orr r2, r2, 1h
	strh r2, [r0, 0h]
	strb r6, [r0, 7h]
	add r4, r4, 1h

FollowCall2:
	ldrsh r0, [sp, 6h]
	cmp r4, r9
	blt Fct7
	add r5, r5, 1h

FollowCall3:
	cmp r5, r8
	blt Fct6
	ldmia sp!,{r4-r9, pc}

Fct5:
	stmdb sp!,{lr}
	bl 0x2336164
	ldrh r1, [r0, 2h]
	orr r1, r1, 12h
	strh r1, [r0, 2h]
	ldmia sp!,{pc}

.endarea
.close