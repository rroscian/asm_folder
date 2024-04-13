.nds
.open "overlay_0029.bin", 0x22DC240
;.definelabel SendMessageWithStringLog, 0x0234B4BC
;.definelabel fn_CheckProgressList, 204B678h
;.definelabel fn_EndTurn, 22ebd10h

    .org 0x230269c
    .area 0x4
        bl ExpBoosts
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x31700
.area 0x31800 - 0x31700

ExpBoosts:
	push r0, r1, r3-r5, lr
	push r2
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x14 ; Graduation
    bl 0x204B678
	pop r2
    cmp r0, 1h
    addeq r2, r2, r2, lsl 2h ; x5/4
    lsreq r2, 2h
    ldr r0, =2353538h
    ldr r0, [r0]
    ldrb r0,[r0,748h]
; Island of Salvation Exp Boost
    cmp r0, #0
    addeq r2, r2, r2
    cmp r0, #71
    addeq r2, r2, r2
    pop r0, r1, r3-r5, lr
    add r1, r1, r2
    bx r14

    .pool
    .endarea
.close