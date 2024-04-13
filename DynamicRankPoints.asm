.nds
.open "arm9.bin", 0x2000000
.org 0x2063088
.area 0x4
	bl SelectRankList
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x35A00
.area 0x35B80 - 0x35A00

SelectRankList:
	push r0, r2-r6, lr
	mov r6, r13
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x3F ; Scizor Post-Darkrai
    bl 0x204B678
    cmp r0, 1h
    ldreq r1, =UltimateList
    beq afterSelect
    mov r1, 0x4E
    mov r2, 0x14 ; Graduation
    bl 0x204B678
    cmp r0, 1h
    ldreq r1, =GraduationList
    beq afterSelect
	ldr r1, =StandardList
afterSelect:
	ldr r4, =20a3d6ch
	mov r5, 0h
loopReplaceList:
	ldr r0, [r1, r5]
	str r0, [r4, r5]
nextIterReplaceList:
	add r5, r5, 4h
	cmp r5, 40h
	bne loopReplaceList
	mov r13, r6
	pop r0, r2-r6, pc

StandardList:
	.dcd 0xA
	.dcd 0xF
	.dcd 0x14
	.dcd 0x1E
	.dcd 0x28
	.dcd 0x3C
	.dcd 0x5A
	.dcd 0x96
	.dcd 0xFA
	.dcd 0x190
	.dcd 0x258
	.dcd 0x320
	.dcd 0x3E8
	.dcd 0x4B0
	.dcd 0x578
	.dcd 0x640

GraduationList:
	.dcd 0xF
	.dcd 0x14
	.dcd 0x1E
	.dcd 0x2D
	.dcd 0x3C
	.dcd 0x5A
	.dcd 0x87
	.dcd 0xE1
	.dcd 0x177
	.dcd 0x258
	.dcd 0x384
	.dcd 0x4B0
	.dcd 0x5DC
	.dcd 0x708
	.dcd 0x834
	.dcd 0x960

UltimateList:
	.dcd 0x14
	.dcd 0x1E
	.dcd 0x28
	.dcd 0x3C
	.dcd 0x50
	.dcd 0x78
	.dcd 0xB4
	.dcd 0x12C
	.dcd 0x1F4
	.dcd 0x320
	.dcd 0x4B0
	.dcd 0x640
	.dcd 0x7D0
	.dcd 0x960
	.dcd 0xAF0
	.dcd 0xC80

.pool
.endarea
.close