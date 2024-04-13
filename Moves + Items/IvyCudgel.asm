; Template based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm
.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC

; File creation
.create "./code_out.bin", 0x2330134
  .org MoveStartAddress
  .area MaxSize ; Define the size of the area

    ; Code here
    ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
    ldrb r0, [r2, 05Fh]
    cmp r0, #0
    ldreqb r0, [r2, 05Eh]

    ldr r1, =20a6004h ; Type of the Move
    strb r0, [r1]
Damage: 
    mov r0,r9
    mov r1,r4
    mov r2,r8
    mov r3,#256
    bl DealDamage
    mov r10, r0
    
    b MoveJumpAddress
.pool
.endarea
.close