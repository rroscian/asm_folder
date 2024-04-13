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
.create "./Power_Split.bin", 0x2330134
  .org MoveStartAddress
  .area MaxSize ; Define the size of the area
    sub r13, r13, #0x0  
	
   	ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	ldrb r0, [r2, #+0x1a] ; r0 = Target's Attack
	strb r0, [r2, #+0x1a]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	ldrb r1, [r2, #+0x1a] ; r1 = User's Attack
	strb r1, [r2, #+0x1a]
    
    add r0, r0, r1
	mov r1, #2 ; argument #1 Divisor
    bl EuclidianDivision
    ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	strb r0, [r2, #+0x1a]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	strb r0, [r2, #+0x1a]

	   	ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	ldrb r0, [r2, #+0x1b] ; r0 = Target's Sp.Attack
	strb r0, [r2, #+0x1b]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	ldrb r1, [r2, #+0x1b] ; r1 = User's Sp.Attack
	strb r1, [r2, #+0x1b]
    
    add r0, r0, r1
	mov r1, #2 ; argument #1 Divisor
    bl EuclidianDivision
    ldr r2, [r4, #+0xb4] ; r2 = Pointer to the target's data
	strb r0, [r2, #+0x1b]
	ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
	strb r0, [r2, #+0x1b]
    
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
		.ascii "Averaged its Atk. and Sp. Atk with [string:1]!"
		dcb 0
  .endarea
.close
