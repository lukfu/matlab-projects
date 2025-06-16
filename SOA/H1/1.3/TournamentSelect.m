function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    
    populationSize = length(fitnessList);
    indexRandIndividual = zeros(1,tournamentSize);
    randIndividual = zeros(1,tournamentSize);
    for j = 1:tournamentSize
        indexRandIndividual(j) = randi(populationSize - 1);
        randIndividual(j) = fitnessList(indexRandIndividual(j));
    end
    

    for i = 1:tournamentSize
        r = rand;
        if i == tournamentSize
            selectedIndividualIndex = indexRandIndividual;
            break
        end
        [~,bestIndividualIndex] = max(randIndividual);
        if r < tournamentProbability
            selectedIndividualIndex = indexRandIndividual(bestIndividualIndex);
            break
        else
            randIndividual(bestIndividualIndex) = [];
            indexRandIndividual(bestIndividualIndex) = [];
        end
    end
end
