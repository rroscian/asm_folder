.nds
.open "overlay_0029.bin", 0x22DC240

    .org 0x2309ef8
    .area 0x4
        bl CheckHCRevive
    .endarea

    .org 0x230a1c8
    .area 0x4
        bl CheckHCRevive
    .endarea

    .org 0x230a410
    .area 0x4
        bl CheckHCRevive
    .endarea
.close

; Original Code: bl 0x22F9A74
.open "overlay_0036.bin", 0x23A7080
.orga 0x2E7C0
.area 0x2E800 - 0x2E7C0

CheckHCRevive:
	push r0, lr
	ldr r0, =22C44DCh
	ldrb r0, [r0]
	cmp r0, #12
	movlt r0, r0
	blt return
	mov r0, r7
	bl 0x22F9A74
return:
	pop r0, pc

.pool
.endarea
.close