.nds
.open "overlay_0013.bin", 0x238a140
; 0x238c0b8: start of the list of starters
; 0x238c08c: start of the list of partners
.org 0x238D4B8
.area 0x4
	b SelectStarterList
.endarea

; 238D344

.org 0x238B8F0
.area 0x4
	mov r0, 20h
.endarea

.org 0x238B8FC
.area 0x4
	b SelectPartnerList
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

.open "overlay_0036.bin", 0x23A7080
.orga 0x31800
.area 0x32000 - 0x31800

GetCorrectListPointer:
	push lr
	ldr r0, =0x22AB490
	ldr r0, [r0]
	pop pc

SelectPartnerList:
	ldr r11, =0x22AB497
	mov r2, #255
	strb r2, [r11]

SelectStarterList:
	push r0, r1, r3, r4, lr
	ldr r3, =0x22AB496
	ldrb r0, [r3]
	ldr r4, =0x22AB497
	ldrb r4, [r4]
	cmp r4, #255
	beq LoopGetRawPartnerValue

LoopGetRawStarterValue:
	cmp r0, #16
	blt GetCorrectList
	sub r0, r0, #16
	b LoopGetRawStarterValue

LoopGetRawPartnerValue:
	mov r1, #16
	bl 0x0208FEA4

GetCorrectList:
	cmp r0, #0
	ldreq r2, =AlphaList
	beq return
	cmp r0, #1
	ldreq r2, =ReverieList
	beq return
	cmp r0, #2
	ldreq r2, =HellList
	beq return
	cmp r0, #3
	ldreq r2, =RealityList
	beq return
	cmp r0, #4
	ldreq r2, =LegacyList
	beq return
	cmp r0, #5
	ldreq r2, =SpecialList
	beq return
	cmp r0, #15
	beq StarterRandomizer
	mov r0, #1
	ldr r3, =238D344h
	strb r0, [r3] ; Set Showed Portrait to Happy for Leader
	ldr r3, =238D3C8h
	strb r0, [r3] ; Set Showed Portrait to Happy for Leader validation
	ldr r3, =238BB4Ch
	strb r0, [r3] ; Set Showed Portrait to Happy for Partner
	ldr r3, =238BC28h
	strb r0, [r3] ; Set Showed Portrait to Happy for Partner validation
	b return

StarterRandomizer:
	ldr r2, =0x22AB494
	mov r4, #255
	strb r4, [r2] ; Set a flag in the save to FF for the randomizer check later on
	mov r4, #0
	ldr r2, =238D344h
	strb r4, [r2] ; Set Showed Portrait to Neutral for Leader
	ldr r2, =238D3C8h
	strb r4, [r2] ; Set Showed Portrait to Neutral for Leader validation
	ldr r2, =238BB4Ch
	strb r4, [r2] ; Set Showed Portrait to Neutral for Partner
	ldr r2, =238BC28h
	strb r4, [r2] ; Set Showed Portrait to Neutral for Partner validation
	ldr r2, =RandomList
	ldrh r0, [r2]
	cmp r0, #0
	bne return
GetValidRandomSpecies:
	ldr r0, =#1153
    bl 0x20022F8 ; Overworld RNG
    cmp r0, #0
    beq GetValidRandomSpecies
    ldr r1, =#553
    cmp r0, r1
    blt StoreRandomSpecies
    ldr r1, =#600
    cmp r0, r1
    bgt StoreRandomSpecies
    b GetValidRandomSpecies
StoreRandomSpecies:
	ldr r2, =RandomList
	strh r0, [r2, r4]
	add r4, r4, #2
	cmp r4, #64
	blt GetValidRandomSpecies

