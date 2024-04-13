.nds
.arm
; Implements an invalid location system

.open "overlay_0001.bin", 0x02329520
	.org 0x0233134C
	.area 0x4
		bl WonderMail
	.endarea
.close

.open "overlay_0036.bin", 0x023A7080
	.org 0x023A7080+0x31100
	.area 0x100

WonderMail:
	push {r0, r2, r3, lr}
	ldr  r0, =219h ; Arceus
	mov  r1, #1
	bl   #0x2055148
	mov  r1, r0
	pop  {r0, r2, r3, pc}
.pool
.endarea
.close
