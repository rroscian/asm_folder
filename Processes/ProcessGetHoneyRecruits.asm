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
		mov r8, #0
		mov r0, #21 ; Spearow
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #102 ; Exeggcute
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #163 ; Hoothoot
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #165 ; Ledyba
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #177 ; Natu
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #190 ; Aipom
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #231 ; Pineco
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #241 ; Heracross
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#447 ; Burmy
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#448 ; Burmy
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#449 ; Burmy
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#454 ; Combee
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#459 ; Cherubi
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#488 ; Munchlax
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, r8 ; r0: Species count
		; max is 14
		; Always branch at the end
	end:
		b 0x022E7AC0
		.pool
	.endarea
.close