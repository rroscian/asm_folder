; Mission floor not cleared warning
; pc=202764Ch
; 1438: mission ongoing
; 0x2349208: IsDestinationFloor
; ret: bool

.nds
.open "overlay_0029.bin", 0x22DC240
.org 0x22faf10
.area 0x4
	bl resetMissionCompleted
.endarea

.org 0x22F36AC
.area 0x4
	bne AddMissionWarning
.endarea

.org 0x234a560
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x2348ae8
.area 0x4
	bl SetMissionCompleted2 ; mov r2, #0
.endarea

.org 0x2348b80
.area 0x4
	bl SetMissionCompleted3 ; mov r1, #1
.endarea

.org 0x2349e5c
.area 0x4
	bl SetMissionCompleted4 ; mov r1, #0
.endarea

.org 0x2349d7c
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x2349de8
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x234a6f4
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x234a72c
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x234a7f0
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x234a884
.area 0x4
	bl SetMissionCompleted4 ; mov r1, #0
.endarea

.org 0x234a94c
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x234aa60
.area 0x4
	bl SetMissionCompleted4 ; mov r1, #0
.endarea

.org 0x234ab7c
.area 0x4
	bl SetMissionCompleted4 ; mov r1, #0
.endarea

.org 0x234abe8
.area 0x4
	bl SetMissionCompleted1 ; mov r0, #0
.endarea

.org 0x234acb4
.area 0x4
	bl SetMissionCompleted2 ; mov r2, #0
.endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x30200
.area 0x30300 - 0x30200

resetMissionCompleted:
	push r0, lr
	mov r6, r0
	mov r0, #0
	str r0, [isMissionCompleted]
	pop r0, pc

AddMissionWarning:
	strb r1, [r0,5h]
	push r0
	ldr r0, [isMissionCompleted]
	cmp r0, #1
	pop r0
	beq 0x22F36B0
	push r0-r3
	bl 0x2349208
	cmp r0, #1
    popne r0-r3
	bne 0x22F36B0
	mov r0, #0x7
	bl 0x234921c
	cmp r0, #0x0
	mov r0, #0x0
	mov r3, #0x1
    popne r0-r3
	bne return
    mov r2, r0
    ldr r1, =#1438
    str r0, [sp, #0x0]
    bl 0x234d518 ; Yes/No menu
    cmp r0, #1 ; If No
    movne r1, #0
    ldrne r0, =2353538h
    ldrne r0, [r0]
    strneb r1, [r0,5h]
    moveq r0, #0
    streq r0, [isMissionCompleted]
    pop r0-r3
    bne 0x22f36c8
return:
	b 0x22F36E4

SetMissionCompleted1:
	push lr
	mov r0, #0x0
	b missionIsCompleted
SetMissionCompleted2:
	push lr
	mov r2, #0x0
	b missionIsCompleted
SetMissionCompleted3:
	push lr
	mov r1, #0x1
	b missionIsCompleted
SetMissionCompleted4:
	push lr
	mov r1, #0x0
missionIsCompleted:
	push r0, r1
	mov r0, #1
	ldr r1, =isMissionCompleted
	strb r0, [r1]
	pop r0, r1
	pop pc
isMissionCompleted:
	.dcb 0x0
.align
.pool
.endarea
.close