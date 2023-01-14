 #include "lib_vox.h"

.global main 
.text 
.align 2 
main: 
addi sp, sp, -88 
sd ra, 80(sp) 
         # PARAM 1

li a0, 1
         # PARAM 5

li a1, 5
         # CALL tmp0, __vox_mul__, 2
call __vox_mul__ 
sd a0, 40(sp)
         # PARAM tmp0

ld a0, 40(sp)
         # PARAM 3

li a1, 3
         # CALL tmp1, __vox_add__, 2
call __vox_add__ 
sd a0, 48(sp)
         # PARAM tmp1

ld a0, 48(sp)
         # PARAM 21

li a1, 21
         # CALL tmp2, __vox_sub__, 2
call __vox_sub__ 
sd a0, 56(sp)
         # COPY a, tmp2
ld t0, 56(sp)
sd t0, 8(sp)
         # PARAM 3

li a0, 3
         # PARAM 4

li a1, 4
         # CALL tmp3, __vox_sub__, 2
call __vox_sub__ 
sd a0, 64(sp)
         # PARAM 43

li a0, 43
         # PARAM tmp3

ld a1, 64(sp)
         # CALL tmp4, __vox_mul__, 2
call __vox_mul__ 
sd a0, 24(sp)
         # PARAM 36

li a0, 36
         # PARAM tmp4

ld a1, 24(sp)
         # CALL tmp5, __vox_add__, 2
call __vox_add__ 
sd a0, 16(sp)
         # COPY b, tmp5
ld t0, 16(sp)
sd t0, 72(sp)
         # PARAM a

ld a0, 8(sp)
         # PARAM b

ld a1, 72(sp)
         # CALL tmp6, __vox_mul__, 2
call __vox_mul__ 
sd a0, 32(sp)
         # COPY c, tmp6
ld t0, 32(sp)
sd t0, 0(sp)
         # PARAM c

ld a0, 0(sp)
         # CALL c, __vox_print__, 1
call __vox_print__ 
sd a0, 0(sp)
         # COPY c, 31
sd zero, 0(sp)
li t0, 31
sd t0, 0(sp)
         # PARAM c

ld a0, 0(sp)
         # CALL c, __vox_print__, 1
call __vox_print__ 
sd a0, 0(sp)

ld ra, 80(sp)
mv a0, zero
ret
.data
