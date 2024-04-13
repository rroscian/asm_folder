
.nds
.open "overlay_0011.bin", 0x22DC240
.definelabel NoRPress, 0x022eab58
.definelabel NoLPress, 0x022eab5c
.definelabel AfterRPress, 0x022eab84

	; Ov11
	.org NoRPress
	.area 0x4
	    b Hook
	.endarea
.close


.open "overlay_0036.bin", 0x23A7080
	.orga 0x2F9E0
	.area 0x20
	; Ov36
	Hook:
	    tst r0,#0x200 ; Check for L
	    ldreq r0,[r9,#0x8]
	    beq NoLPress
	    mov r0,#0x13
	    str r0,[r8]
	    b AfterRPress
	.endarea
.close