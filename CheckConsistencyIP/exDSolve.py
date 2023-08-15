from sage.all import *
import re
import copy
load("common/utils.sage")

def getFunctionName(v):
    return re.sub('\(.*', '', re.sub('diff\(', '', repr(v)))

def dcount(v):
    return repr(v).count('t') - getFunctionName(v).count('t') - 1

def makePrev(v):
    return SR('prev_' + getFunctionName(v) + str(dcount(v)))

def getVars(l):
    # print(l)
    return [v for v in l if dcount(v) == 0]

def applyList(l):
    if type(l) == list:
        return(l)
    else:
        return([l])

def getFunc(e, vs):
    res = []
    for vi in vs:
        if str(vi) in str(e):
            res.append(vi)
    return res

def isVar(e, vs):
    return e in vs

def hasVar(e, vs):
    res = False
    for v in vs:
        res |= str(v) in str(e)
    return res

def isEq(e):
    return e.operator().__name__ == 'eq'

def findFunction(e, l):
    for li in l:
        if str(li) in str(e):
            return li
    assert False

def solveByDSolve(expr, vars):
    print('call solveByDSolve')
    solvars = list(filter(lambda v: str(v) in str(expr), getVars(vars)))
    # solvars = getVars(vars)
    print("expr=",str(expr),"solvars=",solvars)
    prevs = list(map(makePrev, list(filter(lambda v: str(
        v.derivative(1)) in str(expr), solvars))))
    print("prevs=",prevs)
    # debugPrint(solvars, prevs)

    sol = []
    ei = 0
    while ei < len(expr[0]):
        eachCons = expr[0][ei]
        print("eachCons=",eachCons)
        print("solvars=",solvars)
        if(isVar(eachCons.rhs(), solvars)):
            eachCons = (eachCons.rhs() == eachCons.lhs())
            print("eachCons1=",eachCons)
        if(isVar(eachCons.lhs(), solvars) and not hasVar(eachCons.rhs(), solvars)):
            sol.append(eachCons)
            print("sol=",sol)
            expr[0].pop(ei)
            solvars.remove(eachCons.lhs())
            expr[0] = list(map(lambda e: e.subs(eachCons), expr[0]))
            ei = -1
        ei += 1
    print("ODE=",expr[0],"vars=",solvars,'ics=',[0]+prevs)
    tmpsol = desolve_system(expr[0], solvars, ics= [0]+ prevs)
    print('tmpsol=',tmpsol)
    print('sol=',sol)
    if type(tmpsol) != list:
        tmpsol = [findFunction(expr, solvars) == tmpsol]
    # debugPrint(tmpsol)
    sol += tmpsol
    print('sol=',sol)
    return sol


def exDSolve(expr, prevRs, vars):
    print('call exDSolve')
    # debugPrint(expr, prevRs, vars)
    listExpr = copy.copy(expr)
    print('listExpr=',listExpr)
    resultCons = [[s for s in t if not isEq(s)] for t in listExpr]
    listExpr = [[s for s in t if isEq(s)] for t in listExpr]
    print("resultCons=",resultCons)
    print("listExpr=",listExpr)
    resultRule = solveByDSolve(listExpr, vars)
    print("resultRule=",resultRule)

    if len(resultRule) == 0:
        return 'overConstrained'
    elif type(resultRule).__name__ == 'list':
        print("prevRs=",prevRs)
        resultRule = [s.subs(prevRs) for s in resultRule]
        print("resultRule=",resultRule)
    else:
        resultRule = resultRule.subs(prevRs)
    # debugPrint(resultCons, resultRule)
    retCode = 'underConstrained' if len(
        resultRule) > len(getVars(vars)) else 'solved'
    print("resultCons=",resultCons)
    if type(resultCons) == list:
        resultCond = []
        for s in resultCons:
            if type(s) == list:
                resultCond.append(list(map(lambda e: e.subs(resultRule), s)))
            else:
                resultCond.append(s.subs(resultRule))
    else:
        resultCond = resultCons.subs(resultRule)
        # debugPrint(resultCond)
    # with assuming(t > 0):
    resultCond = [simplify(s) for s in resultCond]
    return(retCode, resultCond, resultRule)