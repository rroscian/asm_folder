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
    sub r13, r13, #0x0  

    ; Code here
    

    ldr r2, [r8, #+0xb4] ; r2 = Pointer to the user's data
    ldrb r0, [r2, #+0xfb] ; r0 = Stairs detection value
    mov r1, #1

    strb r1, [r2, #+0xfb]

		mov r0,r8
		ldr r1,=use_str
		bl SendMessageWithStringLog ; Shows used
		b ItemJumpAddress
		.pool

	use_str:
		.ascii "[string:0] can now see Stairs!"
		dcb 0

  ; Variables and static arrays
  
  .endarea
.close
