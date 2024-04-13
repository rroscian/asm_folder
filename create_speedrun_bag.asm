.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; TODO: Currently only US versions are supported

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		; r7 and r6 are arguments (1 and 2 respectively)
		sub r13,r13,#0x44
		push r5
		ldr r4,=0x20af6b8
		ldr r4,[r4]
		add r4,r4,#0x8A ; Bag Struct

		mov r1, r7 ; First Argument: Bag to create !
		; Challenges: 0 = Speedrun Bag, 1 = Pacifist Bag
		; Zero Isle North: 2 = Troll Bag, 3 = Status Bag, 4 = Balance Bag, 5 = Fight Bag, 6 = Explorer Bag
		; Help: 7 = Survival Bag, 8 = Starting Bag
		; r5 = item table pointer
		cmp r1, 0h
		ldreq r5,=speedrun_table 
		cmp r1, 1h
		ldreq r5,=pacifist_table
		cmp r1, 2h
		ldreq r5,=troll_table
		cmp r1, 3h
		ldreq r5,=status_table
		cmp r1, 4h
		ldreq r5,=balance_table
		cmp r1, 5h
		ldreq r5,=fight_table
		cmp r1, 6h
		ldreq r5,=explorer_table
		cmp r1, 7h
		ldreq r5,=survival_table
		cmp r1, 8h
		ldreq r5,=starting_table
		cmp r1, 9h
		bge return
		mov r4, #0 ; Amount of X items added to the bag
	LoopItemGive:
		ldrh r1, [r5, 0h]
		add r0, r13, #0x38
		strh r1, [r13, #0x38]
		cmp r1, 0Ah
		movgt r1, 0h
		movle r1, 63h
		strh r1, [r13, #0x3a]
		push r2, r3, r5
		mov r5, r13
		bl 0x200f84c ; CreateItemToBag
		mov r13, r5
		pop r2, r3, r5
		add r4, r4, 1h
		ldrh r2, [r5, 2h]
		cmp r4, r2
		blt LoopItemGive
		mov r4, #0
	nextIterLoopItemGive:
		ldrh r3, [r5, 4h]
		ldr r1, =0xFFFF
		cmp r3, r1
		addne r5, r5, 4h
		bne LoopItemGive

	return:
		pop r5
		add r13,r13,#0x44
		b ProcJumpAddress
		.pool

	speedrun_table:
		.dcw 0x10 ; Mobile Scarf
		.dcw 0x1
		.dcw 0x1D ; Warp Scarf
		.dcw 0x1
		.dcw 0x2B ; Space Globe
		.dcw 0x1
		.dcw 0x34 ; Weather Band
		.dcw 0x1
		.dcw 0x5b ; Stun Seed
		.dcw 0x1
	; Multiple Items
		.dcw 0x0B ; Frustration Band
		.dcw 0x2
		.dcw 0xD0 ; TM Frustration
		.dcw 0x2
		.dcw 0x57 ; Blast Seed x2
		.dcw 0x2
		.dcw 0x5f ; Pure Seed x2
		.dcw 0x2
		.dcw 0x14F ; Rollcall Orb x2
		.dcw 0x2
		.dcw 0x13F ; Petrify Orb x3
		.dcw 0x3
		.dcw 0x63 ; Max Elixir x4
		.dcw 0x4
		.dcw 0x56 ; Warp Seed x3
		.dcw 0x3
		.dcw 0x169 ; Sweet Heart x6
		.dcw 0x6
		.dcw 0x6e ; Big Apple x4
		.dcw 0x4
		.dcw 0x49 ; Reviver Seed x12
		.dcw 0xC
		.dcw 0xFFFF
		.align

	pacifist_table:
		.dcw 0xA ; Rare Fossil
		.dcw 0x1
		.dcw 0x1D ; Warp Scarf
		.dcw 0x1
		.dcw 0x57 ; Blast Seed
		.dcw 0x8
		.dcw 0x45 ; Heal Seed
		.dcw 0x4
		.dcw 0x46 ; Oran Berry
		.dcw 0x4
		.dcw 0x56 ; Warp Seed
		.dcw 0x6
		.dcw 0x5B ; Stun Seed
		.dcw 0x6
		.dcw 0x49 ; Reviver Seed
		.dcw 0x8
		.dcw 0x6e ; Big Apple
		.dcw 0x7
		.dcw 0x5f ; Pure Seed
		.dcw 0x2
		.align

	troll_table:
		.dcw 0x0D
		.dcw 0x1
		.dcw 0x2F
		.dcw 0x1
		.dcw 0x0F
		.dcw 0x1
		.dcw 0x55
		.dcw 0x4
		.dcw 0x6F
		.dcw 0x2
		.dcw 0x74
		.dcw 0x2
		.dcw 0x69
		.dcw 0x5
		.dcw 0xFFFF
		.align

	status_table:
		.dcw 0x19
		.dcw 0x1
		.dcw 0x1B
		.dcw 0x1
		.dcw 0x2C
		.dcw 0x1
		.dcw 0x4C
		.dcw 0x2
		.dcw 0x54
		.dcw 0x2
		.dcw 0x6D
		.dcw 0x2
		.dcw 0x63
		.dcw 0x2
		.dcw 0x5A
		.dcw 0x2
		.dcw 0x13C
		.dcw 0x2
		.dcw 0x13F
		.dcw 0x1
		.dcw 0x146
		.dcw 0x2
		.dcw 0x147
		.dcw 0x2
		.dcw 0x154
		.dcw 0x2
		.dcw 0x164
		.dcw 0x2
		.dcw 0xFFFF
		.align

	balance_table:
		.dcw 0x12
		.dcw 0x2
		.dcw 0x1C
		.dcw 0x2
		.dcw 0x56
		.dcw 0x2
		.dcw 0x45
		.dcw 0x2
		.dcw 0x6E
		.dcw 0x2
		.dcw 0x63
		.dcw 0x2
		.dcw 0x13F
		.dcw 0x2
		.dcw 0x143
		.dcw 0x2
		.dcw 0x14C
		.dcw 0x2
		.dcw 0x164
		.dcw 0x2
		.dcw 0x165
		.dcw 0x2
		.dcw 0x166
		.dcw 0x2
		.dcw 0xFFFF
		.align

	fight_table:
		.dcw 0x15
		.dcw 0x1
		.dcw 0x16
		.dcw 0x1
		.dcw 0x2D
		.dcw 0x1
		.dcw 0x34
		.dcw 0x1
		.dcw 0x48
		.dcw 0x1
		.dcw 0x50
		.dcw 0x1
		.dcw 0x5E
		.dcw 0x2
		.dcw 0x60
		.dcw 0x2
		.dcw 0x6A
		.dcw 0x2
		.dcw 0x70
		.dcw 0x2
		.dcw 0x63
		.dcw 0x2
		.dcw 0x13E
		.dcw 0x1
		.dcw 0x13F
		.dcw 0x1
		.dcw 0x14C
		.dcw 0x2
		.dcw 0x14E
		.dcw 0x2
		.dcw 0x14F
		.dcw 0x2
		.dcw 0xFFFF
		.align

	explorer_table:
		.dcw 0x11
		.dcw 0x1
		.dcw 0x13
		.dcw 0x1
		.dcw 0x1C
		.dcw 0x1
		.dcw 0x1D
		.dcw 0x1
		.dcw 0x56
		.dcw 0x2
		.dcw 0x45
		.dcw 0x2
		.dcw 0x63
		.dcw 0x3
		.dcw 0x6E
		.dcw 0x3
		.dcw 0x13F
		.dcw 0x2
		.dcw 0x146
		.dcw 0x2
		.dcw 0x147
		.dcw 0x2
		.dcw 0x14E
		.dcw 0x2
		.dcw 0x156
		.dcw 0x2
		.dcw 0xFFFF
		.align
		
	survival_table:
		.dcw 0x169 ; Sweet Heart x2
		.dcw 0x2
		.dcw 0x6e ; Big Apple x2
		.dcw 0x2
		.dcw 0x49 ; Reviver Seed x2
		.dcw 0x2
		.dcw 0x5f ; Pure Seed x2
		.dcw 0x2
		.dcw 0x63 ; Max Elixir x2
		.dcw 0x2
		.dcw 0x46 ; Oran Berry x2
		.dcw 0x2
		.dcw 0x56 ; Warp Seed x2
		.dcw 0x2
		.dcw 0x13F ; Petrify Orb x2
		.dcw 0x3
		.dcw 0xFFFF
		.align

	starting_table:
		.dcw 0x25
		.dcw 0x1
		.dcw 0x17
		.dcw 0x1
		.dcw 0x28
		.dcw 0x1
		.dcw 0x29
		.dcw 0x1
		.dcw 0x1A
		.dcw 0x1
		.dcw 0x57
		.dcw 0x1
		.dcw 0x67
		.dcw 0x6
		.dcw 0x6D
		.dcw 0x3
		.dcw 0x78
		.dcw 0x1
		.dcw 0x79
		.dcw 0x1
		.dcw 0x7A
		.dcw 0x1
		.dcw 0x7B
		.dcw 0x1
		.dcw 0x7C
		.dcw 0x1
		.dcw 0x7D
		.dcw 0x1
		.dcw 0x7E
		.dcw 0x1
		.dcw 0x7F
		.dcw 0x1
		.dcw 0x80
		.dcw 0x1
		.dcw 0x81
		.dcw 0x1
		.dcw 0x82
		.dcw 0x1
		.dcw 0x83
		.dcw 0x1
		.dcw 0x84
		.dcw 0x1
		.dcw 0x85
		.dcw 0x1
		.dcw 0x86
		.dcw 0x1
		.dcw 0x87
		.dcw 0x1
		.dcw 0x8A
		.dcw 0x1
		.dcw 0xFFFF
		.align
	.endarea
.close