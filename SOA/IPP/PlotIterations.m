% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated).

function PlotIterations(polynomialCoefficients, iterationValues)
    if length(iterationValues) <= 1
        return;
    end
    
    graphMaxXDistance = max(iterationValues) - min(iterationValues);
    graphMinX = min(iterationValues) - graphMaxXDistance*0.1;
    graphMaxX = max(iterationValues) + graphMaxXDistance*0.1;
    
    itterationValueMinY = min(GetPolynomialValue(graphMinX,polynomialCoefficients),GetPolynomialValue(graphMaxX,polynomialCoefficients));
    itterationValueMaxY = max(GetPolynomialValue(graphMinX,polynomialCoefficients),GetPolynomialValue(graphMaxX,polynomialCoefficients));
    
    graphMaxYDistance = itterationValueMaxY - itterationValueMinY;
    graphMinY = itterationValueMinY - 0.1*graphMaxYDistance;
    graphMaxY = itterationValueMaxY + 0.1*graphMaxYDistance;
    
    
    functionValuesX = (linspace(graphMinX,graphMaxX))';
    functionValuesY = zeros(length(functionValuesX),1);
    iterationValuesX = iterationValues;
    iterationValuesY = zeros(length(iterationValuesX),1);
    
    for i=1:length(functionValuesX)
        functionValuesY(i) = GetPolynomialValue(functionValuesX(i),polynomialCoefficients);
    end
    for j=1:length(iterationValuesX)
        iterationValuesY(j) = GetPolynomialValue(iterationValuesX(j),polynomialCoefficients);
    end
    
    %plot function and iteration values
    hold on;
    grid on
    plot(functionValuesX,functionValuesY,'k')
    plot(iterationValuesX,iterationValuesY,'or')
    axis([graphMinX graphMaxX graphMinY graphMaxY])
    
end
    
    