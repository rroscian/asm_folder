; ------------------------------------------------------------------------------
; StolenBurrito - 5/22/2023
; Reworks OHKO moves such that they do not
; work on bosses.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0xAC ; lines of code x 4 converted to hex

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"

.definelabel MoveJumpAddress, 0x023326CC

.create "./code_out.bin", 0x02330134
    .org 0x02330134
    .area MaxSize ; Define the size of the area

    ; check for boss
checkBoss:
    sub sp, sp, 18h
    ldr    r0,[r4,#0xB4]
    ldrb   r2, [r0,#0x100] ; Monster->boss_monster
    cmp    r2,#0x1
    beq    isBoss

notBoss:
    ; if not boss, deal calamitous damage
    mov r0, #0 ; argument #4 MoveId
    str r0, [r13, #+0x0]
    str r0, [r13, #+0x4]
    str r0, [r13, #+0x8]
    str r0, [r13, #+0xc]
    str r0, [r13, #+0x10]
    str r0, [r13, #+0x14]
    mov r0, r4 ; argument #0 Target
    ldr r1, =#9999 ; argument #1 Damage
    mov r2, #0 ; argument #2 UnkArg2
    mov r3, #0 ; argument #3 UnkArg3
    bl ConstDamage
    b exitMove

isBoss:
    mov   r0,#0
    mov   r1,r4
    mov   r2,#0
    bl    ChangeString
    ldr   r2,=immunity
    mov   r0,r4
    mov   r1,r4
    bl    SendMessageWithStringCheckUTLog
exitMove:
    add sp, sp, 18h
    b MoveJumpAddress

    .pool
    immunity:
        .asciiz "[string:0] was immune!"

    .endarea
.close