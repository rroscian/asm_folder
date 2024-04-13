;based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm Template 
.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0xCC4

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel ItemStartAddress, 0x0231BE50
.definelabel ItemJumpAddress, 0x0231CB14


; File creation
.create "./code_out.bin", 0x0231BE50 ; Change to the actual offset as this directive doesn't accept labels
    .org ItemStartAddress
    .area MaxSize ; Define the size of the area
	ldr   r1, =22C4420h
	ldr   r1, [r1, #0x10]
	mov   r0, r8
	ldrsh r2, [r1]
	mov   r1, r7
	bl    #0x2317f50
	ldr   r1, =22C4420h
	ldr   r1, [r1, #0x10]
	mov   r0, r8
	ldrsh r2, [r1]
	mov   r1, r7
	bl    #0x2317fe4
	ldr   r1, =22C4420h
	ldr   r1, [r1, #0x10]
	mov   r0, r8
	ldrsh r2, [r1]
	mov   r1, r7
	bl    #0x2318078
	ldr   r1, =22C4420h
	ldr   r1, [r1, #0x10]
	mov   r0, r8
	ldrsh r2, [r1]
	mov   r1, r7
	bl    #0x231810C
	b     ItemJumpAddress
    .pool
    .endarea
.close