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
    mov r1, #55
    bl HasAbility
    cmp r0, #1
    beq end

    ; Code here
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage
    cmp r0, #0x0
    beq end

    mov r0, r4
    mov r1, #15
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r4
    mov r1, #24
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r4
    mov r1, #76
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #10 ; argument #2 Chance
    bl RandomChanceUT
    
    mov r1, #1 ; Input 2
    cmp r0, r1
    bne branch_S_false
    
    ; condition true
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #1 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl DefenseStatDown

    branch_S_false:
    
  end:
    add r13, r13, #0x8  
    
    b MoveJumpAddress
    .pool
  .endarea
.close
