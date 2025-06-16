% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)


function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
       polyLength = length(polynomialCoefficients);
       
    if polyLength <= derivativeOrder
        derivativeCoefficients = [];
        return;
    end
        
    derivativeCoefficients = polynomialCoefficients;
    for i=1:polyLength
       derivativeFactor = factorial(i-1)/factorial(abs(i-1-derivativeOrder));
       derivativeCoefficients(i) = derivativeCoefficients(i) * derivativeFactor;
    end
    derivativeCoefficients=derivativeCoefficients(1+derivativeOrder:end);
end

    