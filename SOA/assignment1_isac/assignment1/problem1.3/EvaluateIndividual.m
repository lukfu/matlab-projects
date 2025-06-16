% First compute the function value, then compute the fitness
% value; see also the problem formulation.

function fitness = EvaluateIndividual(x);

    g1 = (1.5 - x(1) + x(1)*x(2)^1)^2;
    g2 = (2.25 - x(1) + x(1)*x(2)^2)^2;
    g3 = (2.625 - x(1) + x(1)*x(2)^3)^2;
    g = g1+g2+g3;
    fitness=1/g;

end
