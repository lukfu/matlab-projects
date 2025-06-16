% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue);

     nGenes = length(chromosome);
     nGenesPerVariable = nGenes/numberOfVariables;
     
     x(1:numberOfVariables)=0;
     for iVariable = 1:numberOfVariables
        for iBits = 1:nGenesPerVariable
            geneDecoded = nGenesPerVariable*(iVariable-1) + iBits;
            x(iVariable) = x(iVariable) + chromosome(geneDecoded)*2^(-iBits);
        end
     end
     x = -maximumVariableValue + 2*maximumVariableValue*x./(1 - 2^(-nGenesPerVariable));

end
