# from -1 < x < 1 & y = 0, [](x' = 0 & y' = 0) << [](x- > 0 => x' = 0 & y = 1).

var('prev_x0 prev_x1 prev_y0 prev_y1 t')
x = function('x')(t)
y = function('y')(t)

cons = [[x > 0, diff(x, t) == 0, y == 1]]
initCons = [x(t=0) == prev_x0]
# initCons = [x(t=0) == prev_x0, y(t=0) == 0]
assum = []
vars = [x, y, diff(x, t), diff(y, t)]
prevRs = [prev_y0 == 0, prev_x1 == 0, prev_y1 == 0]
prevCons = [prev_x0 < 1, prev_x0 > -1]
pCons = []
pars = []

# sol = ('solved', [[prev_x0 > 0]], [x == prev_x0])

sol = checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars)
print(sol)
if sol == [[prev_x0 - 1 < 0, prev_x0 > 0],[[prev_x0 <= 0, prev_x0 + 1 > 0]]]:
    print('OK')
else:
    print('NG')

