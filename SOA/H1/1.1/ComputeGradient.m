% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.

function gradF = ComputeGradient(x,mu)
    gradF=[2 * (x(1) - 1) ; 4 * (x(2) - 2)];    
    if (x(1)^2 + x(2)^2 >= 1)
        aFactor = 4 * mu * (x(1)^2 + x(2)^2 - 1);
        gradF = gradF + [x(1) * aFactor ; x(2) * aFactor];
    end
end
