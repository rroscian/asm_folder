;based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm Template 
.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0xCC4

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel ItemStartAddress, 0x0231BE50
.definelabel ItemJumpAddress, 0x0231CB14


; File creation
.create "./code_out.bin", 0x0231BE50 ; Change to the actual offset as this directive doesn't accept labels
    .org ItemStartAddress
    .area MaxSize ; Define the size of the area

    ldr r2, [r7, #+0xb4] ; r2 = Pointer to the user's data

    ldrb r1, [r2, #+0x1a]
    cmp r1, #255
    beq b_3
    cmp r1, #254
    beq b_3
    add r1,r1,#2
    strb r1, [r2, #+0x1a]
    
    b_3:
    ldrb r1, [r2, #+0x1b]
    cmp r1, #255
    beq b_4
    cmp r1, #254
    beq b_4
    add r1,r1,#2
    strb r1, [r2, #+0x1b]
    
    b_4:
    ldrb r1, [r2, #+0x1c]
    cmp r1, #255
    beq b_5
    cmp r1, #254
    beq b_5
    add r1,r1,#2
    strb r1, [r2, #+0x1c]
    
    b_5:
    ldrb r1, [r2, #+0x1d] 
    cmp r1, #255
    beq b_6
    cmp r1, #254
    beq b_6
    add r1,r1,#2
    strb r1, [r2, #+0x1d] 
    
    b_6:
        
        ; Always branch at the end
        mov r0,r8
        ldr r1,=use_str
        bl SendMessageWithStringLog ; Shows used
        b ItemJumpAddress
        .pool

    use_str:
        .ascii "[string:0]'s stats rose!"
        dcb 0
    .endarea
.close