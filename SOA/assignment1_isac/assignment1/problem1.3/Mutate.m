function mutatedIndividual = Mutate(individual, mutationProbability);

    nGenes = length(individual);
    genesMutated = (rand(1,nGenes)<=mutationProbability);
    mutatedIndividual = abs(individual-genesMutated);

end
