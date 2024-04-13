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
.create "./Life_Dew.bin", 0x2330134
  .org MoveStartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x4 
    
    mov r0,r4 ;Move target to r0
	bl 0x02334d08
    
    mov r1, #4 ; Input 1
    cmp r0, r1
    bne branch_0_false
    
    ; condition true
	ldr r0, [r4, #+0xb4]
	ldrsh r1, [r0, #+0x12]
	ldrsh r0, [r0, #+0x16]
	add r0, r0, r1 ; Compute the target's Max HP
	mov r1, #2
	bl EuclidianDivision ; Divide by 2
    
    b branch_0_end
    
	branch_0_false: ; condition false
	ldr r0, [r4, #+0xb4]
	ldrsh r1, [r0, #+0x12]
	ldrsh r0, [r0, #+0x16]
	add r0, r0, r1 ; Compute the target's Max HP
	mov r1, #4
	bl EuclidianDivision ; Divide by 4
    
    branch_0_end:
    
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
    .pool
  .endarea
.close
