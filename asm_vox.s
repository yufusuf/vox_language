 #include "lib_vox.h"

	.global main 
	.text 
	.align 2
#========================> LABEL add
add:
#========================> FUN_ENTRY 1
addi sp, sp, -48
sd t4, 32(sp)
sd ra, 40(sp)
mv t0, a0
sd t0, 8(sp)
mv t0, a1
sd t0, 24(sp)
#========================> PARAM a

ld a0, 8(sp)
#========================> PARAM b

ld a1, 24(sp)
#========================> CALL tmp0, __vox_add__, 2
call __vox_add__ 
sd a0, 16(sp)
#========================> COPY result, tmp0
ld t0, 16(sp)
sd t0, 0(sp)
#========================> PARAM $str0

la a0, $str0
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> CMP result, 5, >
ld t0, 0(sp)
li t1, 5
slt t4, t1, t0
#========================> BRANCHEZ .L1
beqz t4, .L1
#========================> ENV 2
addi sp, sp, -32
#========================> COPY i, 40
sd zero, 0(sp)
li t0, 40
sd t0, 0(sp)
#========================> COPY j, 70
sd zero, 8(sp)
li t0, 70
sd t0, 8(sp)
#========================> LABEL .L2
.L2:
#========================> CMP j, 0, >=
ld t0, 8(sp)
li t1, 0
slt t4, t0, t1
xor  t4, t4, 1
#========================> BRANCHEZ .L3
beqz t4, .L3
#========================> ENV 3
addi sp, sp, -32
#========================> COPY a, -100
sd zero, 8(sp)
li t0, -100
sd t0, 8(sp)
#========================> PARAM j

ld a0, 40(sp)
#========================> PARAM 10

li a1, 10
#========================> CALL tmp1, __vox_sub__, 2
call __vox_sub__ 
sd a0, 0(sp)
#========================> COPY j, tmp1
ld t0, 0(sp)
sd t0, 40(sp)
#========================> CMP j, 10, ==
ld t0, 40(sp)
li t1, 10
sub  t1, t1, t0
seqz t4, t1
#========================> BRANCHEZ .L4
beqz t4, .L4
#========================> ENV 4
addi sp, sp, -24
#========================> COPY j, 5
sd zero, 0(sp)
li t0, 5
sd t0, 0(sp)
#========================> LABEL .L5
.L5:
#========================> CMP j, 0, >=
ld t0, 0(sp)
li t1, 0
slt t4, t0, t1
xor  t4, t4, 1
#========================> BRANCHEZ .L6
beqz t4, .L6
#========================> ENV 5
addi sp, sp, -24
#========================> PARAM j

