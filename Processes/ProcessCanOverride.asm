.relativeinclude on
.nds
.arm

; Uncomment/comment the following labels depending on your version.

.definelabel MaxSize, 0x810

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48
.definelabel RankUpPointsTable, 0x020A2B48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x020B138C


; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize ; Define the size of the area
	; 0) Gold: Exclusive Items/Wonder Chest/Miracle Chest/Exp. Elite Upgrade (22C458C: Exclusive, 22C4698: Miracle, 22C469C: Wonder, 22C44A8: Exp Elite)
	; 1) Diamond: Oran Berries Upgrades for Money (HP Boost: 22C44F4 + Recovery: 22C45EC)
	; 2) Emerald: Ammo Upgrades for Money (22C46B4: Geo Pebble, 22C46B8: Gravelerock, 22C46BC: Rare Fossil)
	; 3) Expert: Bands Upgrades for Money (20A186C, 20A187C, 20A18A8, 20A18AC, 20A18B4)
	; 4) Master: Vitamin Upgrades for Money (22C4420, 22C46C8, 22C46CC, 22C46C4)
	; 5) Perfect: Life Seeds/Sitrus Berries Upgrades for Money (HP Boost: Life Seed: 22C44F8 + Sitrus Berry: 22C45F4)
	; 6) Alpha: Gummies Stat Boosts Upgrades for Money (20A1888)
	; 7) Exp Share
	; Gold Upgrade: Lv6 = x2 Exp Boost (1.6, 1.7, 1.8, 1.9, 2.0)
	; Diamond Upgrade: Lv6 = 5x Recovery (+50 -> +250 / +200 -> +1000)
	; Emerald Upgrade: Lv6 = 3x damage (1.5, 2.0, 2.5, 3.0)
	; Expert Upgrade: Lv6 = 5x Boost (+8 -> +40)
	; Master Upgrade: Lv6 = +5 Boost (+3 -> +8)
	; Alpha Upgrade: Lv6 = 5x Boost (+5 -> +25)
	mov r1, #0
	mov r2, #0
LoopGetMaxedUpgrades:
	ldr r3, =22AB0C8h
	ldrb r0, [r3, r1] ; r0 = Upgrade level de la catégorie r1
	cmp r0, #5
	addge r2, r2, #1
nextIterLoopGetMaxUpgrades:
	cmp r1, #7
	addlt r1, r1, #1
	blt LoopGetMaxedUpgrades
	mov r0, r2

return:
	; Always branch at the end
	b 0x022E7AC0
	.pool
.endarea
.close