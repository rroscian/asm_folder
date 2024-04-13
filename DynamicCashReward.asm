.nds
.open "arm9.bin", 0x2000000

    .org 0x2062e9c
    .area 0x4
		bl MissionCashDynamic
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x32B00
.area 0x32C00 - 0x32B00

MissionCashDynamic:
	push r1-r3, lr
	ldr r0, =0x22AB0D2
	ldrb r0, [r0]
	mov r1, #10
	bl 0x0208FEA4
	mov r1, #50
	mul r0, r0, r1
	add r0, r0, #50
	pop r1-r3, pc

.pool
.endarea
.close