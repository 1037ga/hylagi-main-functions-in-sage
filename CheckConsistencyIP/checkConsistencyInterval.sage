import re
from functools import reduce
load("common/utils.sage")
load("CheckConsistencyIP/exDSolve.py")


def makePrevVar(v):
    name = re.sub('\(.*', '', re.sub('diff\(', '', repr(v)))
    dcount = len(re.findall('t', repr(v))) - 1
    return SR('prev_' + name + str(dcount))


def d(e, c):
    return diff(e, t, c)


def createDifferentiatedEquations(vs, l):
    res = copy.copy(l)
    for li in l:
        dcount = 1
        while d(li.lhs(), dcount) in vars:
            res.append(d(li.lhs(), dcount) == d(li.rhs(), dcount))
            dcount += 1
    return res


def checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars):
    pcs = prevCons + pCons
    qf = qepcad_formula
    print('qf=',qf)
    if cons is True:
        return [pcs, SR(False)]
    else:
        assume(assum)
        print('vars=',vars)
        print('cons=',cons)
        sol = exDSolve(cons, prevRs, vars)
        # sol = ('solved',[[t^2 == 2, t*prev_x10 >= 10],[t^2 == 2, t*prev_x10 <= 7], [5*t^2 == 17]],[x == t*prev_x10, y == 10 - 5*t^2, x1 == prev_x10, y1 == -10*t])
        # sol = ('solved', [[]], [c(t) == 1, r0(t) == 1, rc(t) == 1, vc(t) == prev_vc0/e^(t/2)])
        # sol = ('solved', [[prev_x0 > 0]], [x == prev_x0])
        print('sol=',sol)
        if sol == 'overConstrained':
            return [SR(False), pcs]
        else:
            tRules = createDifferentiatedEquations(vars, sol[2])
            print('tRules=',tRules)
            tRulesAtZero = list(map(lambda e: e.subs(t == 0), sol[2]))
            print('tRulesAtZero=',tRulesAtZero)
            print("initCons=",initCons)
            substitutedInit = list(map(lambda e: e.subs(prevRs), initCons))
            print('substitutedInit=',substitutedInit)

            flag = True
            for si in substitutedInit:
                tmp = bool(si.subs(tRulesAtZero))
                flag &= tmp
                print('tmp=',tmp)
            # debugPrint(flag)
            if flag is False:
                return [SR(False), pcs]

            tCons = list(map(lambda l: list(map(lambda e: e.subs(tRules), l)), sol[1]))
            print('tCons=',tCons)
            print('pcs=',pcs)
            print(getParameters(pcs),getPrevVariables(pcs))
            ps = getParameters(pcs) + getPrevVariables(pcs)
            print('ps=',ps)
            cpTrue = []
            print(76)
            for tci in tCons:
                tmpcond = copy.copy(pcs)
                print('71 tmpcond=',tmpcond)
                tmpcond.extend(tci)
                print('73 tmpcond=',tmpcond)
                tmpcond = list(map(lambda e: e.subs(t == 0), tmpcond))
                # tmpcond = list(map(lambda e: e.subs(substitutedInit), tmpcond))
                tmpvars = getPrevVariables(tmpcond)
                # tmpvars = list(set(tmpvars) - set(ps))
                print('tmpvars=',tmpvars,'tmpcond=',tmpcond)
                print(qf.and_(tmpcond))
                print(1)
                print(qf.exists(tmpvars, qf.and_(tmpcond)))
                print(2)
                tmpcond = qepcad(qf.exists(tmpvars, qf.and_(tmpcond)))
                print(tmpcond)
                tmpcond = parseQepcadConstraint(tmpcond)
                print("86 tmpcond=",tmpcond)
                # debugPrint(tmpcond)
                if type(tmpcond) == list:
                    reduce(list.extend, tmpcond, cpTrue)
                    print("cpTrue=",cpTrue)
                else:
                    cpTrue.append(tmpcond)
            # debugPrint(cpTrue)

            if 0 in cpTrue:
                return [SR(False), pcs]
            elif cpTrue.count(1) == len(cpTrue):
                return [SR(True), pcs]
            else:
                cpTrue = list(filter(lambda l: l != 1, cpTrue))
            print("cpTrue=",cpTrue)

            tmpcond = qf.and_(qf.not_(qf.and_(cpTrue)), pcs)
            print("tmpcond=",tmpcond)
            tmpvars = getPrevVariables(list(map(SR, cpTrue + pcs)))
            # tmpvars = list(set(tmpvars) - set(ps))
            print("tmpvars=",tmpvars)
            tmpcond = parseQepcadConstraint(
                qepcad(qf.exists(tmpvars, tmpcond)))
            if type(tmpcond) == list:
                cpFalse = tmpcond
            else:
                cpFalse = [tmpcond]

            if 1 in cpFalse:
                cpFalse = [SR(True)]
            elif cpFalse.count(0) == len(cpFalse):
                cpFalse = [SR(False)]
            else:
                cpFalse = list(filter(lambda l: l != 0, cpFalse))
            # debugPrint(cpTrue, cpFalse)

            return [cpTrue, cpFalse]
