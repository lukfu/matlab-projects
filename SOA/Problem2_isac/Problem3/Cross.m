
function newIndividuals = Cross(individual1, individual2)
    
    nGenes = length(individual1);
    crossoverPoint = randi(nGenes-1);
    
    oldChromosomePair = [individual1;individual2];
    oldChromosomePairReverseOrder = [individual2;individual1];
    newChromosomePair = zeros(2,nGenes);
    newChromosomePair(:, 1:crossoverPoint) = oldChromosomePair(:, 1:crossoverPoint);    
    newChromosomePair(:, crossoverPoint+1:end) = oldChromosomePairReverseOrder(:, crossoverPoint+1:end);
  
    newIndividuals = newChromosomePair;
end
