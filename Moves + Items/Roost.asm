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
    ; condition true
    ldr r0, [r9, #+0xb4]
    ldrsh r1, [r0, #+0x12]
    ldrsh r0, [r0, #+0x16]
    add r0, r0, r1 ; Compute the user's Max HP
    add r0, r0, r0
    mov r1, #5
    bl EuclidianDivision ; Divide by 5
    cmp r1, #0
    addne r0, r0, #1 ; Round to upper bound

    mov r2, r0 ; argument #2 HPHeal
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP

    ldr r2, [r9, #+0xb4]
    mov r1, #1
    strb r1, [r2, #+0xA9]
    mov r1, #2
    strb r1, [r2, #+0xAA]
    mov r1, #10
    strb r1, [r2, #+0xAB]

    mov r0,#0
    mov r1,r9
    mov r2,#0
    bl ChangeString

    mov r0, r9 ; User
    mov r1, r9
    ldr r2, =#3273
    bl 0x234B350
    
  end:
    mov r10, #1
    b MoveJumpAddress
    .pool

  .endarea
.close
