from sage.all import *
load("common/utils.sage")

def simpleDesolve(cons_list,vars):
  sol = desolve_system(cons_list, vars, ivar=t)
  print(sol)

(t) = var('t')
(x) = function('x')(t)
tm = cputime()
simpleDesolve([diff(x,t)==-10],[x])
print("time:" + cputime(tm).__str__())
