; Template based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm
.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel StartAddress, 0x2330134
.definelabel JumpAddress, 0x23326cc
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel WaitOneFrame, 0x022E9FE0

; File creation
.create "./code_out.bin", 0x2330134
  .org StartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x4  

    ; Code here
   	ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	ldr r0, [r2, #+0x110] ; r0 = Target's Speed Level
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	ldr r1, [r2, #+0x110] ; r1 = User's Speed Level
    
    cmp r0, r1
    movle r3, #256
    movgt r3, #512
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    bl DealDamage
    mov r10, r0
    
  end:
    add r13, r13, #0x4  
    
    b MoveJumpAddress
    .pool
  .endarea
.close
