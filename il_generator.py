from ast_tools import *
from parser_1 import *
from lexer import *


op_names = {"+": "add", "*": "mul", "/": "div", "-": "sub"}
class GenerateIntermediate(ASTNodeVisitor):
    def __init__(self, source):
        super().__init__()
        self.ast = Parser().parse(Lexer().tokenize(source))
        self.intermediate = []
        self.places = set()
        self.tmp_count = 0
        self.label_count = 1
        self.labels = []

    def generate_temp(self):
        tmp = f'tmp{self.tmp_count}'
        self.tmp_count+=1
        self.places.add(tmp)
        return tmp
    # def generate_str_label(self, value):
    #     strr = f'str{self.str_count}'
    #     self.str_count += 1
    #     self.const_strs[strr] = value
    #     return strr
    def generate_label(self):
        lbl = f'.L{self.label_count}'
        self.label_count += 1
        return lbl
    def get_current_label(self):
        return f'.L{self.label_count}'
    def get_intermediate_code(self):
        print(PrintVisitor().visit(self.ast))
        self.visit(self.ast)
        return self.intermediate, self.places #, self.const_strs

    def visit_Program(self, program: Program):
        for var in program.var_decls:
            self.visit(var)
        # for fun in program.fun_decls:
        #     self.visit(fun)
        for stmt in program.statements:
            self.visit(stmt)


    def visit_VarDecl(self, vardecl: VarDecl):
        if vardecl.initializer == None:
            self.places.add(vardecl.identifier.name)
        elif type(vardecl.initializer) == list:
            self.places.add(vardecl.identifier)
            for elem in vardecl.initializer:
                self.visit(elem)
        else:
            self.places.add(vardecl.identifier.name)
            tmp = self.visit(vardecl.initializer)
            self.intermediate.extend([('COPY', vardecl.identifier.name, tmp)])

    def visit_Variable(self, variable: Variable):
        if variable.identifier.name not in self.places:
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
        return -int(t1)
    def visit_Block(self, block: Block):
        for stmt in block.statements:
            self.visit(stmt)
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
            self.labels.append(self.generate_label())
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
        #TODO
        return  self.visit(lnot.right) 
    def visit_LPrimary(self, lprimary: LPrimary):
        #TODO
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
        if type(t1) == float:
            t1 = int(t1)
        self.intermediate.extend([('PARAM', t1), ('CALL', t1, '__vox_print__', 1)])
    def visit_Return(self, returnn: Return):
        return super().visit_Return(returnn)
    def visit_SetVector(self, setvector: SetVector):
        return super().visit_SetVector(setvector)
    def visit_ErrorStmt(self, errorstmt: ErrorStmt):
        return super().visit_ErrorStmt(errorstmt)
    def visit_ForLoop(self, forloop: ForLoop):
        return super().visit_ForLoop(forloop)
    def visit_FunDecl(self, fundecl: FunDecl):
        return super().visit_FunDecl(fundecl)
    def visit_Call(self, calll: Call):
        return super().visit_Call(calll)
    def visit_GetVector(self, getvector: GetVector):
        return super().visit_GetVector(getvector)
    def visit_SLiteral(self, sliteral: SLiteral):
        pass
        # strr = self.generate_str_label(sliteral.value)
        # return strr
