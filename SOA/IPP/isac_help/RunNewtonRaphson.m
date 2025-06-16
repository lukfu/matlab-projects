% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

    if length(polynomialCoefficients) <= 2  
        iterationValues=[];
        errorMessage = errordlg("polynomial of degree 2 or higher is needed" , "input error"); 
        return;
    end

    iterationValues = [startingPoint];
    fPrime = DifferentiatePolynomial(polynomialCoefficients,1);
    fDoublePrime = DifferentiatePolynomial(polynomialCoefficients,2);

    nextIterationValue = StepNewtonRaphson(iterationValues(end), fPrime, fDoublePrime);
    if isnan(nextIterationValue)
       conditions = false;
    else
       iterationValues = [iterationValues; nextIterationValue];
       conditions = true;
    end

    while conditions
       nextIterationValue = StepNewtonRaphson(iterationValues(end), fPrime, fDoublePrime);
       iterationValues = [iterationValues; nextIterationValue];

       isDiffernceBig = (abs(iterationValues(end) - iterationValues(end-1)) > tolerance);
       isValueNaN = (isnan(nextIterationValue)); 
       isLoopIterationLow = (length(iterationValues)<10^3);
       conditions = ( isDiffernceBig && not(isValueNaN) && isLoopIterationLow);
    end

end