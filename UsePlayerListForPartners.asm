.nds
.open "overlay_0013.bin", 0x238a140
.definelabel PlayersListPkmnID, 0x238C0B8

.org 0x238B8F0
.area 0x4
	mov r0, 20h
.endarea

.org 0x238B8FC
.area 0x4
	ldr r11, =PlayersListPkmnID
.endarea

.org 0x238B910
.area 0x4
	mov r1, 20h
.endarea

.org 0x238B974
.area 0x4
	cmp r7, 20h
.endarea
.close