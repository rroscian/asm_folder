; ------------------------------------------------------------------------------
; Team Name to Integer
; Converts a Chimecho Assembly member's name to an integer, if possible!
; Param 1: global_variable_id
; Returns: 
; * 0 if not a number.
; * 1 if the number inputted is too big.
; * 2 if successful. The Species ID will be placed in the global variable specified in the first argument.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48
.definelabel SetGameVar, 0x0204B820
.definelabel IntToSpecies, 0x20526C8

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x400
		sub r0,r0,#0xc8
		mov r12,#0
		mov r2,#0
		mov r3,#10
@@name_loop:
		ldrb r1,[r0],#0x1
		cmp r1,#0
		beq @@true ; If null byte, stop!
		subs r1,r1,#48
		bmi @@false ; Not a number!
		cmp r1,#10
		bge @@false ; Not a number!
		mla r2,r2,r3,r1
		cmp r12,#4
		addlt r12,r12,#1
		blt @@name_loop
@@too_big:
		mov r0,#1
		b ProcJumpAddress
@@false:
		mov r0,#0
		b ProcJumpAddress
@@true:
		mov r0,#0
		mov r1,r7
		push r2
		bl SetGameVar
		pop r2
		mov r0,r2
		bl IntToSpecies
		mov r1,r0
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x400
		sub r0,r0,#0xc8
		mov r2,#10
		bl StrNCpy
		mov r0,#2
		b ProcJumpAddress
		.pool
	.endarea
.close