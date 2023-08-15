load("common/utils.sage")

def FindMinTime(S,CP,g):
  p_var = getParameters(CP)
  var = getVariables(g)
  print('var=',var)
  s = list(filter(lambda x: getVariables(x) == var, S))
  if g != []:
    s = list(map(lambda x: x.subs(g), s))
  assume(t > 0)
  sol = solve(s,t)
  if len(sol) == 1:
    print(sol[0])
  elif len(sol) == 2:
    compare = sol[0] > sol[1]
    if compare:
      print(sol[1])
    else:
      print(sol[0])
  # if getParameters(sol) == p_var:
  #   qf = qepcad_formula
  #   cons = qf.and_(sol,CP,[t>0]) 
  #   pcons = qepcad(qf.exists(t, cons,))
  #   print(pcons)

def solveWithParameters(consList, parList):
  qf = qepcad_formula
  vars = getVariables(consList)
  cons = qf.and_(consList, parList)
  resultCond = qepcad(qf.exists(vars, cons))
  print(type(resultCond))
  print(resultCond)




var('x,x1,y,y1,y2,p_y,t,p_x1')
# FindMinTime([x == p_x1*t, x1 == p_x1, y == 10 - 5*t^2, y1 == -5*t, y2 == -10],[p_x1 > 0, p_x1 < 5],[x == 5])
# FindMinTime([x == t, x1 == 1, y == p_y - 5*t^2, y1 == -5*t, y2 == -10],[p_y > 0, p_y < 5],[y == 5])
# FindMinTime([y == p_y - t^2 + t],[p_y > 0, p_y < 5],[y == 3])
# FindMinTime([y == p_y + t],[p_y > 0, p_y < 5],[y == 3])
# FindMinTime([y == p_y + t],[p_y > 0, p_y < 5],[y == 3])