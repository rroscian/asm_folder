.nds
.open "arm9.bin", 0x2000000
.org 0x2051380
.area 0x4
	b NoHCRescue
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x31080
.area 0x31100 - 0x31080

NoHCRescue:
	push r5
	mov r5, lr
	push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3B
    bl 0x204B678
    cmp r0, 1h
    pop r0-r3
    mov lr, r5
    pop r5
    moveq r0, #0
    beq 0x2051390
    mov r1, #0xc
    b 0x2051384
.endarea
.close