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


        ldr  r1,[r8,#0xB4]
        ldrb r0,[r1,#0xBF]
        cmp  r0,#0x5
        ldreq r1, =fail_str
        mov r0,r8
        bl SendMessageWithStringLog ; Shows used

        mov r0, r8
        mov r1, r7
        bl 0x23061A8

    ; Always branch at the end
    end:
	    mov r0,r8
	    bl 0x22E3AB4
        b ItemJumpAddress
        .pool

    fail_str:
        .asciiz "But nothing happened."
    .endarea
.close