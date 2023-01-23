from il_generator import Env
class GenerateAsm:
    def __init__(self, envs:Env):
        self.envs = envs
        self.arg_reg_count = 0
        self.env_id = 0
        self.current_e:Env = self.envs[0]
        self.offsets = [0]
        self.sp_offset = 0
        self.last_offset = 0;
    def value_addr(self, place):
        if self.current_e.member(place):
            return str(self.current_e.table[place])
        else:
            offs = 0
            e = self.current_e
            while(e and e.member(place) == False):
                offs += e.size()
                e = e.prev
            if not e:
                print(f"{place}: was not found anywhere error")
                exit()
            return str(offs + e.table[place]) 
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
        if inst_type =='FUN_ENTRY':
            return self.FUN_to_asm(instr)
        if inst_type == 'ENV':
            return self.ENV_to_asm(instr)
        if inst_type == 'ENV_EXIT':
            return self.ENVEXIT_to_asm(instr)
        if inst_type == 'RETURN':
            return self.RET_to_asm(instr)
        if inst_type == 'FUN_EXIT':
            return self.FUNEXIT_to_asm(instr)
        #TODO add neg and not
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
        if type(ins[1]) != int and ins[1] != None:
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
        elif ins[2] == None:
            asm = [f'sd t4, {value_addr_to}(sp)'] 
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
            asm += [f'sub  t1, t1, t0']
            asm += [f'seqz t4, t1']
        elif op == "!=":
            asm += [f'sub  t1, t1, t0']
            asm += [f'snez t4, t1']
        return '\n'.join(asm)+'\n'
    def FUN_to_asm(self, ins):
        self.env_id = ins[1]
        self.current_e = self.envs[self.env_id]
        var_count = len(self.current_e.table)

        self.last_offset = (var_count + 2) * 8
        self.sp_offset += (var_count + 2) * 8
        ra_offset = (var_count + 1) * 8
        t4_offset = var_count * 8

        asm = [f'addi sp, sp, -{(var_count + 2)*8}',
               f'sd t4, {t4_offset}(sp)',
               f'sd ra, {ra_offset}(sp)' ]
        for i in range(len(self.current_e.fvars)):
            asm += [f'mv t0, a{i}',
                   f'sd t0, {self.value_addr(self.current_e.fvars[i])}(sp)']
        return '\n'.join(asm)+'\n'

    def ENV_to_asm(self, ins):
        self.env_id = ins[1]
        self.current_e = self.envs[self.env_id]
        self.sp_offset += self.current_e.size() 
        asm = [f'addi sp, sp, -{self.current_e.size()}']
        return '\n'.join(asm)+'\n'
    def ENVEXIT_to_asm(self, ins):
        self.current_e = self.envs[ins[1]]
        self.sp_offset -= self.current_e.size() 
        asm = [f'addi sp, sp, {self.current_e.size()}']
        self.current_e = self.current_e.prev
        return '\n'.join(asm)+'\n'
    def RET_to_asm(self, ins):
        outer_offset = 0
        e = self.current_e
        while(not e.isfunction):
            outer_offset += e.size() 
            e = e.prev
        outer_offset += e.size() 
        if type(ins[1]) != int:
            return_what = self.value_addr(ins[1])
            asm = [
                    f'ld t4, {outer_offset - 16}(sp)',
                    f'ld ra, {outer_offset - 8}(sp)',
                    f'ld a0, {return_what}(sp)',
                    f'addi sp, sp, {outer_offset}',
                    f'ret'
                ]
        else:
            asm = [
                    f'ld t4, {outer_offset - 16}(sp)',
                    f'ld ra, {outer_offset - 8}(sp)',
                    f'li a0, {ins[1]}',
                    f'addi sp, sp, {outer_offset}',
                    f'ret'
                ]
        self.sp_offset -= e.size()
        return '\n'.join(asm)+'\n'
    def FUNEXIT_to_asm(self, ins):
        self.current_e = self.envs[0]
        return ''

