from il_generator import *
from asm_generator import *
def il_ins_to_str(ins):
    return ins[0]+" "+", ".join([str(elem) for elem in ins[1:] if elem is not None])
while True:
    try:
        source = input('> ')
        il,places, strs = GenerateIntermediate(source).get_intermediate()
        stack_size = len(places)*8 + 8
        addr_table = {place:addr for (place, addr) in zip(places, range(0, stack_size - 8, 8))}
        print("addr table: ", addr_table)
        with open('asm_vox.s', 'w') as f:
            asm_code = f' #include "lib_vox.h"\n\n.global main \n.text \n.align 2 \nmain: \naddi sp, sp, -{stack_size} \nsd ra, {stack_size - 8}(sp) \n' 
            f.write(asm_code)
            asm_code = ''
            asm_gen = GenerateAsm(addr_table)
            for ins in il:
                asm_code += '         # ' + il_ins_to_str(ins) + '\n'
                asm_code += asm_gen.il_to_asm(ins)
            f.write(asm_code)
            asm_code = f'\nld ra, {stack_size - 8}(sp)\nmv a0, zero\nret\n.data\n'
            f.write(asm_code)
            for s in strs:
                f.write(f'{s}: .ascii \"{strs[s]}\"\n')

        # print(asm_code) 
        break
    except EOFError:
        break