.nds
.open "overlay_0022.bin", 0x238a140
	.org 0x238D9FC
    .area 0x4
		bl MoneyPouchAmount
    .endarea

	.org 0x238DA6C
    .area 0x4
		bl MoneyPouchAmount
    .endarea

	.org 0x238E0D8
    .area 0x4
		bl MoneyPouchAmount
    .endarea

	.org 0x238E444
    .area 0x4
		bl MoneyPouchAmount
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x33900
.area 0x33940 - 0x33900

MoneyPouchAmount:
	push r2, lr
	ldr r1, =0x22AB0D2
	ldr r2, =0x200ED50
	ldrb r1, [r1]
	cmp r1, #25
	ldrge r1, =0F423Fh
	ldrlt r1, =01869Fh
	str r1, [r2]
	ldr r2, =0x2042a7c
	str r1, [r2]
	pop r2, pc

.pool
.endarea
.close