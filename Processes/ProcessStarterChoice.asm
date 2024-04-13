; 
; ------------------------------------------------------------------------------
; A template to code your own special process effects
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org 0x022E7248
	.area MaxSize ; Define the size of the area
		push r2
		mov r0, r7 ; First Argument: 0 for the starter list, 1 for the partner list
		mov r1, r6 ; Second Argument: 0 for Alpha, 1 for Reverie, 2 for Heaven, 15 for Randomizer
		ldr r4, =0x22AB494
		ldrb r2, [r4, 2h] ; Check type list
		cmp r0, #0 ; If starter list
		streqb r1, [r4, 2h] ; store second argument
		movne r0, 10h
		mulne r0, r0, r1 ; else multiply second argument by 16
		addne r0, r2, r0
		strneb r0, [r4, 2h] ; store second argument
		pop r2
		; Always branch at the end
		b 0x022E7AC0
		.pool
	.endarea
.close