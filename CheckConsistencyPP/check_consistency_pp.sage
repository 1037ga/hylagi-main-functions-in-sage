import sys
from inspect import currentframe
from sage.misc.parser import Parser, Tokenizer


def get_variables(constraints):
    vars = sorted(reduce(lambda acc, l: acc.union(l.variables()), constraints, set()),\
                  key=lambda x: x.__str__())
    return [ v for v in vars if v.__str__()[0] != 'p' and v.__str__() != 't']


def simple_solve(constraints):
    variables = get_variables(constraints)
    return solve(constraints, variables)


def solve_with_parameters(constraint_list, parameter_list):
    qf = qepcad_formula
    variables = get_variables(constraint_list)
    constraints = qf.and_(constraint_list, parameter_list)
    return qepcad(qf.exists(variables, constraints))


def __get_element(list_of_tuples):
    return ([aitem[0] for aitem in list_of_tuples],\
            [bitem[1] for bitem in list_of_tuples])


def __convert_to_conjunctive(symb_par):
    if (len(symb_par) == 1):
        return symb_par
    else:
        qf = qepcad_formula
        return qf.and_(symb_par[0], __convert_to_conjunctive(symb_par[1:]))


def __take_union_of_expr_lst(parameter_lst):
    if (len(parameter_lst) <= 1):
        return parameter_lst
    else:
        qf = qepcad_formula
        return qf.or_(parameter_lst[0], __take_union_of_expr_lst(parameter_lst[1:]))


def __parse_qepcad_constraint(strCons):
    if (strCons == 'TRUE'):
        return SR(True)
    if (strCons == 'FALSE'):
        return SR(False)
    p = Parser(make_var=var)
    strCons = strCons.replace(' = ', ' == ').replace(' /= ', ' != ')\
                                            .replace('[', '').replace(']', '')
    orAndCons = [[[p.p_eqn(Tokenizer(cons))] for cons in orStrCons.split('\\/')]\
                                             for orStrCons in strCons.split('/\\')]
    andOrCons = reduce(lambda l1,l2: [a+b for a in l1 for b in l2], orAndCons)
    return andOrCons


def check_consistency_pp_qe(constraint_store, symbolic_parameters):
    qf = qepcad_formula
    symbolic_parameters_conj = __convert_to_conjunctive(symbolic_parameters[0])
    tmp_parameters = solve_with_parameters(constraint_store[0], symbolic_parameters[0])
    if (tmp_parameters == "FALSE"):
        print("# tmp_parameters is empty")
        return (false, qepcad(symbolic_parameters_conj))
    elif (tmp_parameters == symbolic_parameters_conj): # TODO: equivalency check
        print("# tmp_parameters is equal to the original")
        return (true, qepcad(symbolic_parameters_conj))
    else:
        print("# tmp_parameters is modified")
        neg_range = qf.not_(qf.and_(__parse_qepcad_constraint(tmp_parameters)[0],[]))
        symbolic_parameters_conj_exp = __parse_qepcad_constraint(qepcad(symbolic_parameters_conj))
        neg_range_exp = __parse_qepcad_constraint(qepcad(neg_range))
        parameter_disjunction = []
        for each_neg_range in neg_range_exp:
            for each_symbolic_parameters_conj in symbolic_parameters_conj_exp:
                intersection = qepcad(qf.and_(each_neg_range, each_symbolic_parameters_conj))
                if (intersection == "FALSE"):
                    continue
                parameter_disjunction.append(intersection)
        parameter_union = __take_union_of_expr_lst(parameter_disjunction)
        return __get_element([(true,[tmp_parameters]), (false,parameter_union)])


def main():
    print("\n== Check Consistency PP by QE =========================================")
    (y, dy, ddy, p_y) = var('y dy ddy p_y')
    # constraint_store = [[p_y == 10 + dy^2/20,y == 15, ddy == -10, dy == -4/5*dy]]
    # constraint_store = [[dy == 2*sqrt(5*p_y-50),y == 15, ddy == -10, dy == -4/5*dy]]
    # constraint_store = [[y == p_y, dy == 10, ddy == -10]]
    symbolic_parameters = [[p_y>=9, p_y<=11]]
    print("==== input ======")
    print("constr store\t:\t" + constraint_store.__str__())
    print("symbolic params\t:\t" + symbolic_parameters.__str__())
    timer = cputime()
    (consistency, updated_parameters) = check_consistency_pp_qe(constraint_store, symbolic_parameters)
    print("==== output =====")
    print("consistency\t:\t" + consistency.__str__())
    print("updated params\t:\t" + updated_parameters.__str__())
    print("==== measure ====")
    print("time\t\t:\t" + cputime(timer).__str__())
    print("")


if __name__ == "__main__":
    main()
