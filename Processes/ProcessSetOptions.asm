.relativeinclude on
.nds
.arm

; Uncomment/comment the following labels depending on your version.

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
; Setting Key:
; 0 - Touch Screen
; 3 - Grids
; 5 - Far-off pals
; 6 - Damage turn
; 7 - DPad attack
; 8 - Check direction
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		sub r0,r0,#0xd00
		sub r0,r0,#0x40
		; 1 - Bottom Screen
		mov r6, #0
		mov r7, #1
		strb r6,[r0,r7]
		; 2 - Top Screen
		mov r6, #3
		mov r7, #2
		strb r6,[r0,r7]
		; 4 - Speed
		mov r6, #2
		mov r7, #4
		strb r6,[r0,r7]
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close