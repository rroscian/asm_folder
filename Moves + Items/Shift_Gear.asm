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

    ; Code here
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl AttackStatUp
    
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #2 ; argument #2 NbStages
    mov r3, #5 ; argument #3 NbTurns
    bl SpeedStatUp
    
    
  end:
    add r13, r13, #0x8  
    mov r10, #1
    b MoveJumpAddress
    .pool
  .endarea
.close
