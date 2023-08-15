# from DC-DC.hydla
var('prev_c0 prev_il0 prev_l0 prev_r00 prev_rc0 prev_rl0 prev_s0 prev_timer0 prev_vs0 prev_il1 prev_s1 prev_timer1 prev_vc1 prev_vc0 t')
c = function('c')(t)
il = function('il')(t)
l = function('l')(t)
r0 = function('r0')(t)
rc = function('rc')(t)
rl = function('rl')(t)
s = function('s')(t)
timer = function('timer')(t)
vc = function('vc')(t)
vs = function('vs')(t)

cons = [[rc == 1, r0 == 1, c == 1, vc/(c*(r0 + rc)) + diff(vc, 1) == 0]]
initCons = []
assum = []
vars = [c, il, l, r0, rc, rl, s, timer, vc, vs, diff(il, 1), diff(s, 1), diff(timer, 1), diff(vc, 1)]
prevRs = [prev_c0 == 1, prev_il0 == 0, prev_l0 == 1, prev_r00 == 1, prev_rc0 == 1, prev_rl0 == 1, prev_s0 ==
          0, prev_timer0 == 0, prev_vs0 == 1, prev_il1 == 1, prev_s1 == 0, prev_timer1 == 1, prev_vc1 == -prev_vc0/2]
prevCons = [prev_vc0 - 5 < 0, prev_vc0 > 0]
pCons = []
pars = []

# sol = ('solved', [[]], [c == 1, r0 == 1,
#                         rc == 1, vc == prev_vc0/e ^ (t/2)])

sol = checkConsitencyInterval(cons, initCons, assum, vars, prevRs, prevCons, pCons, pars)
print(sol)
if sol == [[prev_vc0 - 5 < 0, prev_vc0 > 0], [SR(False)]]:
    print('OK')
else:
    print('NG')
