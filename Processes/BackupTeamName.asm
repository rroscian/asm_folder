; ------------------------------------------------------------------------------
; Check Team Name
; Checks if the team name is equal to a predefined name!
; Returns: 0 if unequal, 1 if equal.
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
		ldr r1,=TeamName
@@loop_init:
		mov r2,#0
@@comparison_loop:
		cmp r2,#10
		beq @@return
		ldrb r3, [r0, r2]
		strb r3, [r1, r2]
		add r2,r2,#1
		b @@comparison_loop
@@return:
		b ProcJumpAddress
		.pool
	.endarea
.close