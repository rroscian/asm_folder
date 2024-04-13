.nds
.open "overlay_0011.bin", 0x22DC240
	
	.org 0x230c6B8
	.area 0x8
		b SandboxSwap
		b SandboxSet
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33F00
.area 0x33F80 - 0x33F00 ; ?

SandboxSwap:
	push r0-r3
SandboxEndgame:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3E
    bl 0x204B678
    cmp r0, 1h
GodmodeSwap:
    popeq r0
    moveq r0, 2h
    popeq r1-r3
    beq return
    pop r0-r3
    b return

SandboxSet:
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x35
    bl 0x204B678
    cmp r0, 1h
    bne MaingameSwapCheck
    b GodmodeSwap
MaingameSwapCheck:
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x12
    bl 0x204B678
    cmp r0, 1h
    popne r0
    movne r0, 0h
    popne r1-r3
    bne return
    b SandboxEndgame

return:
    b 0x230C6C0

.endarea
.close