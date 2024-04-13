.nds
.open "overlay_0031.bin", 0x2382820
.org 0x238287C
.area 0x48
	; 74
	ldr r0, =22AB0D4h ; Mysteriosity Type
	ldrb r0, [r0]
    ; Type: Fairy*/
    strb r0, [sp,214h]
    push r0-r3
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x12
    bl 0x204B678
    cmp r0, 1h
    pop r0-r3
    ldreq r0, =8B2h ; String 2226
    ldrne r0, =96Fh ; String 2415
    bl 0x20258c4 ; StringFromMessageId
    b 0x23828c8
.pool
.endarea

.org 0x23828c8
.area 0x4
    add r1, sp, 0x204
.endarea

.org 0x23828d4
.area 0x4
    add r0, sp, 0x104
.endarea
.close