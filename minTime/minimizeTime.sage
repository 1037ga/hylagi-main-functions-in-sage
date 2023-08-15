load("../common/utils.sage")

def minimizeTime(tCons, pCons, maxTime):
  maxCons = True if maxTime == infinity else t==maxTime

  qf = qepcad_formula
  vars = getVariables(consList)
  necessaryPCons = getRelatedParameter(vars, tCons)
  pars = getParameters(necessaryPCons)

  # Constraints of the optimization problem
  g = qf.and_(t>0, t<maxTime, tCons, necessaryPCons)
  # Calculate feasible regions of varible t
  orAndCons = parseQepcadConstraint(qepcad(qf.exists(vars, g)))
  ret = []
  for andCons in orAndCons:
    retTEq = t == infinity
    retPCons = pCons

    eachTCons = [rexp for rexp in andCons if t in rexp.variables()]
    retPCons = set(andCons)
    # unique t
    if(len(eachTCons) == 1 and eachTCons[0].operator().__str__()=='eq'):
      print("The feasible region is unique. It represents min time or refers parameters")
      retTEq = solve(eachTCons[0], t)
      ret.append((retTEq, retPCons))
    # unequality
    elif
      print("The feasible region is not unique. Calculate a lower bound of t")
      if(len(eachTCons) > 2):
        eachTCons = solve(eachTCons, t)
        if(len(eachTCons) > 2):
          print("Could not resolve lowerbound, Abort")
      for rexp in eachTCons:
        op = rexp.operator().__str()__
        if(op == 'ge' or op == '

x,y,z,p = var('x y t p')

# satisfiable (depend on parameter)
tm = cputime()
solveWithParameters([1<x, x<4, x==p], [2<p, p<5])
print("time:" + cputime(tm).__str__())

# inconsistent
tm = cputime()
solveWithParameters([x==1, x==p], [1<p, p<2])
print("time:" + cputime(tm).__str__())

# find the time point of discrete change
tm = cputime()
solveWithParameters([x==t, y==t^2*(-5)+p, 1<x, x<2, y==0, t>0], [1<p, p<10])
print("time:" + cputime(tm).__str__())

var('t')
