 #include "lib_vox.h"

	.global main 
	.text 
	.align 2
 
main: 
addi sp, sp, -24 
sd ra, 16(sp) 
#========================> COPY a, 0
sd zero, 8(sp)
li t0, 0
sd t0, 8(sp)
#========================> COPY b, 1
sd zero, 0(sp)
li t0, 1
sd t0, 0(sp)
#========================> CMP 1, 0, !=
li t0, 1
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> BRANCHEZ .L4
beqz t4, .L4
#========================> CMP 0, 0, !=
li t0, 0
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> BRANCHEZ .L5
beqz t4, .L5
#========================> CMP 1, 0, !=
li t0, 1
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> LABEL .L5
.L5:
#========================> LABEL .L4
.L4:
#========================> BRANCHNEZ .L3
bnez t4, .L3
#========================> CMP 1, 0, !=
li t0, 1
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> LABEL .L3
.L3:
#========================> BRANCHEZ .L1
beqz t4, .L1
#========================> CMP b, 0, !=
ld t0, 0(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> BRANCHEZ .L6
beqz t4, .L6
#========================> PARAM $str0

la a0, $str0
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> GOTO .L7
j .L7
#========================> LABEL .L6
.L6:
#========================> PARAM $str1

la a0, $str1
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> LABEL .L7
.L7:
#========================> GOTO .L2
j .L2
#========================> LABEL .L1
.L1:
#========================> CMP b, 0, !=
ld t0, 0(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> BRANCHEZ .L8
beqz t4, .L8
#========================> PARAM $str2

la a0, $str2
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> GOTO .L9
j .L9
#========================> LABEL .L8
.L8:
#========================> PARAM $str3

la a0, $str3
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> LABEL .L9
.L9:
#========================> LABEL .L2
.L2:
ld ra, 16(sp)
mv a0, zero
ret
	.section .rodata
$str0: .string "a, b true"
$str1: .string "only a true"
$str2: .string "only b true"
$str3: .string "none of them are true"
