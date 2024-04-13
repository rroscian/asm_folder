; // In overlay 29, US version
; Display Stats Bar in dungeons
; Version with fixed HP bar + Manual mode check

.org 0x02335A10
.area 0x530
	stmdb  r13!,{r4,r5,r6,r7,r8,r9,r10,r11,r14}
	sub  r13,r13,#0x44
	ldr r0,=0x02353538
	ldr r0,[r0, #+0x0]
	add  r5,r0,#0x1A000
	ldr r0,[r5, #+0x22C]
	cmp r0,#0x0
	beq end_display
	ldr r1,[r0, #+0x0]
	cmp r1,#0x0
	beq end_display
	ldr r1,=0x0237ca8c
	ldrb r1,[r1, #+0x12]
	cmp r1,#0x0
	bne end_display
	ldr r10,[r0, #+0xb4]
	mov  r6,#0x0
	ldrsh r3,[r10, #+0x12]
	ldrsh r2,[r10, #+0x16]
	ldr r1,=0x3E7
	mov  r11,r6
	add  r4,r3,r2
	cmp r4,r1
	movgt  r4,r1
	ldr r1,=0x02353538
	ldrsh r8,[r10, #+0x10]
	ldr r1,[r1, #+0x0]
	ldrb r9,[r10, #+0xa]
	ldrb r2,[r1, #+0x749]
	ldrsh r1,[r1, #+0x1e]
	add  r7,r2,r1
	bl 0x022FB610
	cmp r0,#0x0
	add  r0,r10,#0x100
	ldrh r1,[r0, #+0x46]
	sub  r2,r13,#0x4
	movne  r6,#0x1
	strh r1,[r2, #+0x0]
	ldrh r0,[r0, #+0x48]
	strh r0,[r2, #+0x2]
	ldr r0,[r2, #+0x0]
	bl 0x02051064
	cmp r0,#0x0
	moveq  r11,#0x1
	cmp r6,#0x0
	beq no_low_hp
	ldr r0,=0x0237c850
	ldr r0,[r0, #+0x0]
	tst r0,#0x10
	beq low_hp_alt_color
	mov  r0,#0x0
	mov  r1,r0
	mov  r10,#0x20
	bl 0x02027A68
	b check_belly
low_hp_alt_color:
	mov  r0,#0x1
	mov  r1,#0x0
	mov  r10,#0x10
	bl 0x02027A68
	b check_belly
no_low_hp:
	mov  r10,#0x10
	bl 0x0234CF60
check_belly:
	cmp r11,#0x0
	beq no_belly_alt_color
	ldr r0,=0x0237c850
	ldr r0,[r0, #+0x0]
	ands r0,r0,#0x10
	movne  r10,#0x30
	cmp r6,#0x0
	bne no_belly_alt_color
	cmp r0,#0x0
	beq belly_std_color
	mov  r0,#0x3
	mov  r1,#0x0
	bl 0x02027A68
	b no_belly_alt_color
belly_std_color:
	bl 0x0234CF60
no_belly_alt_color:
	add  r0,r13,#0x4
	mov  r1,#0x2
	bl 0x02335808
	mov  r6,#0x0
	bl 0x022E0880
	cmp r0,#0x0
	addne  r6,r6,#0x18
	bne no_floor
	ldr r0,=0x02353538
	ldr r0,[r0, #+0x0]
	ldrb r0,[r0, #+0x748]
	bl 0x02051288
	cmp r0,#0x0
	bne goes_up
	mov  r1,r6
	add  r0,r13,#0x4
	mov  r2,r1
	mov  r3,#0x18
	str r10,[r13, #+0x0]
	bl 0x02335988
	add  r6,r6,r0
goes_up:
	ldrb r0,[r5, #+0x24B]
	cmp r0,#0x0
	moveq  r3,#0x1
	movne  r3,#0x0
	mov  r2,r7
	mov  r0,r6
	mov  r1,#0x0
	bl 0x02335880
	add  r6,r6,r0
	add  r0,r13,#0x4
	mov  r1,r6
	mov  r2,#0x0
	mov  r3,#0x14
	str r10,[r13, #+0x0]
	bl 0x02335988
	add  r6,r6,r0
no_floor:
	add  r0,r13,#0x4
	mov  r1,r6
	str r10,[r13, #+0x0]
	mov  r2,#0x0
	mov  r3,#0x15
	bl 0x02335988
	ldrb r1,[r5, #+0x24B]
	add  r6,r6,r0
	cmp r1,#0x0
	moveq  r3,#0x1
	movne  r3,#0x0
	mov  r2,r9
	mov  r0,r6
	mov  r1,#0x0
	bl 0x02335880
	mov  r6,#0x48
	add  r0,r13,#0x4
	mov  r1,r6
	str r10,[r13, #+0x0]
	mov  r2,#0x0
	mov  r3,#0x16
	bl 0x02335988
	ldrb r1,[r5, #+0x24B]
	add  r6,r0,#0x48
	cmp r1,#0x0
	moveq  r3,#0x1
	movne  r3,#0x0
	mov  r2,r8
	mov  r0,r6
	mov  r1,#0x0
	bl 0x02335880
	add  r6,r6,r0
	add  r0,r13,#0x4
	mov  r1,r6
	str r10,[r13, #+0x0]
	mov  r2,#0x0
	mov  r3,#0x17
	bl 0x02335988
	ldrb r1,[r5, #+0x24B]
	add  r6,r6,r0
	cmp r1,#0x0
	moveq  r3,#0x1
	movne  r3,#0x0
	mov  r2,r4
	mov  r0,r6
	mov  r1,#0x0
	bl 0x02335880
add_manual: ; // Section for manual mode check
	ldr r0,=(0x023A7080+0x10)
	ldrb r0,[r0]
	cmp r0,#1
	bne end_add_manual
	add  r0,r13,#0x4
	mov r1,#240
	str r10,[r13, #+0x0]
	mov  r2,#8
	mov  r3,#0x1D ; one line must be added in the UI WTE/WTU texture
	bl 0x02335988
end_add_manual:
	ldr r0,=0x0237ca8c
	cmp r4,#0x0
	ldr r0,[r0, #+0x4]
	mov  r5,#0x90
	ldr r9,[r0, #+0x4]
	mov  r6,#0x10
	blt end_display
	add  r0,r13,#0x4
	bl 0x0201E730
	; // Normalize HP bar on 0x68 pixels
	mov r1,#0x68
	mul r0,r8,r1
	mov r1,r4
	bl 0x0208FEA4
	mov r7,r0
	cmp r1,#0
	addne r7,r7,#1
	mov r4,#0x68
	ldr r0,=0x0237ca8c
	mov  r11,#0x5
	ldrh r3,[r0, #+0x0]
	mov  r10,#0x28
	mov  r2,#0x1000
	ldr r1,=0x020afc70
	str r2,[r13, #+0x24]
	ldr r0,[r1, #+0x0]
	strb r11,[r13, #+0x40]
	strb r10,[r13, #+0x42]
	strh r3,[r13, #+0x18]
	ldr r0,[r0, #+0xe0]
	mov  r1,#0x0
	mov  r2,#0x90
	add  r0,r0,#0x400
	str r0,[r13, #+0x28]
	add  r3,r4,#0x90
	strh r1,[r13, #+0x6]
	strh r3,[r13, #+0x8]
	strh r1,[r13, #+0xa]
	add  r0,r6,#0x1
	mov  r1,r0,lsl #0x10
	strh r2,[r13, #+0x4]
	strh r2,[r13, #+0xc]
	ldrsh r2,[r9, #+0xce]
	mov  r6,r1,asr #0x10
	add  r0,r13,#0x4
	strh r2,[r13, #+0xe]
	strh r3,[r13, #+0x10]
	ldrsh r3,[r9, #+0xce]
	mov  r2,#0x10
	strh r3,[r13, #+0x12]
	ldrsh r3,[r9, #+0xc8]
	strh r3,[r13, #+0x1a]
	ldrsh r1,[r9, #+0xca]
	strh r1,[r13, #+0x1c]
	ldrsh r1,[r9, #+0xcc]
	strh r1,[r13, #+0x1e]
	ldrsh r1,[r9, #+0xce]
	strh r1,[r13, #+0x20]
	strh r2,[r13, #+0x2e]
	bl 0x0201F2A0
	cmp r8,#0x0
	ble no_hp
	add  r2,r7,#0x90
	mov  r3,#0x90
	mov  r1,#0x0
	strh r3,[r13, #+0x4]
	strh r2,[r13, #+0x8]
	strh r3,[r13, #+0xc]
	strh r1,[r13, #+0x6]
	strh r1,[r13, #+0xa]
	ldrsh r1,[r9, #+0xe6]
	add  r0,r13,#0x4
	strh r2,[r13, #+0x10]
	strh r1,[r13, #+0xe]
	ldrsh r1,[r9, #+0xe6]
	strh r1,[r13, #+0x12]
	ldrsh r1,[r9, #+0xe0]
	strh r1,[r13, #+0x1a]
	ldrsh r1,[r9, #+0xe2]
	strh r1,[r13, #+0x1c]
	ldrsh r1,[r9, #+0xe4]
	strh r1,[r13, #+0x1e]
	ldrsh r1,[r9, #+0xe6]
	strh r1,[r13, #+0x20]
	strh r6,[r13, #+0x2e]
	bl 0x0201F2A0
no_hp:
	sub  r1,r4,r7
	cmp r1,#0x0
	ble end_display
	add  r0,r5,r7
	add  r2,r1,r0
	mov  r3,r0
	mov  r0,#0x0
	strh r3,[r13, #+0x4]
	strh r0,[r13, #+0x6]
	strh r0,[r13, #+0xa]
	strh r2,[r13, #+0x8]
	strh r3,[r13, #+0xc]
	ldrsh r1,[r9, #+0xde]
	add  r0,r13,#0x4
	strh r2,[r13, #+0x10]
	strh r1,[r13, #+0xe]
	ldrsh r1,[r9, #+0xde]
	strh r1,[r13, #+0x12]
	ldrsh r1,[r9, #+0xd8]
	strh r1,[r13, #+0x1a]
	ldrsh r1,[r9, #+0xda]
	strh r1,[r13, #+0x1c]
	ldrsh r1,[r9, #+0xdc]
	strh r1,[r13, #+0x1e]
	ldrsh r1,[r9, #+0xde]
	strh r1,[r13, #+0x20]
	strh r6,[r13, #+0x2e]
	bl 0x0201F2A0
end_display:
	add  r13,r13,#0x44
	ldmia  r13!,{r4,r5,r6,r7,r8,r9,r10,r11,r15}
	.pool
	.fill 0x02335A10+0x530-., 0xCC
.endarea
