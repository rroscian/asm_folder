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
		ldr r4, =0x22AB492
	    ldrb r0, [r4] ; state of the Wigglytuff reward
	    ldr r5, =0x22AB493
	    ldrb r1, [r5] ; Current Legendary reward
	    cmp r1, #0
	    moveq r0, #0
	    streqb r0, [r4]
	    beq end
	    cmp r0, r1
	    movge r0, #0
	    bge end
	    addne r0, #1
	    strneb r0, [r4]
		; Always branch at the end
	end:
		b 0x022E7AC0
		.pool
	.endarea
.close