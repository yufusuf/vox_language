from il_generator import *
from asm_generator import *
import argparse

import sys

file_name = sys.argv[1]

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument('source_file')
arg_parser.add_argument('--show_il', action='store_true')
args = arg_parser.parse_args()

def il_ins_to_str(ins):
    return ins[0]+" "+", ".join([str(elem) for elem in ins[1:] if elem is not None])

with open(args.source_file, 'r') as f:
    source = f.read()
    il, f_il, places, strings = GenerateIntermediate(source).get_intermediate_code()
    for i in range(len(places)):
        stack_size = len(places[i].table)*8 + 16
        places[i].table = {places[i].table:addr for (places[i].table, addr) in zip(places[i].table, range(0, stack_size - 8, 8))}
    for i in range(len(places)):
        print(i, places[i].table)
    with open('asm_vox.s', 'w') as f:
        stack_size = len(places[0].table)*8 + 8
        asm_code = f' #include "lib_vox.h"\n\n\t.global main \n\t.text \n\t.align 2\n' 
        f.write(asm_code)
        asm_code = ''
        asm_gen = GenerateAsm(places)
        for f_ins in f_il:
            asm_code += '#========================> ' + il_ins_to_str(f_ins) + '\n'
            asm_code += asm_gen.il_to_asm(f_ins)
        f.write(asm_code)
        f.write(f' \nmain: \naddi sp, sp, -{stack_size} \nsd ra, {stack_size - 8}(sp) \n')
        asm_code = ''
        for ins in il:
            asm_code += '#========================> ' + il_ins_to_str(ins) + '\n'
            asm_code += asm_gen.il_to_asm(ins)
        f.write(asm_code)
        asm_code = f'ld ra, {stack_size - 8}(sp)\nmv a0, zero\nret\n\t.section .rodata\n'
        f.write(asm_code)

        for s in strings:
            f.write(f'{s}: .string \"{strings[s]}\"\n')

    if args.show_il:
        print("FUNS")
        for l in f_il:
            print(l)
        print("MAIN")
        for l in il:
            print(l)