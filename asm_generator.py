class GenerateAsm:
    def __init__(self, addr_table):
        self.addr_table = addr_table
        self.sp_offset = 0 # will use later
        self.arg_reg_count = 0
    def value_addr(self, place):
        return str(self.addr_table[place])
    def il_to_asm(self, instr):
        inst_type = instr[0]
        if inst_type == 'CALL':
           return self.CALL_to_asm(instr) 
        if inst_type == 'PARAM':
            return self.PARAM_to_asm(instr)
        if inst_type == 'COPY':
            return self.COPY_to_asm(instr) 
        else:
            return f'wtf is {inst_type}' 
    def PARAM_to_asm(self, ins):
        asm = ['']
        if self.arg_reg_count == 8:
            print("cant have more than 7 args to a funct") 
            exit()
        if type(ins[1]) == int:
            asm.extend([f'li a{str(self.arg_reg_count)}, {ins[1]}'])
        else:
            value_addr = self.value_addr(ins[1])
            asm.extend([f'ld a{str(self.arg_reg_count)}, {value_addr}(sp)'])
        self.arg_reg_count += 1 

        return '\n'.join(asm) + '\n'
    def CALL_to_asm(self, ins):
        asm = [f'call {ins[2]} ']
        value_addr = self.value_addr(ins[1])
        asm.extend([f'sd a0, {value_addr}(sp)'])

        self.arg_reg_count = 0 # reset arg reg
        return '\n'.join(asm) + '\n'
    def COPY_to_asm(self, ins):
        value_addr_to = self.value_addr(ins[1])
        if type(ins[2]) == int:
            asm = [ f'sd zero, {value_addr_to}(sp)',
                    f'li t0, {ins[2]}',
                    f'sd t0, {value_addr_to}(sp)']
        else:
            value_addr_from = self.value_addr(ins[2])
            asm = [ f'ld t0, {value_addr_from}(sp)',
                    f'sd t0, {value_addr_to}(sp)']
        return '\n'.join(asm) + '\n'