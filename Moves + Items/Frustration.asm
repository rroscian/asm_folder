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
    
    ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data

    ldrh r0, [r2, #+0xe]
    mov r2, r0
    mov r3, #1024
    subs r0, r3, r2
    mov r1, #2
    bl EuclidianDivision
    ldr r1, =uservariable_0
    str r0, [r1]

    ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
    ldrh r0, [r2, 68h]
    cmp r0, 0Bh
    beq FixedFrustration
    ; Code here
    mov r0, #0 ; argument #4 ItemId
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    ldr r10, =uservariable_0
    ldrh r10, [r10]
    mov r3, r10 ; argument #3 DamageMultiplier
    bl DealDamage
    mov r10, r0
    b end

  FixedFrustration:
    ldr r10, =uservariable_0
    ldrh r0, [r10]
    mov r1, #2
    bl EuclidianDivision
    mov r10, r0
    mov r1, r10
    mov r0, #0 ; argument #4 MoveId
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, #0 ; argument #6 UnkArg6
    str r0, [r13, #+0x8]
    mov r0, #0 ; argument #7 MessageType
    str r0, [r13, #+0xc]
    mov r0, #0 ; argument #8 UnkArg8
    str r0, [r13, #+0x10]
    mov r0, #0 ; argument #9 UnkArg9
    str r0, [r13, #+0x14]
    mov r0, r4 ; argument #0 Target
    mov r2, #0 ; argument #2 UnkArg2
    mov r3, #0 ; argument #3 UnkArg3
    bl ConstDamage
    mov r10, r0
    
  end:
    add r13, r13, #0x4  
    
    b JumpAddress
    .pool

  ; Variables and static arrays
  uservariable_0:
    dcd 256

  .endarea
.close