ld a0, 24(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM j

ld a0, 24(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL tmp2, __vox_sub__, 2
call __vox_sub__ 
sd a0, 0(sp)
#========================> COPY j, tmp2
ld t0, 0(sp)
sd t0, 24(sp)
#========================> ENV_EXIT 5
addi sp, sp, 24
#========================> GOTO .L5
j .L5
#========================> LABEL .L6
.L6:
#========================> ENV_EXIT 4
addi sp, sp, 24
#========================> LABEL .L4
.L4:
#========================> ENV_EXIT 3
addi sp, sp, 32
#========================> GOTO .L2
j .L2
#========================> LABEL .L3
.L3:
#========================> ENV_EXIT 2
addi sp, sp, 32
#========================> LABEL .L1
.L1:
#========================> CMP 4, 5, <
li t0, 4
li t1, 5
slt t4, t0, t1
#========================> BRANCHEZ .L7
beqz t4, .L7
#========================> ENV 6
addi sp, sp, -24
#========================> COPY a, 21
sd zero, 0(sp)
li t0, 21
sd t0, 0(sp)
#========================> CMP 6, 7, <
li t0, 6
li t1, 7
slt t4, t0, t1
#========================> BRANCHEZ .L8
beqz t4, .L8
#========================> ENV 7
addi sp, sp, -24
#========================> COPY b, 32
sd zero, 0(sp)
li t0, 32
sd t0, 0(sp)
#========================> CMP 8, 20, <
li t0, 8
li t1, 20
slt t4, t0, t1
#========================> NOT 
xor t4, t4, 1
#========================> NOT 
xor t4, t4, 1
#========================> BRANCHEZ .L9
beqz t4, .L9
#========================> ENV 8
addi sp, sp, -24
#========================> PARAM $str1

la a0, $str1
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM b

ld a0, 24(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM $str2

la a0, $str2
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM a

ld a0, 48(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM result

ld a0, 72(sp)
#========================> PARAM 10000

li a1, 10000
#========================> CALL tmp3, __vox_add__, 2
call __vox_add__ 
sd a0, 0(sp)
#========================> RETURN tmp3
ld t4, 104(sp)
ld ra, 112(sp)
ld a0, 0(sp)
addi sp, sp, 120
ret
#========================> ENV_EXIT 8
addi sp, sp, 24
#========================> GOTO .L10
j .L10
#========================> LABEL .L9
.L9:
#========================> ENV 9
addi sp, sp, -56
#========================> COPY i, 500
sd zero, 16(sp)
li t0, 500
sd t0, 16(sp)
#========================> COPY a, 400
sd zero, 8(sp)
li t0, 400
sd t0, 8(sp)
#========================> COPY j, 300
sd zero, 24(sp)
li t0, 300
sd t0, 24(sp)
#========================> PARAM $str3

la a0, $str3
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM a

ld a0, 8(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM b

ld a0, 56(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM i

ld a0, 16(sp)
#========================> PARAM j

ld a1, 24(sp)
#========================> CALL tmp4, __vox_mul__, 2
call __vox_mul__ 
sd a0, 0(sp)
#========================> PARAM tmp4

ld a0, 0(sp)
#========================> PARAM a

ld a1, 8(sp)
#========================> CALL tmp5, __vox_mul__, 2
call __vox_mul__ 
sd a0, 32(sp)
#========================> NEG tmp5
ld t0, 32(sp)
xor t0, t0, -1
addi t0, t0, 1
sd t0, 32(sp)
#========================> RETURN tmp5
ld t4, 136(sp)
ld ra, 144(sp)
ld a0, 32(sp)
addi sp, sp, 152
ret
#========================> ENV_EXIT 9
addi sp, sp, 56
#========================> LABEL .L10
.L10:
#========================> ENV_EXIT 7
addi sp, sp, 24
#========================> LABEL .L8
.L8:
#========================> ENV_EXIT 6
addi sp, sp, 24
#========================> LABEL .L7
.L7:
#========================> RETURN result
ld t4, 32(sp)
ld ra, 40(sp)
ld a0, 0(sp)
addi sp, sp, 48
ret
#========================> FUN_EXIT 1
#========================> LABEL cort
cort:
#========================> FUN_ENTRY 10
addi sp, sp, -24
sd t4, 8(sp)
sd ra, 16(sp)
mv t0, a0
sd t0, 0(sp)
#========================> PARAM i

ld a0, 48(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM j

ld a0, 64(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> RETURN a
ld t4, 8(sp)
ld ra, 16(sp)
ld a0, 0(sp)
addi sp, sp, 24
ret
#========================> FUN_EXIT 10
#========================> LABEL large
large:
#========================> FUN_ENTRY 11
addi sp, sp, -128
sd t4, 112(sp)
sd ra, 120(sp)
mv t0, a0
sd t0, 24(sp)
mv t0, a1
sd t0, 104(sp)
mv t0, a2
sd t0, 48(sp)
mv t0, a3
sd t0, 88(sp)
mv t0, a4
sd t0, 32(sp)
mv t0, a5
sd t0, 40(sp)
mv t0, a6
sd t0, 8(sp)
mv t0, a7
sd t0, 56(sp)
#========================> PARAM a

ld a0, 24(sp)
#========================> PARAM b

ld a1, 104(sp)
#========================> CALL tmp6, __vox_add__, 2
call __vox_add__ 
sd a0, 0(sp)
#========================> PARAM tmp6

ld a0, 0(sp)
#========================> PARAM c

ld a1, 48(sp)
#========================> CALL tmp7, __vox_add__, 2
call __vox_add__ 
sd a0, 80(sp)
#========================> PARAM tmp7

ld a0, 80(sp)
#========================> PARAM d

ld a1, 88(sp)
#========================> CALL tmp8, __vox_add__, 2
call __vox_add__ 
sd a0, 16(sp)
#========================> PARAM tmp8

ld a0, 16(sp)
#========================> PARAM e

ld a1, 32(sp)
#========================> CALL tmp9, __vox_add__, 2
call __vox_add__ 
sd a0, 72(sp)
#========================> PARAM tmp9

ld a0, 72(sp)
#========================> PARAM f

ld a1, 40(sp)
#========================> CALL tmp10, __vox_add__, 2
call __vox_add__ 
sd a0, 64(sp)
#========================> PARAM tmp10

ld a0, 64(sp)
#========================> PARAM g

ld a1, 8(sp)
#========================> CALL tmp11, __vox_add__, 2
call __vox_add__ 
sd a0, 96(sp)
#========================> RETURN tmp11
ld t4, 112(sp)
ld ra, 120(sp)
ld a0, 96(sp)
addi sp, sp, 128
ret
#========================> FUN_EXIT 11
#========================> LABEL fibo
fibo:
#========================> FUN_ENTRY 12
addi sp, sp, -64
sd t4, 48(sp)
sd ra, 56(sp)
mv t0, a0
sd t0, 8(sp)
#========================> CMP a, 0, ==
ld t0, 8(sp)
li t1, 0
sub  t1, t1, t0
seqz t4, t1
#========================> BRANCHEZ .L11
beqz t4, .L11
#========================> RETURN 0
ld t4, 48(sp)
ld ra, 56(sp)
li a0, 0
addi sp, sp, 64
ret
#========================> LABEL .L11
.L11:
#========================> CMP a, 1, ==
ld t0, 8(sp)
li t1, 1
sub  t1, t1, t0
seqz t4, t1
#========================> BRANCHNEZ .L13
bnez t4, .L13
#========================> CMP a, 2, ==
ld t0, 8(sp)
li t1, 2
sub  t1, t1, t0
seqz t4, t1
#========================> LABEL .L13
.L13:
#========================> BRANCHEZ .L12
beqz t4, .L12
#========================> ENV 13
addi sp, sp, -16
#========================> RETURN 1
ld t4, 64(sp)
ld ra, 72(sp)
li a0, 1
addi sp, sp, 80
ret
#========================> ENV_EXIT 13
addi sp, sp, 16
#========================> LABEL .L12
.L12:
#========================> PARAM a

ld a0, 8(sp)
#========================> PARAM 2

li a1, 2
#========================> CALL tmp12, __vox_sub__, 2
call __vox_sub__ 
sd a0, 24(sp)
#========================> PARAM tmp12

ld a0, 24(sp)
#========================> CALL tmp13, fibo, 1
call fibo 
sd a0, 32(sp)
#========================> PARAM a

ld a0, 8(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL tmp14, __vox_sub__, 2
call __vox_sub__ 
sd a0, 16(sp)
#========================> PARAM tmp14

ld a0, 16(sp)
#========================> CALL tmp15, fibo, 1
call fibo 
sd a0, 0(sp)
#========================> PARAM tmp13

ld a0, 32(sp)
#========================> PARAM tmp15

ld a1, 0(sp)
#========================> CALL tmp16, __vox_add__, 2
call __vox_add__ 
sd a0, 40(sp)
#========================> RETURN tmp16
ld t4, 48(sp)
ld ra, 56(sp)
ld a0, 40(sp)
addi sp, sp, 64
ret
#========================> FUN_EXIT 12
 
main: 
addi sp, sp, -96 
sd ra, 88(sp) 
#========================> COPY i, 4
sd zero, 24(sp)
li t0, 4
sd t0, 24(sp)
#========================> COPY j, 6
sd zero, 40(sp)
li t0, 6
sd t0, 40(sp)
#========================> COPY otuzbir, 31
sd zero, 80(sp)
li t0, 31
sd t0, 80(sp)
#========================> PARAM 10

li a0, 10
#========================> PARAM 20

li a1, 20
#========================> CALL tmp17, add, 2
call add 
sd a0, 8(sp)
#========================> COPY j, tmp17
ld t0, 8(sp)
sd t0, 40(sp)
#========================> PARAM j

ld a0, 40(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM $str4

la a0, $str4
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 1

li a0, 1
#========================> PARAM 2

li a1, 2
#========================> PARAM 3

li a2, 3
#========================> PARAM 4

li a3, 4
#========================> PARAM 5

li a4, 5
#========================> PARAM 6

li a5, 6
#========================> PARAM 7

li a6, 7
#========================> CALL tmp18, large, 7
call large 
sd a0, 32(sp)
#========================> PARAM tmp18

ld a0, 32(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 20

li a0, 20
#========================> CALL tmp19, fibo, 1
call fibo 
sd a0, 48(sp)
#========================> PARAM tmp19

ld a0, 48(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 7

li a0, 7
#========================> CALL tmp20, fibo, 1
call fibo 
sd a0, 0(sp)
#========================> PARAM tmp20

ld a0, 0(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 6

li a0, 6
#========================> CALL tmp21, fibo, 1
call fibo 
sd a0, 56(sp)
#========================> PARAM tmp21

ld a0, 56(sp)
#========================> CALL tmp22, fibo, 1
call fibo 
sd a0, 16(sp)
#========================> PARAM tmp22

ld a0, 16(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 6

li a0, 6
#========================> CALL tmp23, fibo, 1
call fibo 
sd a0, 64(sp)
#========================> PARAM tmp23

ld a0, 64(sp)
#========================> CALL tmp24, fibo, 1
call fibo 
sd a0, 72(sp)
#========================> CMP tmp24, 3, >
ld t0, 72(sp)
li t1, 3
slt t4, t1, t0
#========================> BRANCHEZ .L15
beqz t4, .L15
#========================> CMP 3, 4, >
li t0, 3
li t1, 4
slt t4, t1, t0
#========================> NOT 
xor t4, t4, 1
#========================> LABEL .L15
.L15:
#========================> BRANCHEZ .L14
beqz t4, .L14
#========================> ENV 14
addi sp, sp, -16
#========================> PARAM 4

li a0, 4
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> ENV_EXIT 14
addi sp, sp, 16
#========================> LABEL .L14
.L14:
ld ra, 88(sp)
mv a0, zero
ret
	.section .rodata
$str0: .string "ADDING"
$str1: .string "b: "
$str2: .string "a: "
$str3: .string "deepest nest"
$str4: .string "fibos and larges"
