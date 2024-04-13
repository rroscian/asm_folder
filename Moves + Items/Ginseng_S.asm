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
    add r2, r2, #0x120
    push r0, r2-r3
    ldrh r0, [r2, 8h]
    bl 0x20151C8
    cmp r0, #2 ; Status Moves cannot evolve
    pop r0, r2-r3
    ldreq r1,=fail_str
    beq message
    mov r0, #99
    strb r0, [r2, 0Bh]
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
        .ascii "[string:0]'s first move has powered up!"
        dcb 0
    .endarea
.close