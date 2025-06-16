
function population = InitializePopulation(populationSize)
    
    [minInstructionLength,maxInstructionLength,operatorSet,...
         constantRegister,nVariableRegister] = InitializeLGPConstants();
    nOperators = length(operatorSet);
    population = [];
    nRegister = nVariableRegister + length(constantRegister);
    
    for iChromosome = 1:populationSize
        chromosomeLength = minInstructionLength + randi(maxInstructionLength-minInstructionLength);
        tmpOperator = randi(nOperators,1,chromosomeLength);
        tmpDestination = randi(nVariableRegister,1,chromosomeLength);
        tmpChromosome = randi(nRegister,1,4*chromosomeLength);
        
        tmpChromosome(1:4:end-3) = tmpOperator;
        tmpChromosome(2:4:end-2) = tmpDestination;
        tmpIndividual = struct('Chromosome',tmpChromosome);

        population =  [population, tmpIndividual];
    end
end