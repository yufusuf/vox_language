 #include "lib_vox.h"

	.global main 
	.text 
	.align 2
#========================> LABEL give_zero
give_zero:
#========================> FUN_ENTRY 1
addi sp, sp, -16
sd t4, 0(sp)
sd ra, 8(sp)
#========================> RETURN 0
ld t4, 0(sp)
ld ra, 8(sp)
li a0, 0
addi sp, sp, 16
ret
#========================> FUN_EXIT 1
#========================> LABEL add
add:
#========================> FUN_ENTRY 2
addi sp, sp, -80
sd t4, 64(sp)
sd ra, 72(sp)
mv t0, a0
sd t0, 16(sp)
mv t0, a1
sd t0, 40(sp)
#========================> COPY h, 0
sd zero, 0(sp)
li t0, 0
sd t0, 0(sp)
#========================> COPY g, 0
sd zero, 32(sp)
li t0, 0
sd t0, 32(sp)
#========================> COPY i, 0
sd zero, 48(sp)
li t0, 0
sd t0, 48(sp)
#========================> PARAM a

ld a0, 16(sp)
#========================> PARAM b

ld a1, 40(sp)
#========================> CALL tmp0, __vox_add__, 2
call __vox_add__ 
sd a0, 8(sp)
#========================> COPY result, tmp0
ld t0, 8(sp)
sd t0, 24(sp)
#========================> PARAM $str0

