; 
; ------------------------------------------------------------------------------
; New Add Recruitable to Team
; Adds correctly a recruitable to storage team (a.k.a. Assembly), 
; and does not use the recruitable list.
; Param 1: pkmn_id
; Param 2: origin_id+pkmn_level*256 (NB: Hard to pass 3 parameters in 2 values)
; Returns: 1 if successfully added, otherwise 0
; ------------------------------------------------------------------------------


.relativeinclude on
.nds
.arm

; TODO: Currently only for the US

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7A80
;.definelabel ProcJumpAddress, 0x022E7B88


; File creation
.create "./code_out.bin", 0x022E7248 ; Change to the actual offset as this directive doesn't accept labels
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
		mov r0,#0x214
		bl 0x02055964
		mvn r1, #0
		cmp r0,r1
		moveq r0,#0
		beq ProcJumpAddress
		stmdb r13!, {r4}
		sub r13,r13,#0x10
		bl 0x020555A8
		mov r4,r0
		mov r1,r7
		mov r0,r13
		strh r1,[r4, #+0x4]
		mov r2,#1
		strb r2,[r4, #+0x0]
		mov r2,#0
		strh r2,[r4, #+0x6]
		bl 0x02052394
		mov  r1,r13
		add  r0,r4,#0x3A
		mov  r2,#0xA
		bl 0x02025314
		mov  r0,r4
		bl 0x02052EFC
		and r2,r6,#0xFF
		strh r2,[r4, #+0x2]
		mov  r0,r4
		mov  r1,r6,lsr #0x8
		and r1,r1,#0x7F
		mov  r2,#0x0
		bl 0x020544C8
		add r13,r13,#0x10
		ldmia r13!, {r4}
		mov r0,#1
		b ProcJumpAddress
		.pool
	.endarea
.close
