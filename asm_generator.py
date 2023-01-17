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
        if inst_type[0] == 'B':
            return self.BRANCH_to_asm(instr)
        if inst_type == 'LABEL':
            return instr[1] + ':\n'
        if inst_type == 'GOTO':
            return 'j ' + instr[1] + '\n' 
        if inst_type == 'CMP':
            return self.CMP_to_asm(instr)
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
        if type(ins[1]) != int and ins[2] != '__vox_print__':
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
        elif type(ins[2]) == str:
            value_addr_from = self.value_addr(ins[2])
            asm = [ f'ld t0, {value_addr_from}(sp)',
                    f'sd t0, {value_addr_to}(sp)']
        else:
            # handle casting here assignments for like var a = (2 > 3);
            pass
        return '\n'.join(asm) + '\n'
    def BRANCH_to_asm(self, ins):
        asm = []
        if ins[0] == 'BRANCHEZ':
            asm = [f'beqz t4, {ins[1]}']
        elif ins[0] == 'BRANCHNEZ':
            asm = [f'bnez t4, {ins[1]}']
        else:
            print("UNKNOWN BRANCHING INS ")
            exit()
        return '\n'.join(asm)+'\n'
         
    def CMP_to_asm(self, ins):
        left = ins[1]
        right = ins[2]
        op = ins[3] 
        asm = []

        if type(left) == int: 
            asm += [f'li t0, {left}']
        else:
            value_addr = self.value_addr(left)
            asm += [f'ld t0, {value_addr}(sp)']
        if type(right) == int:
            asm += [f'li t1, {right}']
        else:
            value_addr = self.value_addr(right)
            asm += [f'ld t1, {value_addr}(sp)']
        if op == "<":
            asm += [f'slt t4, t0, t1']
        elif op == ">":
            asm += [f'slt t4, t1, t0']
        elif op == ">=":
            asm += [f'slt t4, t0, t1']
            asm += [f'xor  t4, t4, 1']
        elif op == "<=":
            asm += [f'slt t4, t1, t0']
            asm += [f'xor  t4, t4, 1']
        elif op == "==":
            asm += [f'snez t4, t1, t0']
            asm += [f'xor  t4, t4, 1']
        elif op == "!=":
            asm += [f'snez t4, t1, t0']
        return '\n'.join(asm)+'\n'
        