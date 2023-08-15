# from bouncing_particle_hole.hydla

# INIT <=> y = 10 /\ y' = 0 /\ x = 0 /\ 1 <= x' <= 5.
# FALL <=> [](y'' = -10).
# XCONST <=> [](x'' = 0).
# XBOUNCE <=> []((x- = 7 \/ x- = 10) /\ y- < 0 => x' = -x'-). 
# BOUNCE <=> [](y- = -7 \/ (x- <= 7 \/ x- >= 10) /\ y- = 0 => y' = -(4/5) * y'-).
# ASSERT(!(x >= 10 /\ y >= 0)).
# INIT, FALL << BOUNCE, XCONST << XBOUNCE.

# var('prev_x0 prev_x1 prev_x2 prev_y0 prev_y1 prev_y2 t')
var('prev_x0 prev_x10 prev_x2 prev_y0 prev_y10 prev_y2 t')
x = function('x')(t)
y = function('y')(t)
x1 = function('x1')(t)
y1 = function('y1')(t)

# cons = [[y == -7, diff(y, 2) == -10, diff(x, 2) == 0], [x < 7, y == 0, diff(y, 2)== -10, diff(x, 2) == 0], [x > 10, y == 0, diff(y, 2) == -10, diff(x, 2) == 0]]
cons = [[y <= 0,diff(y1, t) == -10, diff(x1, t) == 0, x1 == diff(x,t),y1 == diff(y,t)]]
# initCons = [x(t=0) == prev_x0, diff(x, 1)(t=0) == prev_x10, y(t=0) == prev_y0, diff(y, 1)(t=0) == prev_y10]
initCons = [x(t=0) == prev_x0, x1(t=0) == prev_x10, y(t=0) == prev_y0, y1(t=0) == prev_y10]
assum = []
# vars = [x, y, diff(x, 1), diff(y, 1), diff(x, 2), diff(y, 2)]
vars = [x, y, x1, y1, diff(x, 1), diff(y, 1), diff(x1, t), diff(y1, t)]
# prevRs = [prev_x0 == 0, prev_x2 == 0,
#           prev_y0 == 10, prev_y1 == 0, prev_y2 == -10]
prevRs = [prev_x0 == 0, prev_x2 == 0,
           prev_y0 == 10, prev_y10 == 0, prev_y2 == -10]
# prevCons = [prev_x1 <= 5, prev_x1 >= 1]
prevCons = [prev_x10 <= 5, prev_x10 >= 1]  # 積形のみ？
pCons = []  # 積形？
pars = []

# sol = ('solved', [[t ^ 2 == 2, t*prev_x1 >= 10], [t ^ 2 == 2, t *
#                                                    prev_x1 <= 7], [5*t ^ 2 == 17]], [x == t*prev_x1, y == 10 - 5*t ^ 2])


if checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars) == [[0], [prev_x10 <= 5, prev_x10 >= 1]]:
    print('OK')
else:
    print('NG')

sol = checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars)
print('sol=',sol)