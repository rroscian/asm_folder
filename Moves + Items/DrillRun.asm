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
    
    mov r0, #0 ; argument #4 ItemId
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage
    
  end:
    mov r10, #1
    b JumpAddress
    .pool

  ; Variables and static arrays
  
  .endarea
.close
