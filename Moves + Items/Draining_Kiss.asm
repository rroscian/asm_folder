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
    sub r13, r13, #0x4  

    ; Code here
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage
    
    mov r1, #3
    mul r0, r0, r1
    mov r2, r0, lsr 2h ; argument #2 HPHeal
    mov r0, #1 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r9 ; argument #1 Target
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP
    
    
  end:
    add r13, r13, #0x4  
    
    b MoveJumpAddress
    .pool
  .endarea
.close
