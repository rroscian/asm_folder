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
        mov r0, r4
        bl 0x23D7880
        mov r10, r0
        b   MoveJumpAddress
        .pool
    .endarea
.close