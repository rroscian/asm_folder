; Rewrite IsSoundMove to add checks for Snarl and Disarming Voice
.nds
.open "arm9.bin", 0x2000000
.org 0x2013d5c
.area 0xb8
	ldrh r2, [r0, 4h]
	mov r0, #0
	and r0, r0, 0xff
	cmp r2, 0xd9
	moveq r0, #1
	cmp r2, 0x70
	moveq r0, #1
	cmp r2, 0x11c
	moveq r0, #1
	cmp r2, 0x53
	moveq r0, #1
	cmp r2, 0x22
	moveq r0, #1
	cmp r2, 0x54
	moveq r0, #1
	cmp r2, 0xab
	moveq r0, #1
	mov r1, 0x1A8
	cmp r2, r1
	moveq r0, #1
	cmp r2, 0x1b
	moveq r0, #1
	cmp r2, 0xf1
	moveq r0, #1
	cmp r2, 0x19
	moveq r0, #1
	cmp r2, 0x1a
	moveq r0, #1
	add r1, r1, #22 ; 446: Chatter
	cmp r2, r1
	moveq r0, #1
	add r1, r1, #84 ; 530: Bug Buzz
	cmp r2, r1
	moveq r0, #1
	add r1, r1, #25 ; 555: Disarming Voice
	cmp r2, r1
	moveq r0, #1
	bx lr
	.fill 0x02013D5C+0xB8-., 0xCC
.endarea
.close