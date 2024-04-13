; ------------------------------------------------------------------------------
; Has Species in Party
; Checks if a given Pokémon species is in the specified team (0 is Maingame, 1 is Special Episode, 2 is Rescue, and -1 is the current team)!
; Param 1: team_id
; Param 2: species_id
; Returns: (The slot in which the species is found) + 1, or 0 if not found.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x810

; Uncomment/comment the following labels depending on your version.

; For US
.include "lib/stdlib_us.asm"
.definelabel ProcStartAddress, 0x022E7248
.definelabel ProcJumpAddress, 0x022E7AC0
.definelabel AssemblyPointer, 0x020B0A48

; For EU
;.include "lib/stdlib_eu.asm"
;.definelabel ProcStartAddress, 0x022E7B88
;.definelabel ProcJumpAddress, 0x022E8400
;.definelabel AssemblyPointer, 0x20B138C

; File creation
.create "./code_out.bin", 0x022E7248 ; For EU: 0x022E7B88
	.org ProcStartAddress
	.area MaxSize
		
		mov r0,#0
		cmp r7,#2
		bgt @@ret
		ldr r0,=AssemblyPointer
		ldr r0,[r0]
		cmp r7,#0
		addlt r0,r0,#0x9800
		addlt r0,r0,#0x4c
		ldrlt r0,[r0]
		addge r0,r0,#0x9300
    	addge r0,r0,#0x6C
		movge r1,#0x1A0
    	mlage r0,r7,r1,r0
		mov r1,#0x1
@@member_loop:
		mov r3, #256
		ldrb r2,[r0]
		tst r2,#0x1
		beq @@member_loop_next_iter
		ldrsh r2,[r0,#+0xC]
		cmp r2, 258h
		subge r2, r2, 258h
		cmp r2, #132 ; Ditto
		cmpne r2, #144 ; Articuno
		cmpne r2, #145 ; Zapdos
		cmpne r2, #146 ; Moltres
		cmpne r2, #149 ; Dragonite
		cmpne r2, #150 ; Mewtwo
		cmpne r2, #151 ; Mew
		cmpne r2, #221 ; Sneasler
		cmpne r2, #224 ; Annihilape
		cmpne r2, #226 ; Ursaluna
		cmpne r2, #228 ; Dusknoir-Alt
		addne r3, r3, 6h ; 262: Smeargle
		cmpne r2, r3
		addne r3, r3, 7h ; 269: Blissey
		cmpne r2, r3
		addne r3, r3, 1h ; 270: Raikou
		cmpne r2, r3
		addne r3, r3, 1h ; 271: Entei
		cmpne r2, r3
		addne r3, r3, 1h ; 272: Suicune
		cmpne r2, r3
		addne r3, r3, 3h ; 275: Tyranitar
		cmpne r2, r3
		addne r3, r3, 1h ; 276: Lugia
		cmpne r2, r3
		addne r3, r3, 1h ; 277: Ho-Oh
		cmpne r2, r3
		addne r3, r3, 1h ; 278: Celebi
		cmpne r2, r3
		addne r3, r3, 1h ; 279: Celebi-Alt
		cmpne r2, r3
		addne r3, r3, 26h ; 317: Slaking
		cmpne r2, r3
		addne r3, r3, 3Fh ; 380: Diancie
		cmpne r2, r3
		addne r3, r3, 1h ; 381: Marshadow
		cmpne r2, r3
		addne r3, r3, 1h ; 382: Eternatus
		cmpne r2, r3
		addne r3, r3, 1h ; 383: Kecleon
		cmpne r2, r3
		addne r3, r3, 1h ; 384: Kecleon
		cmpne r2, r3
		addne r3, r3, 19h ; 409: Regirock
		cmpne r2, r3
		addne r3, r3, 1h ; 410: Regice
		cmpne r2, r3
		addne r3, r3, 1h ; 411: Registeel
		cmpne r2, r3
		addne r3, r3, 1h ; 412: Latias
		cmpne r2, r3
		addne r3, r3, 1h ; 413: Latios
		cmpne r2, r3
		addne r3, r3, 1h ; 414: Kyogre
		cmpne r2, r3
		addne r3, r3, 1h ; 415: Groudon
		cmpne r2, r3
		addne r3, r3, 1h ; 416: Rayquaza
		cmpne r2, r3
		addne r3, r3, 1h ; 417: Jirachi
		cmpne r2, r3
		addne r3, r3, 1h ; 418: Deoxys-N
		cmpne r2, r3
		addne r3, r3, 1h ; 419: Deoxys-A
		cmpne r2, r3
		addne r3, r3, 1h ; 420: Deoxys-D
		cmpne r2, r3
		addne r3, r3, 1h ; 421: Deoxys-S
		cmpne r2, r3
		addne r3, r3, 2Fh ; 468: Drifblim
		cmpne r2, r3
		addne r3, r3, 13h ; 487: Garchomp
		cmpne r2, r3
		addne r3, r3, 10h ; 503: Dimoret
		cmpne r2, r3
		addne r3, r3, 13h ; 522: Uxie
		cmpne r2, r3
		addne r3, r3, 1h ; 523: Mesprit
		cmpne r2, r3
		addne r3, r3, 1h ; 524: Azelf
		cmpne r2, r3
		addne r3, r3, 1h ; 525: Dialga
		cmpne r2, r3
		addne r3, r3, 1h ; 526: Palkia
		cmpne r2, r3
		addne r3, r3, 1h ; 527: Heatran
		cmpne r2, r3
		addne r3, r3, 1h ; 528: Regigigas
		cmpne r2, r3
		addne r3, r3, 1h ; 529: Giratina-Alternate
		cmpne r2, r3
		addne r3, r3, 1h ; 530: Cresselia
		cmpne r2, r3
		addne r3, r3, 1h ; 531: Phione
		cmpne r2, r3
		addne r3, r3, 1h ; 532: Manaphy
		cmpne r2, r3
		addne r3, r3, 1h ; 533: Darkrai
		cmpne r2, r3
		addne r3, r3, 1h ; 534: Shaymin-Land
		cmpne r2, r3
		addne r3, r3, 1h ; 535: Shaymin-Sky
		cmpne r2, r3
		addne r3, r3, 1h ; 536: Giratina-Origin
		cmpne r2, r3
		addne r3, r3, 1h ; 537: Arceus
		cmpne r2, r3
		addne r3, r3, 1h ; 538: Regieleki
		cmpne r2, r3
		addne r3, r3, 1h ; 539: Regidrago
		cmpne r2, r3
		addne r3, r3, 4h ; 543: Grovyle-Alt
		cmpne r2, r3
		addne r3, r3, 5h ; 548: Genesect
		cmpne r2, r3
		addne r3, r3, 1h ; 549: Darkrai-Alt
		cmpne r2, r3
		addne r3, r3, 2h ; 551: Palkia-Primal
		cmpne r2, r3
		addne r3, r3, 1h ; 552: Dialga-Primal
		cmpne r2, r3
		moveq r0, #1
		beq @@ret
@@member_loop_next_iter:
		cmp r1,#4
		addlt r1,r1,#1
		addlt r0,r0,#0x68
		blt @@member_loop
		mov r0,#0
@@ret:
		b ProcJumpAddress
		.pool
	.endarea
.close