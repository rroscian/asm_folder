; Template based on https://github.com/irdkwia/eos-move-effects/blob/master/template.asm
.relativeinclude on
.nds
.arm

.definelabel MaxSize, 0x2598

.include "lib/stdlib_us.asm"
.include "lib/dunlib_us.asm"
.definelabel StartAddress, 0x2330134
.definelabel JumpAddress, 0x23326cc
.definelabel MoveStartAddress, 0x02330134
.definelabel MoveJumpAddress, 0x023326CC
.definelabel WaitOneFrame, 0x022E9FE0

; File creation
.create "./code_out.bin", 0x2330134
  .org StartAddress
  .area MaxSize ; Define the size of the area

    ; Code here
    ldr r2, =22AB0D0h
    ldrb r2, [r2]
    ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
    ldrh r0, [r2, #+0x2]
    ldr r1, =#548
    cmp r0, r1
    movne r3, #0x100
    bne Damage

    push r5-r7, r12, r10, sp
    mov r5, #0 ; Counter
    ldr r6, =FireEffectiveness
    ldr r7, =TypeIDs
LoopCheckMatchups:
    ; Type you want to check in r12
    ldrb r12, [r7, r5]

    mov r0, r9
    mov r1, r4
    mov r2, #0
    mov r3, r12
    bl 0x230AC58 ; GetTypeMatchup

    mov r3, r12
    mov r12, r0

    mov r0, r9
    mov r1, r4
    mov r2, #1
    bl 0x230AC58

    ldr r10,=22C4D14h ; Load dual effectiveness address in r10
    add r10,r10,r12,lsl 4h ; Address of the row of the table
    ldr r0,[r10,r0,lsl 2h] ; Final effectiveness in r0, was ldr
    strb r0, [r6, r5]

nextIterCheckMatchups:
    cmp r5, #5
    addlt r5, r5, #1
    blt LoopCheckMatchups

    ldr r3, =TypeIDs
    mov r5, #0
    ldr r6, =FireEffectiveness
LoopDecideCorrectType:
    ldrb r0, [r6, r5]
    ldr r1, =CurrentMaxEffectiveness
    ldrb r1, [r1]
    cmp r0, r1
    ldrge r1, =CurrentMaxEffectiveness
    strgeb r0, [r1]
    ldrgeb r1, [r3, r5] ; Type ID
    ldr r0, =TypeToUse
    strgeb r1, [r0]
nextIterDecideCorrectType:
    cmp r5, #5
    addlt r5, r5, #1
    blt LoopDecideCorrectType
    ldr r0, =TypeToUse
    ldrb r0, [r0]
    ldr r1, =20a6004h ; Type of the Move
    strb r0, [r1]
    pop r5-r7, r12, r10, sp
    ldr r0, =TypeToUse
    ldrb r0, [r0]
    ldr r1, =FlashDrive
    cmp r0, #1
    ldreq r1,=NormalDrive
    cmp r0, #2
    ldreq r1,=BurnDrive
    cmp r0, #3
    ldreq r1,=DouseDrive
    cmp r0, #5
    ldreq r1,=ShockDrive
    cmp r0, #6
    ldreq r1,=ChillDrive
    cmp r0, #11
    ldreq r1,=FlashDrive
WriteString:
    mov r0, r9
    bl SendMessageWithStringLog
    mov r3,#0x150

Damage: 
    mov r0,r9
    mov r1,r4
    mov r2,r8
    bl DealDamage
    mov r10, r0
    
    b MoveJumpAddress
    .pool

    NormalDrive:
        .asciiz "It booted up the Basic Drive!"
    BurnDrive:
        .asciiz "It booted up the [CS:B]Burn Drive[CR]!"
    DouseDrive:
        .asciiz "It booted up the [CS:Q]Douse Drive[CR]!"
    ShockDrive:
        .asciiz "It booted up the [CS:C]Shock Drive[CR]!"
    ChillDrive:
        .asciiz "It booted up the [CS:G]Chill Drive[CR]!"
    FlashDrive:
        .asciiz "It booted up the [CS:S]Flash Drive[CR]!"

    NormalEffectiveness:
        .dcb 0x0
    FireEffectiveness:
        .dcb 0x0
    WaterEffectiveness:
        .dcb 0x0
    ElectrEffectiveness:
        .dcb 0x0
    IceEffectiveness:
        .dcb 0x0
    SteelEffectiveness:
        .dcb 0x0
    TypeIDs:
        .dcb 0x1 ; Normal
        .dcb 0x2 ; Fire
        .dcb 0x3 ; Water
        .dcb 0x5 ; Electric
        .dcb 0x6 ; Ice
        .dcb 0x11 ; Steel
    TypeToUse:
        .dcb 0x11 ; Defaults to Steel
    CurrentMaxEffectiveness:
        .dcb 0x0 ; Defaults to ineffective
        .dcb 0xFF
        .dcb 0xFF
    .endarea
.close