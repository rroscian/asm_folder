; ------------------------------------------------------------------------------
; Applies Frostbite for debugging purposes.
; ------------------------------------------------------------------------------

.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

; Uncomment the correct version

; For US
.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel CalcStatusDuration, 0x022EAB80
.definelabel GetApparentWeather, 0x02334D08

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C

; Universal
.definelabel TurnCountMinimum, 0x7F ; You two are gonna be frostbitten
.definelabel TurnCountMaximum, 0x7F ; forever! Yahoo! The strike worked!
.definelabel HailWeatherID, 0x5
.definelabel SnowWeatherID, 0x7

; File creation
.create "./code_out.bin", 0x02330134 ; Change to the actual offset as this directive doesn't accept labels
    .org MoveStartAddress
    .area MaxSize ; Define the size of the area
        push r5
        
	mov r0, r4
	mov r1, 0x41
	bl 0x2301D10 ; HasAbility
	cmp r0, #1
	beq frostbite_armor
        ldr  r5,[r4,#0xB4]
        ldrb r0,[r5,#0xBF]
        cmp  r0,#0x5
        beq  frostbite_already
        ldrb r0,[r5,#0xD5]
        cmp  r0,#0x2
        beq  frostbite_safeguard
        mov  r0, r4
        bl   0x22E1628 ; GetTileAtEntity
        ldrh r0,[r0,#0x0]
        and  r0,r0, #0x3
        cmp  r0, #2
        beq  frostbite_magma_terrain
        mov  r0, r4
        mov  r1, #6
        bl   0x2301E50 ; GetType
        cmp  r0,1h
        beq  frostbite_ice
        mov  r3,#0x5
        strb r3,[r5,#0xBF]
        mov  r0,r4
        mov  r1, 07Fh
        add  r1,r0,#0x1
        strb r1,[r5,#0xC0]
        mov  r0,#0x1
        mov  r1,r4
        mov  r2,#0x0
        strb r2,[r5,#0xC1]
        strb r2,[r5,#0xC2]
    	mov  r1, r4
    	mov  r0, #0x0
    	mov  r2, #0x0
        bl   ChangeString
        ldr  r2,=frostbite_str
        mov  r0,r4
        mov  r1,r4
        bl   SendMessageWithStringCheckUTLog
        b    unallocate_memory
  
frostbite_magma_terrain:
        mov  r0,#0x0
        mov  r1,r4
        mov  r2,#0x0
        bl   ChangeString
        ldr  r2,=frostbite_no_magma
        mov  r0,r4
        mov  r1,r4
        bl   SendMessageWithStringCheckUTLog   
        b    unallocate_memory   

frostbite_armor:
        mov  r0,#0x0
        mov  r1,r4
        mov  r2,#0x0
        bl   ChangeString
        ldr  r2,=frostbite_magma_armor
        mov  r0,r4
        mov  r1,r4
        bl   SendMessageWithStringCheckUTLog   
        b    unallocate_memory   

frostbite_ice:
        mov  r0,#0x0
        mov  r1,r4
        mov  r2,#0x0
        bl   ChangeString
        ldr  r2,=frostbite_ice_msg
        mov  r0,r4
        mov  r1,r4
        bl   SendMessageWithStringCheckUTLog
        b    unallocate_memory

frostbite_safeguard:
        mov  r0,#0x0
        mov  r1,r4
        mov  r2,#0x0
        bl   ChangeString
        ldr  r2,=frostbite_safeguard_msg
        mov  r0,r4
        mov  r1,r4
        bl   SendMessageWithStringCheckUTLog
        b    unallocate_memory

frostbite_already:
        mov  r0,#0x0
        mov  r1,r4
        mov  r2,#0x0
        bl   ChangeString
        ldr  r2,=frostbite_redundant_str
        mov  r0,r4
        mov  r1,r4
        bl   SendMessageWithStringCheckUTLog
        
    unallocate_memory:
        mov r10,#0x1
        pop r5
        b   MoveJumpAddress
        .pool
    frostbite_str:
        .asciiz "[string:0] got frostbite!"
    frostbite_redundant_str:
        .asciiz "[string:0] already has frostbite."
    frostbite_no_magma:
        .asciiz "The magma's heat prevents [string:0][R]from getting frostbite!"
    frostbite_safeguard_msg:
        .asciiz "[string:0] is protected by Safeguard!"
    frostbite_magma_armor:
        .asciiz "[string:0]'s Magma Armor prevents[R]frostbite!"
    frostbite_ice_msg:
        .asciiz "[string:0]'s type doesn't get frostbite!"
    FROSTBITE_TURN_RANGE:
        .halfword TurnCountMinimum
        .halfword TurnCountMaximum
    .endarea
.close