from inspect import currentframe
from sage.misc.parser import Parser, Tokenizer
import re
import os
from functools import reduce

# return variables used in cons


def getVariables(cons):
    print('cons=',cons)
    if(cons == []):
        return []
    if(not hasattr(cons, '__iter__')):
        cons = [cons]
    if(hasattr(cons[0], '__iter__')):
        print(hasattr(cons[0], '__iter__'))
        # cons = reduce(lambda x, y: x + y, cons)
        # cons = list(reduce(lambda x, y: x + y, cons))
        # print('cons=',cons)
    vars = sorted(list(reduce(lambda acc, l: acc.union(l.variables()),cons, set())), key=lambda x: x.__str__())
    return [v for v in vars if v.__str__()[0:2] != 'p_' and v.__str__()[0:5] != 'prev_' and v.__str__() != 't']

# return parameters used in cons


def getParameters(cons):
    if(cons == []):
        return []
    if(not hasattr(cons, '__iter__')):
        cons = [cons]
    if(hasattr(cons[0], '__iter__')):
        print('cons=',cons)
        # cons = list(reduce(lambda x, y: x + y, cons))
    vars = list(reduce(lambda acc, l: acc.union(l.variables()),cons, set()))
    vars = sorted(vars, key=lambda x: x.__str__())
    return [v for v in vars if v.__str__()[0:2] == 'p_']

# return prev variables used in cons


def getPrevVariables(cons):
    if(cons == []):
        return []
    if(not hasattr(cons, '__iter__')):
        cons = [cons]
        print(1)
    if(hasattr(cons[0], '__iter__')):
        cons = list(reduce(lambda x, y: x + y, cons))
        print(2)
    vars = sorted(list(reduce(lambda acc, l: acc.union(l.variables()),
                              cons, set())), key=lambda x: x.__str__())
    print('vars=',vars)
    return [v for v in vars if v.__str__()[0:5] == 'prev_']

# translate return string of qepcad into constraints
# (ex. a=1\/b=2/\c=3  -> [[a==1], [b==2, c==3]])


def parseQepcadConstraint(strCons):
    if(strCons == 'TRUE'):
        return SR(True)
    if(strCons == 'FALSE'):
        return SR(False)
    p = Parser(make_var=var)
    strCons = strCons.replace(' = ', ' == ').replace(
        ' /= ', ' != ').replace('[', '').replace(']', '')
    strCons = re.sub(r'(^prev|\sprev)', r'\1_', strCons)
    strCons = re.sub(r'(^(?!prev)p|\s(?!prev)p)', r'p_', strCons)
    strCons = strCons.replace(r'$prev', 'prev_').replace(r'$p', 'p_')
    orAndCons = [[[p.p_eqn(Tokenizer(cons))] for cons in orStrCons.split(
        '\\/')] for orStrCons in strCons.split('/\\')]
    andOrCons = list(
        reduce(lambda l1, l2: [a + b for a in l1 for b in l2], orAndCons))
    print(andOrCons)
    return andOrCons


# def debugPrint(*args):
#     frame = currentframe().f_back
#     print('[' + str(frame.f_lineno)
#           + ':' + str(frame.f_code.co_name)
#           + ':' + str(os.path.basename(frame.f_code.co_filename)) + ']')
#     names = {id(v): k for k, v in frame.f_locals.items()}
#     print('\n'.join(names.get(id(arg), repr(arg)) + ' : ' + repr(arg)
#                     for arg in args))
#     print('piyo')
