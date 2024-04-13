; 0x22e7848: where to hook
; Original instruction: mov r1, 0B10h
; sp: Nb items per category
; sp+10: Item Weights
; sp+38: Item IDs 

.nds
.open "overlay_0029.bin", 0x22DC240

; Initializes the stats
    .org 0x22E7848
    .area 0x4
        bl BranchItemRando
    .endarea
.close

.open "overlay_0036.bin", 0x23A7080
.orga 0x34300
.area 0x34800 - 0x34300

BranchItemRando:
	mov r1, 0B10h
	push {r0-r12, lr}
	ldr r0, =BackupListPointer
	str r6, [r0]
    mov r0, 0x0
    mov r1, 0x4E
    mov r2, 0x30
    bl 0x204B678
    cmp r0, 1h
    bne GoldenHall
	mov r7, r6
	sub sp, sp, #0x50

; Random Items loop
	mov r4, 0h ; r1: loop counter
RandomItem:
	ldr r0, =#362 ; argument #0 Higher bound
    bl 0x22EAA98
    add r0, r0, #1
    strh r0, [sp, r4]
CountRandom:
    add r4, r4, 2h
    cmp r4, #0x50
    blt RandomItem

; Sort the item list so the IDs are incremental
    mov r3, 0h
    mov r4, 0h
SortItems:
    ldrh r0, [sp, r4]
    mov r5, r3
; Compare item r0 with item r1. Sort the (r2+1)th lower value
CompareItems:    
    cmp r4, r5
    beq CountCompare
    ldrh r1, [sp, r5]
    cmp r0, r1
    addeq r0, r0, 1h ; Prevents duplicates in the list
    strgeh r0, [sp, r5]
    strgeh r1, [sp, r4]
    ldrgeh r0, [sp, r4]
CountCompare:
    add r5, r5, 2h
    cmp r5, #0x50
    blt CompareItems
CountSort:
    add r4, r4, 2h
    cmp r4, #0x50
    addlt r3, r3, 2h
    blt SortItems

; Prepare an array list of items with the number of items per category
	sub sp, sp, #0x60

; Zeroes the 0x60 bytes in stack
	mov r4, 0h
	mov r5, 0h
ZeroesStack:
	strh r4, [sp, r5]
	add r5, r5, 2h
	cmp r5, 60h
	blt ZeroesStack

   	mov r4, 0h ; r1: loop counter
GetCategory:
	add r2, r4, 60h
	ldrh r0, [sp, r2]
	bl 0x200caf0 ; ret: r0 item category
	ldrb r3, [sp, r0]
	add r3, r3, 1h
	strb r3, [sp, r0]
CountCategory:
	add r4, r4, 2h
	cmp r4, #0x50
	blt GetCategory

; Weight List creation loop
	mov r5, 0h ; r5: loop counter
WeightList:
	ldrb r4, [sp, r5] ; load the number of items in r5 category
	cmp r4, #0 ; If there's no item in r5 category, skip the loop
	beq CountWeights
; Search the array for elements of r5 category + assign the weights
	mov r2, 0h ; r2: Incremental counter for the number of weights assigned
	mov r9, 0h ; r9: Incremental weights in r5 category
	mov r6, 0h ; r6: Weight loop counter
ListCreation:
	add r8, r6, 60h ; Get the item ID's memory adress
	ldrh r0, [sp, r8] ; load the item ID
	bl 0x200caf0 ; ret: r0 item category
	cmp r0, r5
	bne CountLists ; If the item is not in r5 category, skip the loop
	ldr r0, =#10000
	mov r1, r4
	bl 0x0208FEA4 ; Euclidian Division
	add r2, r2, 1h ; Increment the category counter for weights assigned
	add r3, r9, r0 ; Assign to r3 the correct incremental weight
	cmp r2, r4
	ldreq r3, =#10000 ; Force the last assigned weight to 10000
	add r1, r6, 10h
	strh r3, [sp, r1]

CountLists:
    add r6, r6, 2h
    cmp r6, #0x50 ; 40 half-words: number of items in the list
    blt ListCreation

CountWeights:
	add r5, r5, 1h
	cmp r5, #0x10 ; 16 categories
	blt WeightList

; Create Category Weights
	mov r4, 0h ; r4: number of items assigned
	mov r5, r7 ; r5: r7 pointer
	mov r6, 0h ; r6: category loop counter
	mov r9, 0h ; Incremental weights for lists
	ldr r1, =#250 ; Weight increase
CatWeights:
	add r8, r6, r6 ; r8 = 2x r6
	ldrh r0, [r5, r8] ; loads the category weight list in r6
	ldrb r3, [sp, r6] ; Loads the nb of items in r6 category
	cmp r3, #0
	moveq r0, #0
	streqh r0, [r5, r8] ; Stores 00 00 if the category should have no weights
	beq LoopCatWeights
	add r4, r4, r3
	cmp r4, 28h
	ldreq r9, =#10000
	streqh r9, [r5, r8]
	beq LoopCatWeights
	mul r2, r1, r3 ; 500 x nb items in r6 category
	add r9, r9, r2 ; r9: weight to store
	strh r9, [r5, r8] ; Stores the weight accordingly
