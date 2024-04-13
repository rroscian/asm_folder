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
    mov r0, #0
    push r0, r2-r3
    add r0, r0, #0x120
    add r0, r0, #0x8
    ldrh r0, [r2, r0]
    bl 0x20151C8
    cmp r0, #2 ; Status Moves cannot evolve
    popeq r0, r2-r3
    ldreq r1,=fail_str
    beq message

    pop r0, r2-r3
    add r0, r0, #0x120
    add r0, r0, #0xb
    ldrb r1, [r2, r0]
    cmp r1, #99
    ldrne r1,=fail_str
    bne message
    mov r1, #255
    strb r1, [r2, r0]
    ldr r1,=use_str
        
    message:
        ; Always branch at the end
        mov r0,r8
        bl SendMessageWithStringLog ; Shows used
        b ItemJumpAddress
        .pool

    fail_str:
        .ascii "But it failed..."
        dcb 0

    use_str:
        .ascii "[string:0]'s first move has evolved again!"
        dcb 0

    .endarea
.close