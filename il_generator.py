from ast_tools import *
from parser_1 import *
from lexer import *

class Env:
    def __init__(self, prev = None, isfunction = False):
        self.prev = prev
        self.table = set()
        self.fvars =[]
        self.isfunction = isfunction
    def member(self, elem):
        return elem in self.table
    
    def recursive_member(self, elem):
        if elem in self.table:
            return True
        elif self.prev is not None:
            return self.prev.recursive_member(elem)

        return False
    
    def add(self, elem):
        self.table.add(elem)
    def add_fvar(self, var):
        self.fvars.append(var)
    def size(self):
        return len(self.table)*8 + 16
op_names = {"+": "add", "*": "mul", "/": "div", "-": "sub"}
class GenerateIntermediate(ASTNodeVisitor):
    def __init__(self, source):
        super().__init__()
        self.ast = Parser().parse(Lexer().tokenize(source))
        self.intermediate = []
        self.places = set()
        self.tmp_count = 0
        self.label_count = 1
        self.funs =[]

        self.env = Env(None)
        self.envs = [self.env]

        self.const_strs = {}
        self.str_count = 0
    def generate_temp(self):
        tmp = f'tmp{self.tmp_count}'
        self.tmp_count+=1
        self.env.add(tmp)
        return tmp
    def generate_str_label(self, value):
        for s in self.const_strs:
            if self.const_strs[s] == value:
                return s
        strr = f'$str{self.str_count}'
        self.str_count += 1
        self.const_strs[strr] = value
        return strr
    def generate_label(self):
        lbl = f'.L{self.label_count}'
        self.label_count += 1
        return lbl
    def get_current_label(self):
        return f'.L{self.label_count}'
    def get_intermediate_code(self):
        print(PrintVisitor().visit(self.ast))
        self.visit(self.ast)
        return self.intermediate, self.funs,self.envs , self.const_strs

    def visit_Program(self, program: Program):
        for var in program.var_decls:
            self.visit(var)
        temp = self.intermediate
        self.intermediate = []
        for fun in program.fun_decls:
            self.visit(fun)
        self.funs = self.intermediate
        self.intermediate = temp
        for stmt in program.statements:
            self.visit(stmt)

    def check_undeclared(self, name):
        return self.env.recursive_member(name)
    def visit_VarDecl(self, vardecl: VarDecl):
        self.env.add(vardecl.identifier.name)
        if vardecl.initializer != None:
            if type(vardecl.initializer) == list:
                for elem in vardecl.initializer:
                    self.visit(elem)
            else:
                tmp = self.visit(vardecl.initializer)
                self.intermediate.extend([('COPY', vardecl.identifier.name, tmp)])

    def visit_nonscoped(self, body):
        for decl in body.var_decls:
            self.visit(decl)
        for stmt in body.statements:
            self.visit(stmt)
    def visit_Variable(self, variable: Variable):
        if self.check_undeclared(variable.identifier.name) == False and variable.identifier.name not in self.env.fvars:
            print(f"Error, undeclared variable {variable.identifier}")
            exit()
        return variable.identifier.name


    def visit_ABinary(self, abinary: ABinary):
        t1 = self.visit(abinary.left)
        t2 = self.visit(abinary.right)
        place = self.generate_temp()
        self.intermediate.extend([('PARAM', t1),
                                  ('PARAM', t2),
                                 ('CALL', place, f'__vox_{op_names[abinary.op]}__', 2)])
        return place

    def visit_ALiteral(self, aliteral: ALiteral):
        return int(aliteral.value)
    def visit_Assign(self, assign: Assign):
        t1 = self.visit(assign.expr)
        self.intermediate.extend([('COPY', assign.identifier.name, t1)])

    def visit_AUMinus(self, auminus: AUMinus):
        t1 = self.visit(auminus.right)
        if type(t1) == int:
            return -int(t1)
        else:
            self.intermediate.extend([('NEG', t1)])
            return t1;
    def visit_Block(self, block: Block):
        self.env = Env(self.env)
        self.envs.append(self.env)
        self.intermediate.extend([('ENV', self.envs.index(self.env))])
        self.visit_nonscoped(block)
        self.intermediate.extend([('ENV_EXIT', self.envs.index(self.env))])
        self.env = self.env.prev
    def visit_Comparison(self, comparison: Comparison):
        t1 = self.visit(comparison.left)
        t2 = self.visit(comparison.right)
        self.intermediate.extend([('CMP',  t1, t2, comparison.op)])
    def visit_IfElse(self, ifelse: IfElse):
        if ifelse.else_branch == None:
            lbl = self.generate_label()
            self.visit(ifelse.condition)
            self.intermediate.extend([('BRANCHEZ', lbl)])
            self.visit(ifelse.if_branch)
            self.intermediate.extend([('LABEL', lbl)])
        else:
            lbl1 = self.generate_label()
            lbl2 = self.generate_label()
            self.visit(ifelse.condition)
            self.intermediate.extend([('BRANCHEZ', lbl1)])
            self.visit(ifelse.if_branch)
            self.intermediate.extend([('GOTO', lbl2), ('LABEL', lbl1)])
            self.visit(ifelse.else_branch)
            self.intermediate.extend([('LABEL', lbl2)])
        
    def visit_LBinary(self, lbinary: LBinary):
        out = self.generate_label()
        self.visit(lbinary.left) 
        self.intermediate.extend([(['BRANCHEZ','BRANCHNEZ'][lbinary.op == 'or'], out)])
        self.visit(lbinary.right)
        self.intermediate.extend([('LABEL', out)])

    def visit_LLiteral(self, lliteral: LLiteral):
        return lliteral.value
    def visit_LNot(self, lnot: LNot):
        t1 = self.visit(lnot.right)
        self.intermediate.extend([('NOT', t1)])
        return t1
    def visit_LPrimary(self, lprimary: LPrimary):
        pass
    def visit_WhileLoop(self, whileloop: WhileLoop):
        check = self.generate_label()
        out = self.generate_label()
        self.intermediate.extend([('LABEL', check)])
        self.visit(whileloop.condition)
        self.intermediate.extend([('BRANCHEZ', out)])
        self.visit(whileloop.body)
        self.intermediate.extend([('GOTO', check)])
        self.intermediate.extend([('LABEL', out)])
        
    def visit_Print(self, printt: Print):
        t1 = self.visit(printt.expr)
        if type(t1) == str and t1[0] == '$':
            self.intermediate.extend([('PARAM', t1), ('PARAM', 0) ,('CALL', None, '__vox_print__', 2)])
        else:
            self.intermediate.extend([('PARAM', t1), ('PARAM', 1), ('CALL', None, '__vox_print__', 2)])
    def visit_Return(self, returnn: Return):
        t1 = self.visit(returnn.expr)

        self.intermediate.extend([('RETURN', t1)])
    def visit_SetVector(self, setvector: SetVector):
        return super().visit_SetVector(setvector)
    def visit_ErrorStmt(self, errorstmt: ErrorStmt):
        return super().visit_ErrorStmt(errorstmt)
    def visit_ForLoop(self, forloop: ForLoop):
        self.visit(forloop.initializer)
        check = self.generate_label()
        out = self.generate_label()
        self.intermediate.extend([('LABEL', check)])
        self.visit(forloop.condition)
        self.intermediate.extend([('BRANCHEZ', out)])
        self.visit(forloop.body)
        self.visit(forloop.increment)
        self.intermediate.extend([('GOTO', check)])
        self.intermediate.extend([('LABEL', out)])
    def visit_FunDecl(self, fundecl: FunDecl):
        self.env = Env(self.env, True)
        self.envs.append(self.env)
        self.intermediate.extend([('LABEL', fundecl.identifier.name),('FUN_ENTRY', self.envs.index(self.env))])
        for v in fundecl.params:
            self.env.add(v.name)
            self.env.add_fvar(v.name)
        self.visit_nonscoped(fundecl.body)
        self.intermediate.extend([('FUN_EXIT', self.envs.index(self.env))]) 
        self.env = self.env.prev

    def visit_Call(self, calll: Call):
        places = []
        for a in calll.arguments:
            t1 = self.visit(a)
            places.append(t1)
        for p in places:
            self.intermediate.extend([('PARAM',p)])
        place = self.generate_temp()
        self.intermediate.extend([('CALL', place, calll.callee.name, len(calll.arguments))])
        return place
    def visit_GetVector(self, getvector: GetVector):
        return super().visit_GetVector(getvector)
    def visit_SLiteral(self, sliteral: SLiteral):
        strr = self.generate_str_label(sliteral.value)
        return strr
