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
.orga 0x34400
.area 0x34800 - 0x34400

BranchItemRando:
	mov r1, 0B10h
	push {r0-r9, lr}
InfiniteLoop:
	mov r0, 0h
	cmp r0, 1h
	bne InfiniteLoop
	pop {r0-r9, pc}

.pool
.endarea
.close