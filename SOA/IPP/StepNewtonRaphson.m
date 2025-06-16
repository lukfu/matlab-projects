% This method should perform a single step of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.

function xNext = StepNewtonRaphson(x, fPrime, fDoublePrime)
    fPrimeValue = GetPolynomialValue(x, fPrime);
    fDoublePrimeValue = GetPolynomialValue(x, fDoublePrime);
    
    if fPrime == 0
       errorMessage = errordlg("derivative is 0, next iteration value undefined"); 
       xNext = NaN;
       return;
    end
    
    xNext = x - fPrimeValue/fDoublePrimeValue;
end
