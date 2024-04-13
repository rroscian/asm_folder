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
    sub r13, r13, #0x0  

    ; Code here
    ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
    ldrb r0, [r2, #+0x60]
    mov r1, #116 ; Input 2
    cmp r0, r1
    bne branch_0_true
    beq branch_0_false
    
    branch_0_true:
        mov r2, r0
        mov r0,r13
        ldr r1,=fail
        bl SPrintF
            
        mov r0, r9
        mov r1, r13
        bl SendMessageWithStringLog

        b MoveJumpAddress


    ; condition true
    branch_0_false:
      ; Hides map
        mov r0,6h
        mov r1,0h
        bl 0x022EA428
        mov r0,0h
        bl 0x0233A248
        mov  r0,#0x42
        bl WaitOneFrame
        mov  r0,#0x42
        bl WaitOneFrame
        
        ; Store some values
        stmdb r13!, {r5,r6}
        sub r13,r13,#0x64
        
        ; Print menu string

        mov r0,r13
        ldr r1,=menu_str
        bl SPrintF
        mov r0, r9
        mov r1, r13
        bl SendMessageWithStringLog

        ; Setup menu
        mov  r0,#18 ; # of options
        str r0,[r13, #+0x0]
        mov  r0,#6 ; # of options per page
        str r0,[r13, #+0x4]
        ldr r0,=menu_layout ; pointer to the menu layout
        ldr r1,=0x00001011 ; flags (1 bit per flag, see flags section)
        mov  r2,#0x0 ; NULL
        ldr r3,=func_menu ; pointer to the function
        bl 0x0202BA20 ; create menu
        mov r5,r0 ; store menu id to r5
        
        ; Menu loop
    wait_loop:
        mov  r0,#0x42
        bl WaitOneFrame        
        mov r0,#0xF0
        ldr r1,=0x023537CC
        ldr r1,[r1,#+0x4]
        add r1,r1,#0xC90
        str r0,[r1]
        
        mov r0,r5
        bl 0x0202BCDC ; each frame, we check if the menu was terminated
        cmp r0,#0
        bne wait_loop
        
        ; End menu
        mov r0,r5
        bl 0x0202BD10 ; get menu answer
        mov r6,r0        
        mov r0,5h
        mov r1,0h
        bl 0x022EA428
        mov r0,6h
        mov r1,0h
        bl 0x022EA428
        
        mov r0,r5
        bl 0x0202BC44 ; close menu
        
        mov  r0,#0x42
        bl WaitOneFrame
        mov  r0,#0x42
        bl WaitOneFrame
        
        ;Show Map
        mov r0,0h
        mov r1,r0
        bl 0x022EA428
        
        ; Print menu answer
        add r6,r6,#1 ;type_id
        
        ; Only for debugging
        ;mov r0,r13
        ;mov r2, r6
        ;ldr r1,=str_res
        ;bl SPrintF
        
        ;mov r0, r9
        ;mov r1, r13
        ;bl SendMessageWithStringLog
        ; End debug

        ldr r2, [r9, #+0xb4] ; r2 = Pointer to the user's data
        strb r6, [r2, #+0x5e]
        mov r0,#1
        strb r0, [r2, #+0xff]
        ; restore the stack, r5 and r6 at the end
        add r13,r13,#0x64
        ldmia r13!, {r5,r6}

        ldr r0, [r9, #+0xb4]
        ldrsh r1, [r0, #+0x12]
        ldrsh r0, [r0, #+0x16]
        add r0, r0, r1 ; Compute the user's Max HP
        cmp r1, #0
        addne r0, r0, #1 ; Round to upper bound
        mov r2, r0 ; argument #2 HPHeal
        mov r0, #1 ; argument #4 FailMessage
        str r0, [r13, #+0x0]
        mov r0, r9 ; argument #0 User
        mov r1, r4 ; argument #1 Target
        mov r3, #0 ; argument #3 MaxHpRaise
        bl RaiseHP
        
        b MoveJumpAddress

    func_menu: ;the menu calls this function for each option
        ;r0: buffer = Function(r0: buffer, r1: opt_id)
        ;buffer must contain a string representation of the option
        
        stmdb r13!,{r3,r4,r14}
        
        ; Here we create a simple string with the id
        sub r13,r13,#0x64
        mov r4,r0
        add r0,r1,#1
        mov r2, r0
        bl 0x02050950
        mov r1, r0
        mov r0, r4
        bl 0x02025788
        
        mov r0,r4
        add r13,r13,#0x64
        ldmia r13!,{r3,r4,r15}
        .pool
    menu_layout:
        .word 0x00000000
        .dcb 2 ; x pos
        .dcb 2 ; y pos
        .dcb 0 ; width (auto if 0)
        .dcb 0 ; height (auto if 0)
        .word 0x0000FF00
        .word 0x00000000
    menu_str:
        .ascii "[CS:E][CN]Which type do you want to take?[CR]"
        dcb 0
    auto_menu:
        .ascii "%d"
        dcb 0
    str_res:
        .ascii "Result: %02d"
        dcb 0
    fail: 
        .ascii "But you can't use this move..."
        dcb 0

    end:
        add r13, r13, #0x8 
        .pool

    .endarea
.close