; Template based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm
.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x2330134
.definelabel MoveJumpAddress, 0x23326cc

; File creation
.create "./code_out.bin", 0x2330134
  .org MoveStartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x8  

    mov r0, r4
    mov r1, #60
    bl HasAbility
    cmp r0, #1
    beq Soundproof

    ; Code here
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage
    mov r10, r0
    b ApplySleepless

  Soundproof:
    mov r0, 1h
    mov r1, r4
    mov r2, 0h
    bl ChangeString
    mov r0,r9
    mov r1,r4
    ldr r2,=0EB9h
    bl SendMessageWithIDCheckUTLog

  ApplySleepless:
    mov r0, r9
    mov r1, r4
    bl Sleepless

    mov r0, r9
    mov r1, r9
    bl Sleepless

  end:
    add r13, r13, #0x8  
    
    b MoveJumpAddress
    .pool

  .endarea
.close
