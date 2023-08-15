var('prev_y0 prev_y1 prev_y2 t')
y = function('y')(t)
y1 = function('y1')(t)

cons = [[y == prev_y0, diff(y,1) == 10, diff(y1,1) == -10, y1 == diff(y,t)]]
initCons = [y(t=0) == prev_y0, y1(t=0) == prev_y1]
assum = []
vars = [y, y1, diff(y, 1), diff(y1, 1)]
prevRs = [prev_y1 == 10, prev_y2 == -10]
prevCons = [prev_y0 >= 9, prev_y0 <= 11]  
pCons = []  
pars = []
                                                  
sol = checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars)


print(sol)