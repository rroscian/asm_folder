; ------------------------------------------------------------------------------
; Deals five damage to the enemy!
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
.definelabel GetMoveCritChance, 0x02013B10
.definelabel CalcDamage, 0x0230BBAC
.definelabel GetFaintReasonWrapper, 0x02324E44
.definelabel PerformDamageSequence, 0x02332D6C

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C
;.definelabel GetMoveCategory, 0x020151C8
;.definelabel GetMoveType, 0x0201390C
;.definelabel CalcDamageFixedWrapper, 0x0230DE68
;.definelabel GetFaintReasonWrapper, 0x023258AC

; File creation
.create "./code_out.bin", 0x02330134 ; For EU: 0x02330B74
	.org MoveStartAddress
	.area MaxSize
    	sub   r13, r13, #0x8  
    	ldr   r2, =23af0d0h ; Reset Move type and Category, for Sky Pact and Prankster
    	mov   r1, #0
    	str   r1, [r2]
    	add   r2, r2, 4h
    	str   r1, [r2]
		mov   r0, r8
		bl    GetMoveCritChance
		str   r0, [sp]
		add   r1, sp, #0xe4
		str   r1, [sp, #4]
		; Damage Multiplier
		ldr   r0, [r9, #+0xb4]
		ldr   r1, =146h
		add   r1, r0, r1
		ldrh  r0, [r1]
		cmp   r0, #0
		movne r0, #0x60
		bne   CheckRoyalMajesty
		ldrh  r0, [r1, 2h]
		cmp   r0, #0
		movne r0, #0x60
		moveq r0, #0x18
	CheckRoyalMajesty:
		ldr   r1, [r4, #+0xb4]
		add   r1, r1, 60h
		ldrb  r2, [r1]
		cmp   r2, #12
		beq   CheckFullHP
		ldrb  r2, [r1, 1h]
		cmp   r2, #12
		bne   CheckMarvelVeil
	CheckFullHP:
		ldr   r1, [r4, #+0xb4]
    	ldrsh r2, [r1,12h]
    	ldrsh r3, [r1,16h]
  		adds  r2, r2, r3
		ldr   r3, =#999
		cmp   r2, r3
		movgt r2, r3
		ldrsh r1, [r1,10h]
		cmp   r1, r2
		lsreq r0, r0, 1h
	CheckMarvelVeil:
		ldr   r1, [r4, #+0xb4]
		add   r1, r1, 60h
		ldrb  r2, [r1]
		cmp   r2, #139
		lsreq r0, r0, 1h
		ldrb  r2, [r1]
		cmp   r2, #139
		lsreq r0, r0, 1h
	StoreDamageMultiplier:
		str   r0, [sp, #8]
		mov   r2, #0 ; Move type: No type
		ldrh  r10, [r8, #4]
		mov   r3, #1 ; Move power: 1 Base Power
		mov   r1, #1
		str   r10, [sp, #12]
		str   r1, [sp, #16]
		mov   r0, r9
		mov   r1, r4
		bl    CalcDamage
		mov   r0, r8
		mov   r1, r7
		bl    GetFaintReasonWrapper
		str   r0, [sp, #0x8]
		mov   r0, r9
		mov   r1, r4
		mov   r2, r8
		add   r3, sp, #0xe4
		bl    PerformDamageSequence
		cmp   r0, #0
		movne r0, #1
		moveq r0, #0
		and   r10, r0, #0xff
    	add   r13, r13, #0x8
		b     MoveJumpAddress
		.pool
	.endarea
.close