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
    sub r13, r13, #0x8  

    mov r0, r4
    mov r1, #15
    bl HasAbility
    cmp r0, #1
    beq FailMsg

    mov r0, r4
    mov r1, #24
    bl HasAbility
    cmp r0, #1
    beq FailMsg

    mov r0, r4
    mov r1, #76
    bl HasAbility
    cmp r0, #1
    beq FailMsg

    mov r0, r4
    mov r1, #116
    bl HasAbility
    cmp r0, #1
    beq FailMsg

    ldr r0, [r4, 0B4h]
    ldrh r0, [r0,#+0x68]
    cmp r0, 12h
    beq MsgBand

    ; Code here
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #3 ; argument #3 NbStages
    bl AttackStatDown
    mov r10, #1
    b end

FailMsg:
    mov  r1, r4
    mov  r0, #0x0
    mov  r2, #0x0
    bl 0x022E2AD8
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#3694 ; It had no effect on...
    bl 0x234B350  
    b end

MsgBand:
    mov  r1, r4
    mov  r0, #0x0
    mov  r2, #0x0
    bl 0x022E2AD8
    mov r0, r9 ; User
    mov r1, r4
    ldr r2, =#3503 ; It had no effect on...
    bl 0x234B350  
    
  end:
    add r13, r13, #0x8  
    
    b JumpAddress
    .pool

  ; Variables and static arrays
  
  .endarea
.close
