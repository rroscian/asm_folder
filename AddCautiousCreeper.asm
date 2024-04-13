
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x2307e54
	.area 0x4
		bl SneakHook
	.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2FD00
.area 0x2FD80 - 0x2FD00

SneakHook:
	push r14
	push r0,r1
	bl GetIQSkill
	pop r0,r1
	moveq r0,#1
	popeq r15
	bl 0x2307f1c ; HasItem
	pop r15
GetIQSkill:
	push r14
	mov r0, r9
	mov r1,#33
	bl 0x2301F80 ; IsIQSkillEnabled
	cmp r0,#1
	pop r15
.endarea
.close