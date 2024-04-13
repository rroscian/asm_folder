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
    ldr r1, =#999     

    strh r1, [r2, #+0x10]
    strh r1, [r2, #+0x12]
        
        ; Always branch at the end
        mov r0,r8
        ldr r1,=use_str
        bl SendMessageWithStringLog ; Shows used
        b ItemJumpAddress
        .pool

    use_str:
        .ascii "[string:0]'s HP rose!"
        dcb 0
    .endarea
.close