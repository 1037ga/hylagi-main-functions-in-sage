load("common/utils.sage")

def simpleSolve(cons):
  vars = getVariables(cons)
  sol = solve(cons, vars)
  print(sol)

(x,y,time) = var('x y tt')

# consistent
tm = cputime()
simpleSolve([x==2*y+1, y==x+1])
print("time:" + cputime(tm).__str__())

# inconsistent
tm = cputime()
simpleSolve([x==2*y+1, y==x+1, x>1])
print("time:" + cputime(tm).__str__())

# check a ball is on a floor (bouncing particle example)
tm = cputime()
simpleSolve([y==-5*tt^2+10, y==0, time==sqrt(2)])
print("time:" + cputime(tm).__str__())
