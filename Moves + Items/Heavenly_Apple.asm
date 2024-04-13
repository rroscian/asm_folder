; Template based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm
.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0xcc4

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel StartAddress, 0x231be50
.definelabel JumpAddress, 0x231cb14

; File creation
.create "./code_out.bin", 0x231be50
  .org StartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x4  

    ; Code here
    mov r0, r8 ; argument #0 User
    mov r1, r7 ; argument #1 Target
    mov r2, #99 ; argument #2 PPHeal
    mov r3, #0 ; argument #3 NoMessage
    bl HealAllMovesPP
    
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r8 ; argument #0 User
    mov r1, r7 ; argument #1 Target
    ldr r2, =#999 ; argument #2 HPHeal
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP

    ldr r2, [r7, #+0xb4] ; r2 = Pointer to the user's data

    
        ; Always branch at the end
        mov r0,r8
        ldr r1,=use_str
        bl SendMessageWithStringLog ; Shows used
    
  end:
    add r13, r13, #0x4  
    
    b JumpAddress
    .pool

  ; Variables and static arrays
      use_str:
        .ascii "[CS:E]HP[CR], [CS:I]Belly[CR], and [CS:E]PP[CR] were completely restored!"
        dcb 0

  .endarea
.close
