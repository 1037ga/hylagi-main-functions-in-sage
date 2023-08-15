#from compiler.ast import flatten
from itertools import chain, product
load("../common/utils.sage")

qf = qepcad_formula

def asExpr(expr):
    result = parseQepcadConstraint(expr)
    print({"evalQE":result})
    print({"return":result[0][0]})
    return result

def evalQE(qeExpr):
    return asExpr(qepcad(qeExpr))

def IsEqual(expr):
    return expr.operator().__str__() == "<built-in function eq>"

def AnyExpr(func, expr):
    if func(expr):
        return true
    if expr.operator() != None:
        return AnyExpr(func, expr.lhs()) or AnyExpr(func, expr.rhs())
    return false

def IsSolved(expr):
    childlen = expr.operands()
    if len(childlen) == 2: return false
    return childlen[0].operands() == [] and childlen[1].operands() == []

def IsUnderconstrained(sol):
    rhs = sol.rhs().operands()
    return len(rhs) == 1 and not rhs[0].is_constant()

optSolveOverReals = true
def solveOverRorC(consToSolve, varList):
    result = []
    if optSolveOverReals:
        result = solve(consToSolve, varList, domain='real')
    else:
        result = solve(consToSolve, varList)
    if result == []: return [[]]
    if type(result[0]) != type([]):
        result = [result]
    return result

# listA = [[x==1,y==2],[x==3,y==4]], listB = [[z==5]]
# getProduct(listA, listB) returns [[x==1,y==2,z==5],[x==3,y==4,z==5]]
def getProduct(listA, listB):
    groups = list(itertools.product(listA, listB))
    temp = []
    for group in groups: temp.extend([list(itertools.chain.from_iterable(group))])
    return temp

def trySolve(consList, varList):
    print({"cons ":consList, "vars":varList})
    isVariable = lambda term: any(var == term for var in varList)
    sol = true
    solved = false
    trivialConsList = []
    consToSolve = consList
    inequalities = []
    #And only
    if len(consList) == 1:
        andList = consList[0]
        consToSolve = filter(IsEqual, andList)
        inequalities = filter(lambda e: not IsEqual(e), andList)
        print({"inequalities":inequalities})
        inequalities = solve(inequalities, varList)
        if len(inequalities) == 1:
            inequalities = list(chain.from_iterable(inequalities))
            inequalities = filter(lambda e: IsSolved(e) and not IsUnderconstrained(e), inequalities)
        print({"inequalities sol":inequalities})
        print({"consToSolve before":consToSolve})
        i = 0
        while i < len(consToSolve):
            eachCons = consToSolve[i]
            if IsEqual(eachCons):
                print({"lhs":isVariable(eachCons.lhs()), "rhs":isVariable(eachCons.rhs())})
                #swap lhs and rhs if rhs is variable
                if isVariable(eachCons.rhs()):
                    eachCons = (eachCons.rhs() == eachCons.lhs())
                if isVariable(eachCons.lhs()) and not isVariable(eachCons.rhs()):
                    trivialConsList.append(eachCons)
                    consToSolve.pop(i)
                    consToSolve = map(lambda elem: elem.subs({eachCons.lhs():eachCons.rhs()}), consToSolve)
                    i = 0 
                print({"eachCons":eachCons})
            else:
                print("is not equal")
            i += 1
    print({"consToSolve":consToSolve})
    if all(IsEqual(expr) for expr in consToSolve):
        print({"solveOverRorC":consToSolve})
        sol = solveOverRorC(consToSolve, varList)
        print({"sol":sol})
        #if len(sol) == 1: sol = list(chain.from_iterable(sol))
        # has no condition
        if len(sol) == 1 and len(inequalities) <= 1:
            solved = true
    if not solved:
        sol = consToSolve
    result = [trivialConsList]
    #print({"temp":result})
    if len(sol) != 0:
        if len(sol) == 1: result = getProduct(result, [sol])
        else: result = getProduct(result, [sol])
    #print({"temp":result})
    if len(inequalities) != 0:
        if len(inequalities) == 1: result = getProduct(result, [inequalities])
        else: result = getProduct(result, inequalities)
    print({"trivialConsList":trivialConsList,"sol":sol,"inequalities":inequalities,"result":result})
    return [result, solved]

def checkConsistencyPP(initSubstitutedList, parList):
    varList = getVariables(initSubstitutedList)
    [sol, solved] = trySolve(initSubstitutedList, varList)
    cpTrue = []
    cpFalse = []
    print({"sol":sol, "solved":solved})
    if solved:
        if sol == []:
            cpTrue = false
            cpFalse = true
        else:
            cpTrue = sol
            cpFalse = false
    else:
        print("checkConsistencyByQE")
        [cpTrue, cpFalse] = checkConsistencyPPByQE(initSubstitutedList, parList)
    return [cpTrue, cpFalse]

x, y, p_1 = var('x y p_1')


#print("--------------")
#a = checkConsistencyPP([x==y+1, y==x+1], [0<=p1, p1<=1])
#print({"return":a})

#print("--------------")
#a = checkConsistencyPP([x==3+2*y, x==(p1+5)/7, y==(p1+7)/11], [1<=p1, p1<=20])
#print({"return": a})

#print("--------------")
#a = checkConsistencyPP([x==1+p1^2, y==p1+3*p1^3], [0<=p1, p1<=1])
#print({"return":a})

#print("--------------")
#a = checkConsistencyPP([2*x + 3*y == 10, x + 5*y == 7], [])

print("--------------")
a = checkConsistencyPP([[2*x - 5 == 6]], [[]])
#a = checkConsistencyPP([[2*x - y == 1, x + 2*y == 7]], [[]])

#x, y, p_1 = var('x y p_1')
#a = checkConsistencyPP([p_1 < 5], [0 <= p_1, p_1 <= 10])
#a = checkConsistencyPP([x == 1], [p_1 - 11 < 0, p_1 - 10 > 0])
#print(a)
#print({"return":a, "result":parseQepcadConstraint(a)})

#expr = p_1 == 5
#print(expr.operator())

#a = checkConsistencyPP2([[p_1 == 5, 10 == x, 0<=p_1, p_1 != 10]], [[0 <= p_1, p_1 <= 10]])

#x, y, z, p_1 = var('x y z p_1')
#a = checkConsistencyPP2([[x^2+y^2==z^2,x + 1 == y, 2 * x == y, y + z == 5 + x]], [[0 <= p_1, p_1 <= 10]])
