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

ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
ldrb r0, [r2, #+0x1c] ; r0 = User's defense
ldrb r1, [r2, #+0x1a] ; r1 = User's attack

; Swap both values
strb r0, [r2, #+0x1a]
strb r1, [r2, #+0x1c]
    
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, r8 ; argument #2 MoveData
    mov r3, #256 ; argument #3 DamageMultiplier
    bl DealDamage
    
ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
ldrb r0, [r2, #+0x1c] ; r0 = User's defense
ldrb r1, [r2, #+0x1a] ; r1 = User's attack

; Swap both values
strb r0, [r2, #+0x1a]
strb r1, [r2, #+0x1c]
    
  end:
    add r13, r13, #0x4  
    
    b MoveJumpAddress
    .pool
  .endarea
.close
