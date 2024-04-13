.nds
.open "overlay_0029.bin", 0x22DC240

    .org 0x2314910
    .area 0x10
		bl FixSpeedBoosts
		nop
		nop
		nop
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33980
.area 0x339C0 - 0x33980

FixSpeedBoosts:
	push r0-r5, lr
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x38 ; Vanilla
    bl 0x204B678
    cmp r0, 1h
    popne r0-r5, pc
    mov r0, #1
    strb r0, [r5, #+0x101]
    mov r0, #0
    strb r0, [r5, #+0x152]
    pop r0-r5, pc

.endarea
.close