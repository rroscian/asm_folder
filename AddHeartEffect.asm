.nds
.open "arm9.bin", 0x2000000

.org 0x200ce24
.area 0x4
	bne AddHeartCheck
.endarea
.close

.open "overlay_0019.bin", 0x238a140
.org 0x238B7C0
.area 0x4
	b AddHeartEffect
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x30000
.area 0x30200 - 0x30000

AddHeartEffect:
	push r2
	ldr r2, [SweetHeartId]
	cmp r1, r2
	pop r2
	beq ApplyOmniboost
	b 0x238BA3C
ApplyOmniboost:
	ldr r5, [r13, 24h]
	add r1, r13, 24h
	mov r0, r4
	push r14
	bl 0x201170C
	pop r14
	add r1, r13, 24h
	mov r0, r4
	push r14
	bl 0x2011748
	pop r14
	add r1, r13, 24h
	mov r0, r4
	push r14
	bl 0x2011784
	pop r14
	add r1, r13, 24h
	mov r0, r4
	bl 0x20117C0
	mov r1, r5
	mov r2, 6h
	bl 0x238C900
	mov r5, r0
	b 0x238BCE8
AddHeartCheck:
	push r1
	ldr r1, [SweetHeartId]
	cmp r0, r1
	pop r1
	beq 0x200ce64
	bne 0x200ce28
SweetHeartId:
	.dcw 0x169
.align
.endarea
.close