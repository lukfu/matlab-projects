function selectedIndividualIndex = TournamentSelect(fitnessList, tournamentProbability, tournamentSize);
    
    populationSize = length(fitnessList);
    tournamentParticipentIndexes = 1 + floor(rand(1,tournamentSize)*populationSize);
    for iIter=1:tournamentSize
        r = rand;
        [~,maxIndex] = max(fitnessList(tournamentParticipentIndexes));
        if (r < tournamentProbability)
            selectedIndividualIndex = tournamentParticipentIndexes(maxIndex);
            break;
        elseif length(tournamentParticipentIndexes) >= 2
            tournamentParticipentIndexes(maxIndex) = [];%removed particpent
        else
            selectedIndividualIndex = tournamentParticipentIndexes(1);
        end   
    end

end
