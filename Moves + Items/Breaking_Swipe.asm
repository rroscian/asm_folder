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
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage

    cmp r0, #0x0
    moveq r10, #0
    beq end

    mov r10, #1

    mov r0, r4
    mov r1, #9
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r4
    mov r1, #15
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r4
    mov r1, #76
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r4
    mov r1, #116
    bl HasAbility
    cmp r0, #1
    beq end

    ldr r0, [r4, 0B4h]
    ldrh r0, [r0,#+0x68]
    cmp r0, 12h
    beq end

    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #100 ; argument #2 Effect Chance
    bl 0x2324934 ; DungeonRandOutcomeUserTargetInteraction
    cmp r0, #0
    beq end

    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl AttackStatDown
    
  end:
    add r13, r13, #0x8  
    
    b MoveJumpAddress
    .pool
  .endarea
.close
