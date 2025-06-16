
function fitness = EvaluateIndividual(individual)
    
    functionData = LoadFunctionData;
    estimatedYValues = zeros(size(functionData,1),1);
    realYValues = functionData(:,2);
    
    for iXValue = 1:size(functionData,1)
        xValue = functionData(iXValue,1);
        estimatedYValues(iXValue) = Decode(individual,xValue);
    end
    
    tmp1 = (estimatedYValues-realYValues).^2;
    tmp2 = length(estimatedYValues);
    error = sqrt( sum(tmp1) / tmp2);
    fitness =1/error;
    %modifiers
    if length(individual.Chromosome)>=150
       fitness = fitness * 0.5; 
    end 
end

