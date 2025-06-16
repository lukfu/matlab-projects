% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)
    if length(polynomialCoefficients) <= 2
        iterationValues = [];
        errorMsg = errordlg("order of polynomial needs to be 2 or higher");
        return;
    end
    iterationValues = startingPoint;
    fPrime = DifferentiatePolynomial(polynomialCoefficients, 1);
    fDoublePrime = DifferentiatePolynomial(polynomialCoefficients, 2);
    nextIterationValue = StepNewtonRaphson(iterationValues(end), fPrime, fDoublePrime);
    
    if isnan(nextIterationValue)
        condition = false;
    else
        iterationValues = [iterationValues; nextIterationValue];
        condition = true;
    end 
       
    while condition
        nextIterationValue = StepNewtonRaphson(iterationValues(end), fPrime, fDoublePrime);
        iterationValues = [iterationValues; nextIterationValue];
        
        toleranceCheck = abs(nextIterationValue(end) - iterationValues(end-1)) > tolerance;
        NaNCheck = isnan(nextIterationValue(end));
        loopIterationCheck = length(iterationValues) < 10^3;
        condition = (toleranceCheck && not(NaNCheck) && loopIterationCheck);
    end
end

    
