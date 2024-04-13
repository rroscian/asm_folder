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
    mov r0,r4 ;Move target to r0
	bl 0x02334d08
    str r0, [Weather]
    
    ldr r0, [r4, #+0xb4]
    ldrsh r1, [r0, #+0x12]
    ldrsh r0, [r0, #+0x16]
    add r0, r0, r1 ; Compute the user's Max HP
    mov r1, #3
    bl EuclidianDivision ; Divide by 3
    cmp r1, #0
    addne r0, r0, #1 ; Round to upper bound
    ldr r1, [Weather]
    cmp r1, #0 ; Check Clear Weather
    moveq r0, r0, lsr 1h
    beq Heal
    cmp r1, #1
    movne r0, r0, lsr 2h

Heal:
    mov r2, r0 ; argument #2 HPHeal
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP
    
  end:
    add r13, r13, #0x4
    b MoveJumpAddress

Weather:
    .word 0x0

.pool
.endarea
.close
