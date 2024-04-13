.nds
.open "arm9.bin", 0x02000000
.org 0x204D7F8
; original instructions: 
; cmp r2, 0h
; strbne r1, [r0, 2h]
.area 0x8
	b CheckRandomizer
AfterSetPortrait:
	nop
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x35900
.area 0x35A00 - 0x35900

CheckRandomizer:
	push r3
	push r0
	ldr r3, =22AB496h
	ldrb r0, [r3]
	cmp r0, #255
	pop r0
	cmpne r2, 0h
	strneb r1, [r0, 2h]
	bne oldReturn
	push r2
	movs r2, -2
	cmp r1, r2
	pop r2
	streqb r1, [r0, 2h]
	movne r1, #0
	strneb r1, [r0, 2h]
oldReturn:
	pop r3
	b AfterSetPortrait
.pool
.endarea
.close