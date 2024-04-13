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
.definelabel RankUpPointsTable, 0x020A2B48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
	; 0) 100000
	; 1) 250000
	; 2) 400000
	; 3) 600000
	; 4) 800000

	mov r1, r7 ; First Argument: Money Amount
	mov r0, #4
	mul r1, r0, r1
	ldr r3, =22A4BB8h ; Current Money
	ldr r2, =MoneyCostTable
	ldr r0, [r2, r1] ; r0 = Money cost
	ldr r1, [r3] ; r1 = Money amount
	cmp r0, r1
	movgt r0, #0
	bgt return
	suble r0, r1, r0 ; Substract money amount with cost
	strle r0, [r3]
	movle r0, #1

return:
	; Always branch at the end
	b 0x022E7AC0
	.pool
MoneyCostTable:
	.word 0x186A0
	.word 0x3D090
	.word 0x61A80
	.word 0x927C0
	.word 0xC3500
.endarea
.close