
function TestLGPChromosome(bestChromosome)
    if nargin <1
        BestChromosome
        bestChromosome = struct('Chromosome',bestChromosome);
    end
    
    %real function
    functionData = LoadFunctionData;
    RealXValue = functionData(:,1);
    RealYValue = functionData(:,2);
    
    %estimated function
    functionData = LoadFunctionData;
    estimatedYValues = zeros(size(functionData,1),1);
    for iXValue = 1:size(functionData,1)
        xValue = functionData(iXValue,1);
        estimatedYValues(iXValue) = Decode(bestChromosome,xValue);
    end 
    tmp1 = (estimatedYValues-functionData(:,2)).^2;
    tmp2 = length(estimatedYValues);
    error = sqrt( sum(tmp1) / tmp2);
    sprintf('Fitness: %0.4f, Error: %0.4f',1/error,error)
    estimatedFunctionString = Decode(bestChromosome,1,true);

    %plotting 
    hold on 
    plot(RealXValue,RealYValue,'b')
    plot(RealXValue,estimatedYValues,'r')
    legend('RealFunction','Estimated Function')
    text(-1,-1,string(estimatedFunctionString))
    xlabel('x')
    ylabel('f(x)')
end