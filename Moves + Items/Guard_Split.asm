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
.create "./Guard_Split.bin", 0x2330134
  .org MoveStartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x0  
	
   	ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	ldrb r0, [r2, #+0x1c] ; r0 = Target's Defense
	strb r0, [r2, #+0x1c]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	ldrb r1, [r2, #+0x1c] ; r1 = User's Defense
	strb r1, [r2, #+0x1c]
    
    add r0, r0, r1
	mov r1, #2 ; argument #1 Divisor
    bl EuclidianDivision
    ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	strb r0, [r2, #+0x1c]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	strb r0, [r2, #+0x1c]

	   	ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	ldrb r0, [r2, #+0x1d] ; r0 = Target's Sp.Defense
	strb r0, [r2, #+0x1d]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	ldrb r1, [r2, #+0x1d] ; r1 = User's Sp.Defense
	strb r1, [r2, #+0x1d]
    
    add r0, r0, r1
	mov r1, #2 ; argument #1 Divisor
    bl EuclidianDivision
    ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	strb r0, [r2, #+0x1d]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	strb r0, [r2, #+0x1d]
    
    mov r0,#0x1
    mov r1,r4
    mov r2,#0x0
    bl ChangeString ;
    mov r0,r9
    ldr r1,=average
    bl SendMessageWithStringLog
    
  end:
    add r13, r13, #0x0  
    
    b MoveJumpAddress
    .pool
	average: 
		.ascii "Averaged its Def. and Sp. Def with [string:1]!"
		dcb 0
  .endarea
.close
