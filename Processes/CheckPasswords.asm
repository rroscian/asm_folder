; ------------------------------------------------------------------------------
; Check Team Name
; Checks if the team name is equal to a list of names!
; Returns: 0 if unequal, the value it was equal to in the list if any occurence.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48
.definelabel TeamName, 0x022AB470

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x400
		sub r0,r0,#0xc8
		mov r8, #0 ; Loop counter
		ldr r1,=new_name_list
		sub r13,r13,#8
		str r0,[r13, #8]
@@loop_check_pw:
		mov r2,#0
@@comparison_loop:
		cmp r2,#10
		beq @@true
		str r1,[r13, #4] ; Current Name
		ldr r3, [r13, #8]
		ldrb r0,[r3, r2]
		ldr r3,[r13, #4]
		ldrb r3,[r3, r2]
		cmp r3, #32
		cmpeq r0, #0
		beq @@ProcessLoop
		cmp r0,r3
		bne @@false
		cmp r0,#0
		beq @@true
@@ProcessLoop:
		add r2,r2,#1
		b @@comparison_loop
@@false:
		mov r0,#0
		cmp r8,#2 ; nb of passwords
		addlt r8,r8,#1
		addlt r1, r1, #11 ; next name (10 char + padding)
		blt @@loop_check_pw
		b @@resetTeamName
@@true:
		add r0,r8,#1

@@resetTeamName:
		push r0
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0x400
		sub r0,r0,#0xc8
		ldr r1,=TeamName
@@loop_restore:
		mov r2,#0
@@restore_loop:
		cmp r2,#10
		beq @@ret
		ldrb r3, [r1, r2]
		strb r3, [r0, r2]
		add r2,r2,#1
		b @@restore_loop
@@ret:
		pop r0
		add r13,r13,#8
		b ProcJumpAddress
		.pool
	new_name_list: ; List of passwords
		.ascii "VAPOREON  ",0
		.ascii "BACKROOM  ",0
	.endarea
.close