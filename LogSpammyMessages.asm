; Rewrites spammed log messages
.nds
.open "overlay_0029.bin", 0x22DC240

	.org 0x2308508
	.area 0x4
		bl 0x234B31C ; Show in log and no pop-up
	.endarea

	.org 0x23085b0
	.area 0x4
		bl 0x234B31C ; Show in log and no pop-up
	.endarea

	.org 0x23090f4
	.area 0x4
		bl 0x234B3F0 ; Show in log and no pop-up
	.endarea

	.org 0x2309178
	.area 0x4
		bl 0x234B31C ; Show in log and no pop-up
	.endarea
.close