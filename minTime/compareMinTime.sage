load("../common/utils.sage")
#
'''
def getParameters(exprs_):
  s_union = Cases[exprs, p[_,_,_],{0,Infinity}]
  s_union = union(set(cons)
'''

def result_format(cons):
  if cons == [] :
    return False
  else :
    return cons.pop()

'''
def get_not(a,b):
  answer =qf.and_(a,qf.not_(b.pop()))
  while b != [] :
    answer = qf.and_(answer,qf.not_(b.pop()))
  return answer
'''


def getParametersList(parsList) :
  getParsList = []
  while parsList != [] :
    temp = parsList.pop()
    if type(temp) == list :
      getParsList = getParsList + getParameters(temp)

  return list(set(getParsList))



#time1,time2,pCons1,pCons2

def compareMinTime(time1, time2, pCons1, pCons2) :
  parsList = [time1, time2, pCons1, pCons2]
  usedPars = getParametersList(parsList)
  
  if usedPars == [] :
    if bool(time1 == time2) :
      return (False, False, True)
    elif bool(time1 < time2) : 
      return (True, False, False)
    elif bool(time1 > time2) : 
      return (False, True, False)

 ### print(usedPars)
  andCond = solve(pCons1 + pCons2,usedPars)
  
  if andCond == [] :
    return(False, False, False)
  else :
    andCond = andCond.pop()

  if time1 == Infinity :
    return(False, andCond, False)

  caseEq = result_format(solve(andCond + [time1 == time2] ,usedPars))
  caseLe = result_format(solve(andCond + [time1 < time2], usedPars))
  caseGr = result_format(solve(andCond + [time1 > time2], usedPars)) 
  return(caseLe, caseGr, caseEq)
