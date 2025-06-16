% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    
    if derivativeOrder >= length(polynomialCoefficients)
        derivativeCoefficients = [];
        return;
    end
    
    derivativeCoefficients = polynomialCoefficients;
    %a_0*x^n --->      n!/(n-derivativeOrder)!   * a_0*x^(n-derivateOrder)
    for i=1:length(polynomialCoefficients)
       derivativeFactor = factorial(i-1)/factorial(abs(i-1-derivativeOrder));
       derivativeCoefficients(i) = derivativeCoefficients(i) * derivativeFactor;
    end
    derivativeCoefficients=derivativeCoefficients(1+derivativeOrder:end);
    
end
