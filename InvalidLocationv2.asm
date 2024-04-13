.nds
.arm
; Implements an invalid location system

.open "overlay_0001.bin", 0x02329520
	.org 0x023331AC
	.area 0x4
		; Original Instruction
		; bl 0x2025788
		b HookLoc
	EndHookLoc:
	.endarea
.close

.open "overlay_0036.bin", 0x023A7080
	.org 0x023A7080+0x35800
	.area 0x100
	HookLoc:
		bl 0x020258B8
		push r0,r3
		ldr r3, =0x22AB497
		ldrb r0, [r3]
		cmp r0, #255
		pop r0,r3
		beq EndHookLoc
		add  r0,r13,#0x400
		add  r0,r0,#0x94
		ldr r1,=string
		bl 0x02025100
		b EndHookLoc
		.pool
	string:
		.ascii "[CS:W]Update your save![CR]",0
	.endarea
.close
