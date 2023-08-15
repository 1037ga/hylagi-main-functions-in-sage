load("common/utils.sage")

def solveWithParameters(consList, parList):
  qf = qepcad_formula
  vars = getVariables(consList)
  cons = qf.and_(consList, parList)
  resultCond = qepcad(qf.exists(vars, cons))
  print(type(resultCond))
  print(resultCond)

x,y,z,p = var('x y t p')

# satisfiable (depend on parameter)
# find the time point of discrete change
tm = cputime()
solveWithParameters([x==t, y==t^2*(-5)+p, 1<x, x<2, y==0, t>0], [1<p, p<10])
print("time:" + cputime(tm).__str__())

tm = cputime()
solveWithParameters([x==t, y==t^2*(-5)+p, 1<x, x<2, y==-1, t>0], [1<p, p<10])
print("time:" + cputime(tm).__str__())
