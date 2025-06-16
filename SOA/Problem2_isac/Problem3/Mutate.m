function mutatedIndividual = Mutate(individual, mutationProbability)
    nGenes = length(individual);
    genesMutated = (rand(1,nGenes)<=mutationProbability);
    sumGenesMutated = sum(genesMutated);
    individual(genesMutated) = rand(1,sumGenesMutated);
    mutatedIndividual = individual;
end
