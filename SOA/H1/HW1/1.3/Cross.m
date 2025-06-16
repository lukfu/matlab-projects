function newIndividuals = Cross(individual1, individual2)
    nGenes = size(individual1,2);
    crossOverPoint = 1 + fix(randi(nGenes-1));
    newChromosomePair = zeros(2,nGenes);
    for j = 1:nGenes
        if(j <= crossOverPoint)
            newChromosomePair(1,j) = individual1(j);
            newChromosomePair(2,j) = individual2(j);
        else
            newChromosomePair(2,j) = individual1(j);
            newChromosomePair(1,j) = individual2(j);
        end
    end
    newIndividuals = newChromosomePair;
end
