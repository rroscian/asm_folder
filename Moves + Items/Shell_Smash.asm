; ------------------------------------------------------------------------------
; Jawshoeuh 11/12/2022 - Confirmed Working 1/6/2023
; Shell Smashes raises the User's Attack, Special Attack and Speed by 2 but
; also lowers the User's Defense and Special Defense by 1.
; Based on the template provided by https://github.com/SkyTemple
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

; For EU
;.include "lib/stdlib_eu.asm"
;.include "lib/dunlib_eu.asm"
;.definelabel MoveStartAddress, 0x02330B74
;.definelabel MoveJumpAddress, 0x0233310C

; File creation
.create "./code_out.bin", 0x02330134 ; Change to the actual offset as this directive doesn't accept labels
    .org MoveStartAddress
    .area MaxSize ; Define the size of the area
        sub sp,sp,#0x8
        
        ; Raise attack.
        mov r0, r9
        mov r1, r9
        mov r2, #0
        mov r3, #2 ; 2 stages
        bl AttackStatUp
        
        ; Raise special attack.
        mov r0, r9
        mov r1, r9
        mov r2, #1
        mov r3, #2 ; 2 stages
        bl AttackStatUp
        
        ; Lower defense.
    
        mov r0, #0 ; argument #4 UnkArg4
        str r0, [r13, #+0x0]
        mov r0, #0 ; argument #5 UnkArg5
        str r0, [r13, #+0x4]
        mov r0, r9 ; argument #0 User
        mov r1, r9 ; argument #1 Target
        mov r2, #0 ; argument #2 StatType
        mov r3, #1 ; argument #3 NbStages
        bl DefenseStatDown
        
        mov r0, #0 ; argument #4 UnkArg4
        str r0, [r13, #+0x0]
        mov r0, #0 ; argument #5 UnkArg5
        str r0, [r13, #+0x4]
        mov r0, r9 ; argument #0 User
        mov r1, r9 ; argument #1 Target
        mov r2, #1 ; argument #2 StatType
        mov r3, #1 ; argument #3 NbStages
        bl DefenseStatDown
        
        ; Raise speed two stages.
        mov r0, r9
        mov r1, r4
        mov r2, #0
        mov r3, #1
        bl SpeedStatUpOneStage

        mov r10,#1
        add sp,sp,#0x8
        b MoveJumpAddress
        .pool
    .endarea
.close