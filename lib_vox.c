#include "lib_vox.h"
#include <stdio.h>
#include <stdlib.h>

long __vox_add__(long a, long b)
{
    return a + b;
}

long __vox_sub__(long a, long b)
{
    return a - b;
}
long __vox_mul__(long a, long b)
{
    return a * b;
}

long __vox_div__(long a, long b)
{
    if(b == 0)
    {
        puts("Runtime: division by zero");
        exit(1);
    }
    return a/b;
}
void __vox_print__(long a)
{
    printf("%ld\n", a);
}
void __vox_puts__(long str)
{
    char * p = (char*) str;
    puts(p);
}