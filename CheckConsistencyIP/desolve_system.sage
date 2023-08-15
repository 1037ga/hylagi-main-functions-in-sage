(y,dy,ddy,t,p_y) = var('y dy ddy t p_y')
y = function('y')(t)
dy = function('dy')(t)
ODE = [diff(dy,1) == -10, diff(y,t) == dy]
vars = [y,dy]
prevs = [p_y,10]
st = desolve_system(ODE,vars,ics=[0]+prevs)
print(st)