la a0, $str0
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> CALL tmp1, give_zero, 0
call give_zero 
sd a0, 56(sp)
#========================> CMP tmp1, 0, !=
ld t0, 56(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> NOT 
xor t4, t4, 1
#========================> BRANCHNEZ .L2
bnez t4, .L2
#========================> CMP result, 5, <
ld t0, 24(sp)
li t1, 5
slt t4, t0, t1
#========================> BRANCHEZ .L5
beqz t4, .L5
#========================> CMP h, 0, !=
ld t0, 0(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> NOT 
xor t4, t4, 1
#========================> LABEL .L5
.L5:
#========================> BRANCHEZ .L4
beqz t4, .L4
#========================> CMP g, 0, !=
ld t0, 32(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> NOT 
xor t4, t4, 1
#========================> LABEL .L4
.L4:
#========================> BRANCHEZ .L3
beqz t4, .L3
#========================> CMP i, 0, !=
ld t0, 48(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> NOT 
xor t4, t4, 1
#========================> LABEL .L3
.L3:
#========================> LABEL .L2
.L2:
#========================> BRANCHEZ .L1
beqz t4, .L1
#========================> ENV 3
addi sp, sp, -32
#========================> COPY i, 40
sd zero, 8(sp)
li t0, 40
sd t0, 8(sp)
#========================> COPY j, 70
sd zero, 0(sp)
li t0, 70
sd t0, 0(sp)
#========================> PARAM $str1

la a0, $str1
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> LABEL .L6
.L6:
#========================> CMP j, 0, >=
ld t0, 0(sp)
li t1, 0
slt t4, t0, t1
xor  t4, t4, 1
#========================> BRANCHEZ .L7
beqz t4, .L7
#========================> ENV 4
addi sp, sp, -40
#========================> COPY a, -100
sd zero, 16(sp)
li t0, -100
sd t0, 16(sp)
#========================> PARAM a

ld a0, 16(sp)
#========================> PARAM j

ld a1, 40(sp)
#========================> CALL tmp2, __vox_mul__, 2
call __vox_mul__ 
sd a0, 8(sp)
#========================> PARAM tmp2

ld a0, 8(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM j

ld a0, 40(sp)
#========================> PARAM 10

li a1, 10
#========================> CALL tmp3, __vox_sub__, 2
call __vox_sub__ 
sd a0, 0(sp)
#========================> COPY j, tmp3
ld t0, 0(sp)
sd t0, 40(sp)
#========================> CMP j, 10, ==
ld t0, 40(sp)
li t1, 10
sub  t1, t1, t0
seqz t4, t1
#========================> BRANCHEZ .L8
beqz t4, .L8
#========================> ENV 5
addi sp, sp, -24
#========================> COPY j, 5
sd zero, 0(sp)
li t0, 5
sd t0, 0(sp)
#========================> LABEL .L9
.L9:
#========================> CMP j, 0, >=
ld t0, 0(sp)
li t1, 0
slt t4, t0, t1
xor  t4, t4, 1
#========================> BRANCHEZ .L10
beqz t4, .L10
#========================> ENV 6
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
#========================> CALL tmp4, __vox_sub__, 2
call __vox_sub__ 
sd a0, 0(sp)
#========================> COPY j, tmp4
ld t0, 0(sp)
sd t0, 24(sp)
#========================> PARAM $str2

la a0, $str2
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> RETURN j
ld t4, 184(sp)
ld ra, 192(sp)
ld a0, 24(sp)
addi sp, sp, 200
ret
#========================> ENV_EXIT 6
addi sp, sp, 24
#========================> GOTO .L9
j .L9
#========================> LABEL .L10
.L10:
#========================> ENV_EXIT 5
addi sp, sp, 24
#========================> LABEL .L8
.L8:
#========================> ENV_EXIT 4
addi sp, sp, 40
#========================> GOTO .L6
j .L6
#========================> LABEL .L7
.L7:
#========================> ENV_EXIT 3
addi sp, sp, 32
#========================> LABEL .L1
.L1:
#========================> CMP 4, 5, <
li t0, 4
li t1, 5
slt t4, t0, t1
#========================> BRANCHNEZ .L12
bnez t4, .L12
#========================> CMP a, 0, !=
ld t0, 16(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> LABEL .L12
.L12:
#========================> BRANCHEZ .L11
beqz t4, .L11
#========================> ENV 7
addi sp, sp, -24
#========================> COPY a, 21
sd zero, 0(sp)
li t0, 21
sd t0, 0(sp)
#========================> CMP 6, 7, <
li t0, 6
li t1, 7
slt t4, t0, t1
#========================> BRANCHEZ .L13
beqz t4, .L13
#========================> ENV 8
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
#========================> BRANCHEZ .L14
beqz t4, .L14
#========================> ENV 9
addi sp, sp, -32
#========================> PARAM $str3

la a0, $str3
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM b

ld a0, 32(sp)
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
#========================> PARAM a

ld a0, 56(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> COPY a, 0
sd zero, 56(sp)
li t0, 0
sd t0, 56(sp)
#========================> LABEL .L16
.L16:
#========================> CMP a, 10, <
ld t0, 56(sp)
li t1, 10
slt t4, t0, t1
#========================> BRANCHEZ .L17
beqz t4, .L17
#========================> ENV 10
addi sp, sp, -16
#========================> PARAM a

ld a0, 72(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> CMP a, 7, ==
ld t0, 72(sp)
li t1, 7
sub  t1, t1, t0
seqz t4, t1
#========================> BRANCHEZ .L18
beqz t4, .L18
#========================> ENV 11
addi sp, sp, -24
#========================> COPY result, 989898
sd zero, 0(sp)
li t0, 989898
sd t0, 0(sp)
#========================> RETURN result
ld t4, 184(sp)
ld ra, 192(sp)
ld a0, 0(sp)
addi sp, sp, 200
ret
#========================> ENV_EXIT 11
addi sp, sp, 24
#========================> LABEL .L18
.L18:
#========================> ENV_EXIT 10
addi sp, sp, 16
#========================> PARAM a

ld a0, 56(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL tmp5, __vox_add__, 2
call __vox_add__ 
sd a0, 0(sp)
#========================> COPY a, tmp5
ld t0, 0(sp)
sd t0, 56(sp)
#========================> GOTO .L16
j .L16
#========================> LABEL .L17
.L17:
#========================> PARAM result

ld a0, 104(sp)
#========================> PARAM 10000

li a1, 10000
#========================> CALL tmp6, __vox_add__, 2
call __vox_add__ 
sd a0, 8(sp)
#========================> RETURN tmp6
ld t4, 144(sp)
ld ra, 152(sp)
ld a0, 8(sp)
addi sp, sp, 160
ret
#========================> ENV_EXIT 9
addi sp, sp, 32
#========================> GOTO .L15
j .L15
#========================> LABEL .L14
.L14:
#========================> ENV 12
addi sp, sp, -56
#========================> COPY i, 500
sd zero, 32(sp)
li t0, 500
sd t0, 32(sp)
#========================> COPY a, 400
sd zero, 16(sp)
li t0, 400
sd t0, 16(sp)
#========================> COPY j, 300
sd zero, 8(sp)
li t0, 300
sd t0, 8(sp)
#========================> PARAM $str5

la a0, $str5
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM a

ld a0, 16(sp)
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

ld a0, 32(sp)
#========================> PARAM j

ld a1, 8(sp)
#========================> CALL tmp7, __vox_mul__, 2
call __vox_mul__ 
sd a0, 24(sp)
#========================> PARAM tmp7

ld a0, 24(sp)
#========================> PARAM a

ld a1, 16(sp)
#========================> CALL tmp8, __vox_mul__, 2
call __vox_mul__ 
sd a0, 0(sp)
#========================> NEG tmp8
ld t0, 0(sp)
xor t0, t0, -1
addi t0, t0, 1
sd t0, 0(sp)
#========================> RETURN tmp8
ld t4, 168(sp)
ld ra, 176(sp)
ld a0, 0(sp)
addi sp, sp, 184
ret
#========================> ENV_EXIT 12
addi sp, sp, 56
#========================> LABEL .L15
.L15:
#========================> ENV_EXIT 8
addi sp, sp, 24
#========================> LABEL .L13
.L13:
#========================> ENV_EXIT 7
addi sp, sp, 24
#========================> LABEL .L11
.L11:
#========================> RETURN result
ld t4, 64(sp)
ld ra, 72(sp)
ld a0, 24(sp)
addi sp, sp, 80
ret
#========================> FUN_EXIT 2
#========================> LABEL cort
cort:
#========================> FUN_ENTRY 13
addi sp, sp, -24
sd t4, 8(sp)
sd ra, 16(sp)
mv t0, a0
sd t0, 0(sp)
#========================> PARAM i

ld a0, 80(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM j

ld a0, 56(sp)
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
#========================> FUN_EXIT 13
#========================> LABEL large
large:
#========================> FUN_ENTRY 14
addi sp, sp, -128
sd t4, 112(sp)
sd ra, 120(sp)
mv t0, a0
sd t0, 56(sp)
mv t0, a1
sd t0, 96(sp)
mv t0, a2
sd t0, 80(sp)
mv t0, a3
sd t0, 40(sp)
mv t0, a4
sd t0, 64(sp)
mv t0, a5
sd t0, 24(sp)
mv t0, a6
sd t0, 88(sp)
mv t0, a7
sd t0, 8(sp)
#========================> PARAM a

ld a0, 56(sp)
#========================> PARAM b

ld a1, 96(sp)
#========================> CALL tmp9, __vox_add__, 2
call __vox_add__ 
sd a0, 32(sp)
#========================> PARAM tmp9

ld a0, 32(sp)
#========================> PARAM c

ld a1, 80(sp)
#========================> CALL tmp10, __vox_add__, 2
call __vox_add__ 
sd a0, 104(sp)
#========================> PARAM tmp10

ld a0, 104(sp)
#========================> PARAM d

ld a1, 40(sp)
#========================> CALL tmp11, __vox_add__, 2
call __vox_add__ 
sd a0, 0(sp)
#========================> PARAM tmp11

ld a0, 0(sp)
#========================> PARAM e

ld a1, 64(sp)
#========================> CALL tmp12, __vox_add__, 2
call __vox_add__ 
sd a0, 48(sp)
#========================> PARAM tmp12

ld a0, 48(sp)
#========================> PARAM f

ld a1, 24(sp)
#========================> CALL tmp13, __vox_add__, 2
call __vox_add__ 
sd a0, 16(sp)
#========================> PARAM tmp13

ld a0, 16(sp)
#========================> PARAM g

ld a1, 88(sp)
#========================> CALL tmp14, __vox_add__, 2
call __vox_add__ 
sd a0, 72(sp)
#========================> RETURN tmp14
ld t4, 112(sp)
ld ra, 120(sp)
ld a0, 72(sp)
addi sp, sp, 128
ret
#========================> FUN_EXIT 14
#========================> LABEL fibo
fibo:
#========================> FUN_ENTRY 15
addi sp, sp, -64
sd t4, 48(sp)
sd ra, 56(sp)
mv t0, a0
sd t0, 16(sp)
#========================> CMP a, 0, !=
ld t0, 16(sp)
li t1, 0
sub  t1, t1, t0
snez t4, t1
#========================> NOT 
xor t4, t4, 1
#========================> BRANCHEZ .L19
beqz t4, .L19
#========================> RETURN 0
ld t4, 48(sp)
ld ra, 56(sp)
li a0, 0
addi sp, sp, 64
ret
#========================> LABEL .L19
.L19:
#========================> CMP a, 1, ==
ld t0, 16(sp)
li t1, 1
sub  t1, t1, t0
seqz t4, t1
#========================> BRANCHNEZ .L21
bnez t4, .L21
#========================> CMP a, 2, ==
ld t0, 16(sp)
li t1, 2
sub  t1, t1, t0
seqz t4, t1
#========================> LABEL .L21
.L21:
#========================> BRANCHEZ .L20
beqz t4, .L20
#========================> ENV 16
addi sp, sp, -16
#========================> RETURN 1
ld t4, 64(sp)
ld ra, 72(sp)
li a0, 1
addi sp, sp, 80
ret
#========================> ENV_EXIT 16
addi sp, sp, 16
#========================> LABEL .L20
.L20:
#========================> PARAM a

ld a0, 16(sp)
#========================> PARAM 2

li a1, 2
#========================> CALL tmp15, __vox_sub__, 2
call __vox_sub__ 
sd a0, 0(sp)
#========================> PARAM tmp15

ld a0, 0(sp)
#========================> CALL tmp16, fibo, 1
call fibo 
sd a0, 40(sp)
#========================> PARAM a

ld a0, 16(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL tmp17, __vox_sub__, 2
call __vox_sub__ 
sd a0, 32(sp)
#========================> PARAM tmp17

ld a0, 32(sp)
#========================> CALL tmp18, fibo, 1
call fibo 
sd a0, 24(sp)
#========================> PARAM tmp16

ld a0, 40(sp)
#========================> PARAM tmp18

ld a1, 24(sp)
#========================> CALL tmp19, __vox_add__, 2
call __vox_add__ 
sd a0, 8(sp)
#========================> RETURN tmp19
ld t4, 48(sp)
ld ra, 56(sp)
ld a0, 8(sp)
addi sp, sp, 64
ret
#========================> FUN_EXIT 15
 
main: 
addi sp, sp, -96 
sd ra, 88(sp) 
#========================> COPY i, 4
sd zero, 56(sp)
li t0, 4
sd t0, 56(sp)
#========================> COPY j, 6
sd zero, 32(sp)
li t0, 6
sd t0, 32(sp)
#========================> PARAM 10

li a0, 10
#========================> PARAM 20

li a1, 20
#========================> CALL tmp20, add, 2
call add 
sd a0, 40(sp)
#========================> COPY j, tmp20
ld t0, 40(sp)
sd t0, 32(sp)
#========================> PARAM $str6

la a0, $str6
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM j

ld a0, 32(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM $str7

la a0, $str7
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
#========================> CALL tmp21, large, 7
call large 
sd a0, 16(sp)
#========================> PARAM tmp21

ld a0, 16(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 20

li a0, 20
#========================> CALL tmp22, fibo, 1
call fibo 
sd a0, 80(sp)
#========================> PARAM tmp22

ld a0, 80(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 7

li a0, 7
#========================> CALL tmp23, fibo, 1
call fibo 
sd a0, 64(sp)
#========================> PARAM tmp23

ld a0, 64(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 6

li a0, 6
#========================> CALL tmp24, fibo, 1
call fibo 
sd a0, 24(sp)
#========================> PARAM tmp24

ld a0, 24(sp)
#========================> CALL tmp25, fibo, 1
call fibo 
sd a0, 0(sp)
#========================> PARAM tmp25

ld a0, 0(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 6

li a0, 6
#========================> CALL tmp26, fibo, 1
call fibo 
sd a0, 8(sp)
#========================> PARAM tmp26

ld a0, 8(sp)
#========================> CALL tmp27, fibo, 1
call fibo 
sd a0, 48(sp)
#========================> CMP tmp27, 3, >
ld t0, 48(sp)
li t1, 3
slt t4, t1, t0
#========================> BRANCHEZ .L23
beqz t4, .L23
#========================> CMP 3, 4, >
li t0, 3
li t1, 4
slt t4, t1, t0
#========================> NOT 
xor t4, t4, 1
#========================> LABEL .L23
.L23:
#========================> BRANCHEZ .L22
beqz t4, .L22
#========================> ENV 17
addi sp, sp, -16
#========================> PARAM 4

li a0, 4
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> ENV_EXIT 17
addi sp, sp, 16
#========================> LABEL .L22
.L22:
#========================> PARAM $str8

la a0, $str8
#========================> PARAM 0

li a1, 0
#========================> CALL __vox_print__, 2
call __vox_print__ 
#========================> PARAM 30

li a0, 30
#========================> CALL tmp28, fibo, 1
call fibo 
sd a0, 72(sp)
#========================> PARAM tmp28

ld a0, 72(sp)
#========================> PARAM 1

li a1, 1
#========================> CALL __vox_print__, 2
call __vox_print__ 
ld ra, 88(sp)
mv a0, zero
ret
	.section .rodata
$str0: .string "ADDING"
$str1: .string "inside of first if"
$str2: .string "EREN CIKIYORUM"
$str3: .string "b: "
$str4: .string "a: "
$str5: .string "deepest nest"
$str6: .string "return value add(10,20)"
$str7: .string "fibos and larges"
$str8: .string "EREN FIBO"
