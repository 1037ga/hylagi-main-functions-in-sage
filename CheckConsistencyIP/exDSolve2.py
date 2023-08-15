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
    # print(expr[0][0])
    print(61)
    # solvars = list(filter(lambda v: str(v) in str(expr), getVars(vars)))
    print(vars)
    solvars = getVars(vars)
    print(64)

    print(solvars)
    # debugPrint(expr, vars)
    # print(filter(lambda v: str(
    #     v.derivative(1)) in str(expr), solvars))
    # print(map(makePrev, filter(lambda v: str(
    # v.derivative(1)) in str(expr), solvars)))
    print(65)
    prevs = map(makePrev, filter(lambda v: str(
        v.derivative(1)) in str(expr), solvars))

    print(68)
    # debugPrint(solvars, prevs)

    sol = []
    ei = 0
    while ei < len(expr[0]):
        print(84)
        eachCons = expr[0][ei]
        print(86)
        print(eachCons)
        print(87)
        if(isVar(eachCons.rhs(), solvars)):
            print(88)
            eachCons = (eachCons.rhs() == eachCons.lhs())
            print(90)
        if(isVar(eachCons.lhs(), solvars) and not hasVar(eachCons.rhs(), solvars)):
            print(92)
            sol.append(eachCons)
            print(94)
            expr[0].pop(ei)
            solvars.remove(eachCons.lhs())
            expr[0] = list(map(lambda e: e.subs(eachCons), expr[0]))
            ei = -1
        ei += 1
    # debugPrint(solvars, sol)
    # debugPrint(expr[0], solvars, prevs)
    tmpsol = desolve_system(expr[0], solvars, ics=[0] + prevs)
    if type(tmpsol) != list:
        tmpsol = [findFunction(expr, solvars) == tmpsol]
    # debugPrint(tmpsol)
    sol += tmpsol
    return sol


def exDSolve(expr, prevRs, vars):
    # debugPrint(expr, prevRs, vars)
    print(93)
    listExpr = copy.deepcopy(expr)
    print(listExpr)
    print(95)
    resultCons = [[s for s in t if not isEq(s)] for t in listExpr]
    print(97)
    listExpr = [[s for s in t if isEq(s)] for t in listExpr]
    print(99)
    # debugPrint(vars, getVars(vars))
    resultRule = solveByDSolve(listExpr, vars)
    # debugPrint(resultRule)

    if len(resultRule) == 0:
        return 'overConstrained'
    elif type(resultRule).__name__ == 'list':
        resultRule = [s.subs(prevRs) for s in resultRule]
    else:
        resultRule = resultRule.subs(prevRs)
    # debugPrint(resultCons, resultRule)
    retCode = 'underConstrained' if len(
        resultRule) > len(getVars(vars)) else 'solved'
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
