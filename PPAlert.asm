.nds
.open "overlay_0029.bin", 0x22DC240
	.org 0x2324e24
	.area 0x8
		bne PPAlert ; subne r3, r3, #1
		nop
	.endarea

	.org 0x2324e34
	.area 0x4
		add r1, r1, 0x1
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
	.orga 0x2DF00
	.area 0x2E000 - 0x2DF00
	PPAlert:
		sub r3, r3, #1
		cmp r3, #0
		bne ReturnPPAlert
		push r0-r3, lr
		push r2
		mov r0, r5
		mov r1, #62
		bl 0x022e42e8 ; LoadAndPlayAnimation
	    mov r0, r5
	    bl 0x22E3AB4
	    pop r2
	    mov r0, #0
	    ldrh r1, [r2, 4h] ; move ID
	    bl 0x234b084
	    mov r0, r5
	    ldr r1, =#3868 ; this is the string ID I use, change it for your game
    	bl 0x234B498
	    pop r0-r3, lr
	ReturnPPAlert:
		strb r3, [r2, 6h]
		b 0x2324e2c
	.pool
	.endarea
.close