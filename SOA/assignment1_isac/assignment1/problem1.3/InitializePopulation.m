function population = InitializePopulation(populationSize,numberOfGenes);
    population = floor(rand(populationSize, numberOfGenes)+1/2);
end