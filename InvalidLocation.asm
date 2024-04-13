.nds
.arm
; Implements an invalid location system

.open "overlay_0001.bin", 0x02329520
	.org 0x023331AC
	.area 0x4
		b HookLoc
	EndHookLoc:
	.endarea
.close

.open "overlay_0036.bin", 0x023A7080
	.org 0x023A7080+0x35800
	.area 0x80
	HookLoc:
		bl 0x020258B8
		mov r0,#0
		mov r1,#1
		bl 0x0204B4EC
		cmp r0,#0
		cmpne r0,#3
		beq EndHookLoc
		add  r0,r13,#0x400
		add  r0,r0,#0x94
		ldr r1,=string
		bl 0x02025100
		b EndHookLoc
		.pool
	string:
		.ascii "[CS:W]Wrong Version[CR]",0
	.endarea
.close
