; 
; ------------------------------------------------------------------------------
; A template to code your own special process effects
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm


.definelabel MaxSize, 0x810

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org 0x022E7248
	.area MaxSize ; Define the size of the area
		mov r8, #0
		mov r0, #144
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #145
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #146
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #150
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, #151
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#270
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#271
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#272
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#276
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#277
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#278
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#279
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#280
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#409
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#410
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#411
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#412
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#413
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#414
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#415
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#416
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#417
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#418
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#521
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#522
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#523
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#524
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#525
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#526
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#527
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#528
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#529
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#530
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#531
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#532
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#533
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#534
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#537
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#538
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#539
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#548
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#549
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#551
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#552
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#543
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		ldr r0, =#228
		mov r1, #0
		bl 0x2055148
		add r8, r8, r0
		mov r0, r8 ; r0: Legendary Count
		ldr r8, =0x22AB493
		ldr r1, [r8]
		cmp r1, r0
		strltb r0, [r8]
		movge r0, #0
		cmp r1, #0
		streqb r0, [r8]
		; Always branch at the end
	end:
		b 0x022E7AC0
		.pool
	.endarea
.close