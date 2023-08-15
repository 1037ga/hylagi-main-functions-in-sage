# from 
# INIT(m,n) <=> cnt = 0 & x = m & 0 < x'< 10 & y = n & y' = 0 & a = -1 & b = 0.
# CONST1    <=> [](a' = 0 & b' = 0).
# CONST2    <=> [](x'' = 0 & y'' = -10 & cnt' = 0).
# BOUNCE1   <=> [](y- = a*x- + b => x' = ((1-a*a)*x'- + 2*a*y'-)/(1+a*a) & y' = (2*a*x'- - (1-a^2)*y'-)/(1+a*a) & cnt = cnt- + 1).
# BOUNCE2   <=> [](y- = -a*x- + b => x' = ((1-a*a)*x'- - 2*a*y'-)/(1+a*a) & y' = (-2*a*x'- - (1-a^2)*y'-)/(1+a*a) & cnt = cnt- + 1).
# FLOOR   <=> [](y- = 0 => y' = -y'-).

# INIT(0,10), CONST1, CONST2 << (BOUNCE1, BOUNCE2).

# ASSERT(!(cnt = 1 & x = 0 & y = 10)).

# var('prev_x0 prev_x1 prev_x2 prev_y0 prev_y1 prev_y2 t')
var('prev_x0 prev_x10 prev_x2 prev_y0 prev_y10 prev_y2 t')
x = function('x')(t)
y = function('y')(t)
x1 = function('x1')(t)
y1 = function('y1')(t)

cons = [[y <= -x, diff(x1,t) == 0, diff(y1,t) == -10, x1 == diff(x,t), y1 == diff(y,t)],[y <= x, diff(x1,t) == 0, diff(y1,t) == -10, x1 == diff(x,t), y1 == diff(y,t)]]
initCons = [x(t=0) == prev_x0, x1(t=0) == prev_x10, y(t=0) == prev_y0, y1(t=0) == prev_y10]
assum = []
vars = [x, y, x1, y1, diff(x, 1), diff(y, 1), diff(x1, t), diff(y1, t)]
prevRs = [prev_y0 == 10, prev_x0 == 0, prev_y10 == 0]
prevCons = [prev_x10 < 1, prev_x10 > 0]
pCons = []
pars = []

sol = checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars)
print("sol=",sol)