LoopCatWeights:
	add r6, r6, 1h
	cmp r6, #0x10 ; 16 categories
	blt CatWeights

; Copy the list of items per category in stack
	sub sp, sp, 10h
	mov r6, 0h
CopyCategory:
	add r1, r6, 10h
	ldrb r0, [sp, r1]
	strb r0, [sp, r6]
LoopCopyCategory:
	add r6, r6, 1h
	cmp r6, #0x10 ; 16 categories
	blt CopyCategory

; Replace the old items with the new ones in [r7]
	mov r1, 0h ; r1: checked ID
	add r5, r7, 30h ; First item weight load address
	mov r6, 0h ; r6: loop counter
AssignWeights:
	add r2, r6, r6 ; r2: 2xr6
	add r3, r2, 70h ; r3: place of the item ID in the stack
	ldrh r0, [sp, r3] ; Item ID
	mov r8, 0h ; r8: zeroes to store
ZeroesEmptyIDs:
; Set the entry point for the weight
	add r4, r1, r1 ; r4 = 2xr1
	cmp r1, r0
	bne LoopZeroes
	mov r10, r1
	bl 0x200caf0 ; ret: r0 item category
	mov r1, r10
	add r8, r2, 20h
	ldrh r9, [sp, r8]
; r12: pointer to the list of items per category in stack
	add r12, sp, 10h
; r10: number of items per category not allocated in the list
	ldrb r10, [sp, r0]
; r11: number of items per category
	ldrb r11, [r12, r0]
	sub r11, r11, r10 ; Get the index of the item in category
	add r11, r11, 1h ; add 1 to have it be different from zero
	mul r9, r9, r11 ; multiply the item weight with the item index in category
	sub r10, r10, 1h ; item allocated, substract 1 from the list in r10
	cmp r10, 0h
	ldreq r9, =#10000
	strb r10, [sp, r0] ; store r10
	strh r9, [r5, r4] ; store the weight in the actual list

LoopAssignWeights:
	add r1, r1, 1h
	add r6, r6, 1h
	cmp r6, #0x28 ; 40 items
	blt AssignWeights
	b checkMaxID

LoopZeroes:
	strh r8, [r5, r4]
	add r1, r1, 1h
checkMaxID:
	ldr r4, =#363
	cmp r1, r4 ; Max valid ID
	blt ZeroesEmptyIDs
end:	
	add sp, sp, #0xC0

;InfiniteLoop:
;	mov r0, 0h
;	cmp r0, 1h
;	bne InfiniteLoop

GoldenHall:
	ldr r8, =286B2h
	ldr r7, =2353538h
	ldr r7, [r7]
	add r7, r7, r8
	ldrb r0, [r7, 3h] ; Music ID
	cmp r0, #121
	bne popHall
	ldrb r0, [r7, 2h] ; Tileset ID
	cmp r0, #60
	bne popHall
	ldrb r0, [r7, 17h] ; Max Money amount
	cmp r0, #255
	bne popHall
	; Sitrus Berries, Perfect Apples, Gold Thorns, Joy Seeds, Lost Loots, Secret Slabs and Money

; List of items in Golden Hall (8)
	ldr r7, =BackupListPointer
	ldr r7, [r7]
	sub sp, sp, #0x10
	ldr r4, =HallList
	mov r5, #0
LoopHallList:
	ldrh r1, [r4, r5]
	strh r1, [sp, r5]
nextIterHallList:
	cmp r5, #14
	addlt r5, r5, #2
	blt LoopHallList

; Prepare an array list of items with the number of items per category
	sub sp, sp, #0x20

; Zeroes the 0x20 bytes in stack
	mov r4, 0h
	mov r5, 0h
ZeroesStackHall:
	strh r4, [sp, r5]
	add r5, r5, 2h
	cmp r5, 20h
	blt ZeroesStackHall

	mov r4, 0h ; r1: loop counter
GetCategoryHall:
	add r2, r4, 20h
	ldrh r0, [sp, r2]
	bl 0x200caf0 ; ret: r0 item category
	ldrb r3, [sp, r0]
	add r3, r3, 1h
	strb r3, [sp, r0]
CountCategoryHall:
	add r4, r4, 2h
	cmp r4, #0x10
	blt GetCategoryHall

; Weight List creation loop
	mov r5, 0h ; r5: loop counter
WeightListHall:
	ldrb r4, [sp, r5] ; load the number of items in r5 category
	cmp r4, #0 ; If there's no item in r5 category, skip the loop
	beq CountWeightsHall
; Search the array for elements of r5 category + assign the weights
	mov r2, 0h ; r2: Incremental counter for the number of weights assigned
	mov r9, 0h ; r9: Incremental weights in r5 category
	mov r6, 0h ; r6: Weight loop counter
