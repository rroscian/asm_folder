; ------------------------------------------------------------------------------
; Spectral Thief
; Deals damage, and if successful, copies all of the target's positive stat changes!
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize
		ldr r0,[r4,#+0xb4]
		ldr r2,[r9,#+0xb4]
		mov r3,#0x24
		mov r12,#0xa
@@boost_loop:
		ldrh r1,[r0,r3] ; Target Boost
		cmp r1,r12
		ble @@next_boost_iter
		push r4, r5
		mov r4, #1
		ldr r5, =flagHasStolenBoosts
		strb r4, [r5]
		pop r4, r5
		push r4
		sub r1, r1, r12
		ldrh r4, [r2, r3]
		add r1, r4, r1
		cmp r1, #20
		movgt r1, #20
		pop r4
		strh r1,[r2,r3]
		strh r12,[r0,r3]
@@next_boost_iter:
		cmp r3,#0x2e
		addlt r3,r3,#0x2
		blt @@boost_loop
		; Write String
		ldr r1, =flagHasStolenBoosts
		ldrb r0, [r1]
		cmp r0, #1
		bne @@damage

		mov r0,#0
		mov r1,r9
		mov r2,#0
		bl ChangeString
		mov r0,#1
		mov r1,r4
		mov r2,#0
		bl ChangeString
		mov r0,r9
		ldr r1,=grand_larceny
		bl SendMessageWithStringLog
@@damage:
		mov r0,r9
		mov r1,r4
		mov r2,r8
		mov r3,#0x100
		bl DealDamage
		mov r10, r0

		push r0, r1
		mov r0, #0
		ldr r1, =flagHasStolenBoosts
		strb r0, [r1]
		pop r0, r1
@@ret:
		b MoveJumpAddress
		.pool
	grand_larceny:
		.asciiz "[string:0] stole [string:1]'s stat boosts!"
	flagHasStolenBoosts:
		.word 0x0

	.endarea
.close