# from sawtooth_wave 

# INIT     <=> -1 < f < 1.
# INCREASE <=> [](f'=3).
# DROP     <=> [](f- = 10 => f=0).
# INIT, INCREASE << DROP.

var('prev_f0 t')
f = function('f')(t)

cons = [[f < 10, diff(f,t) == 3]]
initCons = []
assum = []
vars = [f, diff(f,t)]
prevRs = []
prevCons = [prev_f0 < 1, prev_f0 > -1]
# prevCons = []
pCons = []
pars = []

sol = checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars)
print('sol=',sol)