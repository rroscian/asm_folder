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
.create "./Morning_Sun.bin", 0x2330134
  .org MoveStartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x4  

    ; Code here
    mov r0,r4 ;Move target to r0
	bl 0x02334d08
    
    mov r1, #1 ; Input 2
    cmp r0, r1
    bne branch_0_false
    
    ; condition true
    ldr r0, [r4, #+0xb4]
	ldrsh r1, [r0, #+0x12]
	ldrsh r0, [r0, #+0x16]
	add r0, r0, r1 ; Compute the user's Max HP
	mov r1, #3
	bl EuclidianDivision ; Divide by 3
	cmp r1, #0
	addne r0, r0, #1 ; Round to upper bound
    mov r2, r0 ; argument #2 HPHeal
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP
    b branch_0_end
    
    branch_0_false: ; condition false
    mov r1, #0 ; Input 2
    cmp r0, r1
    bne branch_1_false
    
    ; condition true
    ldr r0, [r4, #+0xb4]
	ldrsh r1, [r0, #+0x12]
	ldrsh r0, [r0, #+0x16]
	add r0, r0, r1 ; Compute the user's Max HP
	mov r1, #6
	bl EuclidianDivision ; Divide by 6
	cmp r1, #0
	addne r0, r0, #1 ; Round to upper bound
    mov r2, r0 ; argument #2 HPHeal
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP
    b branch_1_end

    
    branch_1_false: ; condition false
    ldr r0, [r4, #+0xb4]
	ldrsh r1, [r0, #+0x12]
	ldrsh r0, [r0, #+0x16]
	add r0, r0, r1 ; Compute the user's Max HP
	mov r1, #12
	bl EuclidianDivision ; Divide by 12
	cmp r1, #0
	addne r0, r0, #1 ; Round to upper bound
    mov r2, r0 ; argument #2 HPHeal
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r3, #0 ; argument #3 MaxHpRaise
    bl RaiseHP
    
    branch_1_end:
    
    branch_0_end:
    
  end:
    add r13, r13, #0x4  
    
    b MoveJumpAddress
    .pool
  .endarea
.close
