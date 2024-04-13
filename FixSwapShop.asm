.nds
.open "overlay_0011.bin", 0x22DC240
	
	.org 0x230c3f4
	.area 0x4
		bl loadAdress1
	.endarea

	.org 0x230c328 ; r4 fix upper bound
	.area 0x4
		bl FixCheck1
	.endarea

	.org 0x230c330 ; r4 fix lower bound
	.area 0x4
		bl FixCheck15
	.endarea

	.org 0x230c460
	.area 0x4
		bl loadAdress2
	.endarea

	.org 0x230c480 ; r5 fix upper bound
	.area 0x4
		bl FixCheck2
	.endarea

	.org 0x230c488 ; r5 fix lower bound
	.area 0x4
		bl FixCheck25
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34000
.area 0x34080 - 0x34000

loadAdress1:
	push lr
	ldr r4, =230c4cch
	pop pc
	.pool

loadAdress2:
	push lr
	ldr r5, =230c4cch
	pop pc
	.pool

FixCheck1:
	push r4, lr
	ldrh r4, [r4, 0h]
	cmp r0, r4
	pop r4, pc

FixCheck15:
	push r4, lr
	ldrh r4, [r4, 2h]
	cmp r0, r4
	pop r4, pc

FixCheck2:
	push r5, lr
	ldrh r5, [r5, 0h]
	cmp r0, r5
	pop r5, pc

FixCheck25:
	push r5, lr
	ldrh r5, [r5, 2h]
	cmp r0, r5
	pop r5, pc

.endarea
.close