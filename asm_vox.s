 #include "lib_vox.h"

.global main 
.text 
.align 2 
                main: 
addi sp, sp, -24 
sd ra, 16(sp) 
         # COPY i, 10
sd zero, 8(sp)
li t0, 10
sd t0, 8(sp)
         # LABEL .L1
.L1:
         # CMP i, 3, >=
ld t0, 8(sp)
li t1, 3
slt t4, t0, t1
xor  t4, t4, 1
         # BRANCHEZ .L2
beqz t4, .L2
         # PARAM i

ld a0, 8(sp)
         # CALL i, __vox_print__, 1
call __vox_print__ 
         # PARAM i

ld a0, 8(sp)
         # PARAM 1

li a1, 1
         # CALL tmp0, __vox_sub__, 2
call __vox_sub__ 
sd a0, 0(sp)
         # COPY i, tmp0
ld t0, 0(sp)
sd t0, 8(sp)
         # GOTO .L1
j .L1
         # LABEL .L2
.L2:

ld ra, 16(sp)
mv a0, zero
ret
.data
