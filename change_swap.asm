.nds

.open "arm9.bin", 0x02000000
	; This allow a 19th type (including None) to be selected from swap
	.org 0x02012BD8
	.area 0x4
		cmp r1,#0x13
	.endarea
	.org 0x02012E70
	.area 0x4
		cmp r5,#0x13
	.endarea
	.org 0x02012EB4
	.area 0x4
		cmp r9,#0x13
	.endarea

	; Rewrite pointer to filename
	.org 0x02012B30
	.area 0x4
		.word 0x02098CBC
	.endarea

	; Rewrite pointer to debug string
	.org 0x020130A0
	.area 0x4
		.word 0x02098CD4
	.endarea

	; Add 4 entries to the table for Fairy type
	.org 0x02098CB4
	.area 0x8
		.dcw 0 ; item 0
		.dcw 0 ; item 1
		.dcw 0 ; item 2
		.dcw 0 ; item 3
	.endarea

	; Shift filename by 8 bytes
	.org 0x02098CBC
	.area 0x18
		.ascii "rom0:SYNTH/synth.bin"
		.word 0
	.endarea

	; Shift debug string by 8 bytes
	.org 0x02098CD4
	.area 0x14
		.ascii "Synthesis_Update ==="
	.endarea
.close
