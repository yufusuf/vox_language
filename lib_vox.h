#ifndef LIB_VOX_H
#define LIB_VOX_H


struct vox_object{
    long value;
};

long __vox_add__(long a, long b);
long __vox_mul__(long a, long b);
long __vox_div__(long a, long b);
long __vox_sub__(long a, long b);
void __vox_print__(long a, long b);
void __vox_puts__(long str);
#endif