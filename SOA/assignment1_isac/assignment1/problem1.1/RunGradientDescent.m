% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
    
    x = xStart;
    gradiant = ComputeGradient(x,mu);
    while (norm(gradiant,2) >= gradientTolerance)
        x = x - eta*gradiant;
        gradiant = ComputeGradient(x,mu);
    end
    
end
