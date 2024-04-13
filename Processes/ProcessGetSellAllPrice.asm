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
		push r3-r9
		ldr r8, =22AB49Ch
		mov r6, #0
		ldr r0, [r8] ; sum of prices
		mov r4, r6
		str r0, [r8]
		mov r5, #1
		mov r7, #6

	loop:
		ldr r0, [r8]
		mul r1, r6, r7
		ldr r0, [r0, 44h]
		ldr r2, [r0, 384h]
		ldrb r0, [r2, r1]
		add r9, r2, r1
		tst r0, #1
		movne r0, r5
		moveq r0, r4
		tst r0, #0xff
		beq nextIter
		ldrsh r0, [r9, 4h]
		bl 0x200cce0
		cmp r0, #0
		beq nextIter
		mov r0, r9
		bl 0x200d1a8
		ldr r1, [r8]
		add r0, r1, r0
		str r0, [r8]
		
	nextIter:
		add r6, r6, #1
		cmp r6, #0x32
		blt loop
		; Always branch at the end
	end:
		pop r3-r9
		b 0x022E7AC0
		.pool
	.endarea
.close