ListCreationHall:
	add r8, r6, 20h ; Get the item ID's memory adress
	ldrh r0, [sp, r8] ; load the item ID
	bl 0x200caf0 ; ret: r0 item category
	cmp r0, r5
	bne CountListsHall ; If the item is not in r5 category, skip the loop
	ldr r0, =#10000
	mov r1, r4
	bl 0x0208FEA4 ; Euclidian Division
	add r2, r2, 1h ; Increment the category counter for weights assigned
	add r3, r9, r0 ; Assign to r3 the correct incremental weight
	cmp r2, r4
	ldreq r3, =#10000 ; Force the last assigned weight to 10000
	add r1, r6, 10h
	strh r3, [sp, r1]

CountListsHall:
    add r6, r6, 2h
    cmp r6, #0x10 ; 40 half-words: number of items in the list
    blt ListCreationHall

CountWeightsHall:
	add r5, r5, 1h
	cmp r5, #0x10 ; 16 categories
	blt WeightListHall

; Create Category Weights
	mov r4, 0h ; r4: number of items assigned
	mov r5, r7 ; r5: r7 pointer
	mov r6, 0h ; r6: category loop counter
	mov r9, 0h ; Incremental weights for lists
	ldr r1, =#1200 ; Weight increase
CatWeightsHall:
	add r8, r6, r6 ; r8 = 2x r6
	ldrh r0, [r5, r8] ; loads the category weight list in r6
	ldrb r3, [sp, r6] ; Loads the nb of items in r6 category
	cmp r3, #0
	moveq r0, #0
	streqh r0, [r5, r8] ; Stores 00 00 if the category should have no weights
	beq LoopCatWeightsHall
	add r4, r4, r3
	cmp r4, 8h
	ldreq r9, =#10000
	streqh r9, [r5, r8]
	beq LoopCatWeightsHall
	mul r2, r1, r3 ; 500 x nb items in r6 category
	add r9, r9, r2 ; r9: weight to store
	strh r9, [r5, r8] ; Stores the weight accordingly
LoopCatWeightsHall:
	add r6, r6, 1h
	cmp r6, #0x10 ; 16 categories
	blt CatWeightsHall

; Copy the list of items per category in stack
	sub sp, sp, 10h
	mov r6, 0h
CopyCategoryHall:
	add r1, r6, 10h
	ldrb r0, [sp, r1]
	strb r0, [sp, r6]
LoopCopyCategoryHall:
	add r6, r6, 1h
	cmp r6, #0x10 ; 16 categories
	blt CopyCategoryHall

; Replace the old items with the new ones in [r7]
	mov r1, 0h ; r1: checked ID
	add r5, r7, 20h ; First item weight load address
	mov r6, 0h ; r6: loop counter
AssignWeightsHall:
	add r2, r6, r6 ; r2: 2xr6
	add r3, r2, 30h ; r3: place of the item ID in the stack
	ldrh r0, [sp, r3] ; Item ID
	mov r8, 0h ; r8: zeroes to store
ZeroesEmptyIDsHall:
; Set the entry point for the weight
	add r4, r1, r1 ; r4 = 2xr1
	cmp r1, r0
	bne LoopZeroesHall
	mov r10, r1
	bl 0x200caf0 ; ret: r0 item category
	mov r1, r10
	add r8, r2, 20h
	ldrh r9, [sp, r8]
; r12: pointer to the list of items per category in stack
	add r12, sp, 10h
; r10: number of items per category not allocated in the list
	ldrb r10, [sp, r0]
; r11: number of items per category
	ldrb r11, [r12, r0]
	sub r11, r11, r10 ; Get the index of the item in category
	add r11, r11, 1h ; add 1 to have it be different from zero
	mul r9, r9, r11 ; multiply the item weight with the item index in category
	sub r10, r10, 1h ; item allocated, substract 1 from the list in r10
	cmp r10, 0h
	ldreq r9, =#10000
	strb r10, [sp, r0] ; store r10
	strh r9, [r5, r4] ; store the weight in the actual list

LoopAssignWeightsHall:
	add r1, r1, 1h
	add r6, r6, 1h
	cmp r6, #0x8 ; 8 items
	blt AssignWeightsHall
	b checkMaxIDHall

LoopZeroesHall:
	strh r8, [r5, r4]
	add r1, r1, 1h
checkMaxIDHall:
	ldr r4, =#363
	cmp r1, r4 ; Max valid ID
	blt ZeroesEmptyIDsHall
endHall:	
	add sp, sp, #0x40
popHall:
	pop {r0-r12, pc}


HallList:
	.dcw 0x9
	.dcw 0x20
	.dcw 0x47
	.dcw 0x59
	.dcw 0x73
	.dcw 0x88
	.dcw 0xAE
	.dcw 0xBA

BackupListPointer:
	.dcd 0x0

.pool
.endarea
.close