return:
	ldr r3, =0x22AB490
	ldr r0, [r3]
	cmp r0, #0
	streq r2, [r3]
	ldreq r3, =0x238b530
	streq r2, [r3]
	pop r0, r1, r3
	ldr r4, =0x22AB497
	ldrb r4, [r4]
	cmp r4, #255
	pop r4
	moveq r11, r2
	popeq lr
	beq 0x238B900
	popne lr
	bne 0x238D4BC
	.pool
	AlphaList:
		.dcw 0x011B  ; Torchic
		.dcw 0x0370  ; Treecko (F)
		.dcw 0x0004  ; Charmander
		.dcw 0x0259  ; Bulbasaur (F)
		.dcw 0x0019  ; Pikachu
		.dcw 0x025C  ; Charmander (F)
		.dcw 0x009E  ; Totodile
		.dcw 0x02DD  ; Eevee (F)
		.dcw 0x01AC  ; Piplup
		.dcw 0x0401  ; Chimchar (F)
		.dcw 0x01A9  ; Chimchar
		.dcw 0x03A0  ; Skitty (F)
		.dcw 0x009B  ; Cyndaquil
		.dcw 0x03FE  ; Turtwig (F)
		.dcw 0x01B6  ; Shinx
		.dcw 0x0478  ; Vulpix-A (F)
		.dcw 0x01E9  ; Riolu
		.dcw 0x02F6  ; Totodile (F)
		.dcw 0x0098  ; Chikorita
		.dcw 0x02F3  ; Cyndaquil (F)
		.dcw 0x0102  ; Phanpy
		.dcw 0x027D  ; Vulpix-K (F)
		.dcw 0x0001  ; Bulbasaur
		.dcw 0x0376  ; Mudkip (F)
		.dcw 0x0007  ; Squirtle
		.dcw 0x0404  ; Piplup (F)
		.dcw 0x0118  ; Treecko
		.dcw 0x02F0  ; Chikorita (F)
		.dcw 0x011E  ; Mudkip
		.dcw 0x0373  ; Torchic (F)
		.dcw 0x01A6  ; Turtwig
		.dcw 0x025F  ; Squirtle (F)

	ReverieList:
		.dcw 0x0121  ; Poochyena
		.dcw 0x0407  ; Starly (F)
		.dcw 0x00B3  ; Mareep
		.dcw 0x034B  ; Teddiursa (F)
		.dcw 0x01C8  ; Pachirisu
		.dcw 0x043D  ; Gible (F)
		.dcw 0x003A  ; Growlithe
		.dcw 0x02A7  ; Slowpoke (F)
		.dcw 0x01D5  ; Buneary
		.dcw 0x029A  ; Machop (F)
		.dcw 0x01D9  ; Glameow
		.dcw 0x0420  ; Pachirisu (F)
		.dcw 0x004F  ; Slowpoke
		.dcw 0x015E  ; Numel (F)
		.dcw 0x0151  ; Electrike
		.dcw 0x02A5  ; Ponyta (F)
		.dcw 0x0042  ; Machop
		.dcw 0x0431  ; Glameow (F)
		.dcw 0x003F  ; Abra
		.dcw 0x038C  ; Ralts (F)
		.dcw 0x00F3  ; Teddiursa
		.dcw 0x0273  ; Sandshrew (F)
		.dcw 0x015E  ; Numel
		.dcw 0x0379  ; Poochyena (F)
		.dcw 0x01E5  ; Gible
		.dcw 0x0297  ; Abra (F)
		.dcw 0x0134  ; Ralts
		.dcw 0x030B  ; Mareep (F)
		.dcw 0x01AF  ; Starly
		.dcw 0x03A9  ; Electrike (F)
		.dcw 0x001B  ; Sandshrew
		.dcw 0x0307  ; Togepi (F)

	HellList:
		.dcw 0x007B  ; Scyther
		.dcw 0x0362  ; Elekid (F)
		.dcw 0x01C9  ; Buizel
		.dcw 0x0363  ; Magby (F)
		.dcw 0x00BE  ; Aipom
		.dcw 0x0413  ; Cranidos (F)
		.dcw 0x0038  ; Mankey
		.dcw 0x0109  ; Smoochum (F)
		.dcw 0x00F2  ; Sneasel
		.dcw 0x02CC  ; Horsea (F)
		.dcw 0x0164  ; Trapinch
		.dcw 0x0421  ; Buizel (F)
		.dcw 0x010B  ; Magby
		.dcw 0x03B0  ; Gulpin (F)
		.dcw 0x010A  ; Elekid
		.dcw 0x02D3  ; Scyther (F)
		.dcw 0x01B9  ; Budew
		.dcw 0x0316  ; Aipom (F)
		.dcw 0x0068  ; Cubone
		.dcw 0x0427  ; H-Zorua (F)
		.dcw 0x0074  ; Horsea
		.dcw 0x02C0  ; Cubone (F)
		.dcw 0x01BB  ; Cranidos
		.dcw 0x03EB  ; Bagon (F)
		.dcw 0x01CF  ; H-Zorua
		.dcw 0x03BC  ; Trapinch (F)
		.dcw 0x0107  ; Tyrogue
		.dcw 0x0411  ; Budew (F)
		.dcw 0x0158  ; Gulpin
		.dcw 0x034A  ; Sneasel (F)
		.dcw 0x0193  ; Bagon
		.dcw 0x0290  ; Mankey (F)

	RealityList:
		.dcw 0x00AA  ; Chinchou
		.dcw 0x0388  ; Taillow (F)
		.dcw 0x0036  ; Psyduck
		.dcw 0x0309  ; Natu (F)
		.dcw 0x014C  ; Aron
		.dcw 0x028C  ; Meowth (F)
		.dcw 0x0130  ; Taillow
		.dcw 0x02F9  ; Sentret (F)
		.dcw 0x0034  ; Meowth
		.dcw 0x03E1  ; Snorunt (F)
		.dcw 0x01ED  ; Skorupi
		.dcw 0x028E  ; Psyduck (F)
		.dcw 0x00A5  ; Ledyba
		.dcw 0x03E3  ; Spheal (F)
		.dcw 0x00C6  ; Murkrow (M only)
		.dcw 0x0302  ; Chinchou (F)
		.dcw 0x00FF  ; Houndour
		.dcw 0x03A4  ; Aron (F)
		.dcw 0x0093  ; Dratini
		.dcw 0x03C1  ; Swablu (F only)
		.dcw 0x00B1  ; Natu
		.dcw 0x0391  ; Shroomish (F)
		.dcw 0x0189  ; Snorunt
		.dcw 0x0423  ; Cherubi (F only)
		.dcw 0x018B  ; Spheal
		.dcw 0x02EB  ; Dratini (F)
		.dcw 0x00A1  ; Sentret
		.dcw 0x02FD  ; Ledyba (F)
		.dcw 0x03BF  ; Cacnea (M only)
		.dcw 0x0357  ; Houndour (F)
		.dcw 0x0139  ; Shroomish
		.dcw 0x0445  ; Skorupi (F)

	LegacyList:
		.dcw 0x00EA  ; Gligar
		.dcw 0x027B  ; Clefairy (F)
		.dcw 0x00C2  ; Wooper
		.dcw 0x0326  ; A-Meowth (F)
		.dcw 0x00CA  ; Rattata-A
		.dcw 0x0434  ; Stunky (F)
		.dcw 0x00D2  ; H-Growlithe (M only)
		.dcw 0x01E2  ; Happiny (F only)
		.dcw 0x00DC  ; H-Sneasel
		.dcw 0x044A  ; Finneon (F)
		.dcw 0x00BF  ; Sunkern
		.dcw 0x031A  ; Wooper (F)
		.dcw 0x00CE  ; A-Meowth
		.dcw 0x0440  ; Munchlax (F)
		.dcw 0x0023  ; Clefairy
		.dcw 0x0342  ; Gligar (F)
		.dcw 0x01E0  ; Bonsly
		.dcw 0x0322  ; Rattata-A (F)
		.dcw 0x00CC  ; A-Sandshrew
		.dcw 0x0336  ; U-Zorua (F)
		.dcw 0x01F2  ; Finneon
		.dcw 0x0324  ; A-Sandshrew (F)
		.dcw 0x01DC  ; Stunky
		.dcw 0x026B  ; Rattata (F)
		.dcw 0x00DE  ; U-Zorua
		.dcw 0x0317  ; Sunkern (F)
		.dcw 0x01E1  ; Mime Jr. (M only)
		.dcw 0x0438  ; Bonsly (F)
		.dcw 0x01E8  ; Munchlax
		.dcw 0x0334  ; H-Sneasel (F)
		.dcw 0x0013  ; Rattata
		.dcw 0x032C  ; G-Ponyta (F only)

	SpecialList:
		.dcw 0x000B  ; Metapod
		.dcw 0x0266  ; Kakuna (F)
		.dcw 0x0081  ; Magikarp (M only)
		.dcw 0x03D1  ; Feebas (F only)
		.dcw 0x0084  ; Ditto
		.dcw 0x035E  ; Smeargle
		.dcw 0x0126  ; Cascoon
		.dcw 0x037E  ; Silcoon
		.dcw 0x0163  ; Spinda
		.dcw 0x03E0  ; Wynaut
		.dcw 0x01C6  ; Combee (M only)
		.dcw 0x03D8  ; Kecleon-Purple (F only)
		.dcw 0x0196  ; Beldum
		.dcw 0x040C  ; Kricketot
		.dcw 0x01BF  ; Burmy-Sand
		.dcw 0x0418  ; Burmy-Leaf
		.dcw 0x01C1  ; Burmy-Trash
		.dcw 0x0263  ; Metapod
		.dcw 0x000E  ; Kakuna
		.dcw 0x0084  ; Ditto
		.dcw 0x0106  ; Smeargle
		.dcw 0x0380  ; Cascoon
		.dcw 0x0128  ; Silcoon
		.dcw 0x03BB  ; Spinda
		.dcw 0x0188  ; Wynaut
		.dcw 0x0196  ; Beldum
		.dcw 0x01B4  ; Kricketot
		.dcw 0x0417  ; Burmy-Sand
		.dcw 0x01C0  ; Burmy-Leaf
		.dcw 0x0419  ; Burmy-Trash
		.dcw 0x0192  ; Luvdisc
		.dcw 0x03EA  ; Luvdisc (F)

	RandomList:
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000
		.dcw 0x0000

.endarea
.close