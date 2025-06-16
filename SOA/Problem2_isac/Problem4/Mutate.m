function mutatedIndividual = Mutate(individual)
    
    %initiate variable
    [~,~, operatorSet, constantRegister, nVariableRegister] = InitializeLGPConstants();
    nOperators = length(operatorSet);
    
    individual=individual.Chromosome;
    nChromosomes = length(individual);
    mutationProbability = 1/nChromosomes;
    nRegister = nVariableRegister + length(constantRegister);
    
    
    %mutate individual
    for i = 1:nChromosomes
        r = rand;
        if r < mutationProbability
            if (mod(i,4) == 1)
                individual(i) = fix(r*nOperators)+1;
            elseif (mod(i,4) == 2)
                individual(i) = fix(r*nVariableRegister)+1;
            else
                individual(i) = fix(r*nRegister)+1;
            end
        end   
    end
    mutatedIndividual = struct('Chromosome',individual);
end
