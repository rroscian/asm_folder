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
    sub r13, r13, #0x8  
	
    mov r0,r9
	ldr r1,=draw
	bl SendMessageWithStringLog
    
    ; Code here
    mov r0, r9 ; argument #0 User
    mov r1, #75 ; argument #1 Chance
    bl RandomChanceU
    
    mov r1, #1 ; Input 2
    cmp r0, r1
    bne branch_0_false
    
    ; condition true
    mov r0, r9 ; argument #0 User
    mov r1, #66 ; argument #1 Chance
    bl RandomChanceU
    
    mov r1, #1 ; Input 2
    cmp r0, r1
    bne branch_1_false
    
    ; condition true
    mov r0, r9 ; argument #0 User
    mov r1, #50 ; argument #1 Chance
    bl RandomChanceU
    
    mov r1, #1 ; Input 2
    cmp r0, r1
    bne branch_2_false
    
    ; condition true
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #1 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl DefenseStatUp
    
    b branch_2_end
    
    branch_2_false: ; condition false
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #1 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl AttackStatUp
    
    
    branch_2_end:
    b branch_1_end
    
    branch_1_false: ; condition false
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl DefenseStatUp
    
    
    branch_1_end:
    b branch_0_end
    
    branch_0_false: ; condition false
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl AttackStatUp
    
    
    branch_0_end:
    mov r0, r9 ; argument #0 User
    mov r1, #1 ; argument #1 Chance
    bl RandomChanceU
    
    mov r1, #1 ; Input 2
    cmp r0, r1
    bne branch_3_false
    
    ; condition true
    mov r0,r9
	ldr r1,=luckydraw
	bl SendMessageWithStringLog
    
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl AttackStatUp
    
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #0 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl DefenseStatUp
    
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #1 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl AttackStatUp
    
    mov r0, #0 ; argument #4 UnkArg4
    str r0, [r13, #+0x0]
    mov r0, #0 ; argument #5 UnkArg5
    str r0, [r13, #+0x4]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #1 ; argument #2 StatType
    mov r3, #1 ; argument #3 NbStages
    bl DefenseStatUp
    
    mov r0, #0 ; argument #4 FailMessage
    str r0, [r13, #+0x0]
    mov r0, r9 ; argument #0 User
    mov r1, r4 ; argument #1 Target
    mov r2, #1 ; argument #2 NbStages
    mov r3, #10 ; argument #3 NbTurns
    bl SpeedStatUp
    
    b branch_3_end
    
    branch_3_false: ; condition false
    
    branch_3_end:
    
  end:
    add r13, r13, #0x8  
    b MoveJumpAddress
    .pool
    
 	draw: 
		.ascii "[string:0] is drawing..."
		dcb 0
    
    luckydraw: 
		.ascii "It's your lucky day! Woo-hoo!"
		dcb 0
 
  .endarea
.close
