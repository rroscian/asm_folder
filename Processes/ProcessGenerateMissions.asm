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
		bl 0x205E5D0
		; Always branch at the end
		b 0x022E7AC0
		.pool
	.endarea
.close