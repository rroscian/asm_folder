; Template based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm
.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel StartAddress, 0x2330134
.definelabel JumpAddress, 0x23326cc

; File creation
.create "./code_out.bin", 0x2330134
  .org StartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x4  

    ; Code here
    mov r0,r9
    mov r1,r9
    mov r2,8h
    bl 0x231FC20
    
    push r5
    mov r5, #0
Wait10Frames:
    bl 0x22E9FE0
    add r5, r5, #1
    cmp r5, #10
    blt Wait10Frames
    pop r5
    
    ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
    ldrh r0, [r2, #+0x10]
    ldr r1, =uservariable_0
    str r0, [r1]

    mov r0, #0 ; argument #4 ItemId
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage
    mov r10, r0
    mov r3, r0 ; Store damage dealt
    str r3, [damage_dealt]

    mov r0, r9
    mov r1, #7
    bl HasAbility
    cmp r0, #1
    beq end
  
    mov r0, r9
    mov r1, #73
    bl HasAbility
    cmp r0, #1
    beq end

    mov r0, r3 ; Load damage dealt
  
    ldr r10, =uservariable_0
    ldr r10, [r10]
    cmp r0, r10
    blt b_false

    ;if true

    mov r0, r10
    bl b_false

    b_false:
    mov r1, #5
    bl EuclidianDivision
    mov r1, r0 ; argument #1 Damage
    mov r0, #0 ; argument #4 MoveId
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, #0 ; argument #6 UnkArg6
    str r0, [r13, #+0x8]
    mov r0, #4 ; argument #7 MessageType
    str r0, [r13, #+0xc]
    mov r0, #0 ; argument #8 UnkArg8
    str r0, [r13, #+0x10]
    mov r0, #0 ; argument #9 UnkArg9
    str r0, [r13, #+0x14]
    mov r0, r9 ; argument #0 Target
    mov r2, #0 ; argument #2 UnkArg2
    mov r3, #0 ; argument #3 UnkArg3
    bl ConstDamage

    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #10 ; argument #2 Effect Chance
    bl 0x2324934 ; DungeonRandOutcomeUserTargetInteraction
    cmp r0, #0
    beq end
    
    
  end:
    ldr r10, [damage_dealt]
    mov r0, r10
    add r13, r13, #0x4  
    
    b JumpAddress
    .pool

  ; Variables and static arrays
    uservariable_0:
      dcd 256
    damage_dealt:
      dcd 0

  .endarea
.close
