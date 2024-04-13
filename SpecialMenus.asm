; All NA offsets
; Flexible system allowing to bypass the menu limits by adding input bounds

.nds
.open "arm9.bin", 0x2000000

; ======================================================
; Handles the menu text of the keyboard
; ======================================================
    .org 0x20368cc
    .area 0x4
        b TextTag1 ; For Team Menu, 1
    .endarea

; ======================================================
; Handles the character display of a keyboard
; ======================================================
    .org 0x02037E44
    .area 0x4
        b CheckMenu1 ; For Team Menu, 1
    .endarea

; ======================================================
; Handles the character functionality of a keyboard
; ======================================================
    .org 0x020387E8
    .area 0x4
        b CheckMenu2 ; For Team Menu, 1
    .endarea

; ======================================================
; Handles the menu response
; ======================================================
    .org 0x20393f8
    .area 0x4
        b TextTag2 ; For Team Menu, 1
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x2DDC0
.area 0x2DF00 - 0x2DDC0

; Sets the text string dynamically
TextTag1:
    cmp r3, #1
    addne r3, r3, 118h ; +280
    bne 0x20368d0
    push r3
    ldr r3, =0x22AB47C ; Set by a special process
    ldrb r3, [r3]
    cmp r3, #0
    popeq r3
    addeq r3, r3, 118h
    beq 0x20368d0
    cmp r3, #2
    pop r3
    add r3, r3, 128h ; +296
    beq 0x20368d0
    add r3, r3, 2h
    b 0x20368d0

CheckMenu1:
    cmp r0, #0x9
    beq 0x2037E4C
    cmp r0, #0x1
    bne 0x2037E84
    ldr r1, =0x22AB47C
    ldrb r1, [r1]
    cmp r1, #0
    beq 0x2037E84
    cmp r1, #2
    beq PasswordMenu2
; A to Z
    cmp r5,#0x41
    bcc 0x2037e5c
    cmp r5,#0x5A
    bls 0x2037e84
    b 0x2037e5c

; 0 to 9
PasswordMenu2:
    cmp r5,#0x30
    bcc 0x2037e5c
    cmp r5,#0x39
    bls 0x2037e84
    b 0x2037e5c

CheckMenu2:
    cmp r0, #0x9
    beq 0x20387F0
    cmp r0, #0x1
    bne 0x2038810
    ldr r2, =0x22AB47C
    ldrb r2, [r2]
    cmp r2, #0
    beq 0x2038810
    and r0, r4, #0xff
    cmp r2, #1
    beq PasswordMenu1
; 0 to 9
    cmp r0,#0x30
    bcc 0x2038804
    cmp r0,#0x39
    bls 0x2038810
    b 0x2038804

; A to Z
PasswordMenu1:
    cmp r0,#0x41
    bcc 0x2038804
    cmp r0,#0x5A
    bls 0x2038810
    b 0x2038804

; Sets the text response dynamically
TextTag2:
    mov r2, 124h
    push r3
    ldr r3, =0x22AB47C
    ldrb r3, [r3]
    cmp r3, #0
    popeq r3
    beq 0x20393fc
    cmp r3, #2
    add r2, r2, #4
    pop r3
    beq 0x20393fc
    add r2, r2, 2h
    b 0x20393fc

.pool
.endarea
.close