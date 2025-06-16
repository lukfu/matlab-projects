
function [contantsGA,constantsFFNN] = InitializeGAAndFFNNConstants()
    nIn = 3;
    nHidden = 5;
    nOut = 2;
    wMax = 5;
    numberOfGenes = nHidden*(nIn+1)+nOut*(nHidden+1);
    tournamentSize = 2;
    tournamentProbability = 0.75;
    crossoverProbability = 0.5;
    mutationProbability = 1/numberOfGenes;
    populationSize = 25;

    constantsFFNN = struct;
    constantsFFNN.nIn = nIn;
    constantsFFNN.nHidden = nHidden; 
    constantsFFNN.nOut = nOut;
    constantsFFNN.wMax = wMax;
    contantsGA = struct;
    contantsGA.populationSize = populationSize;
    contantsGA.numberOfGenes = numberOfGenes;
    contantsGA.tournamentSize = tournamentSize;
    contantsGA.tournamentProbability = tournamentProbability;
    contantsGA.crossoverProbability = crossoverProbability;
    contantsGA.mutationProbability = mutationProbability;
    contantsGA.numberOfGenes = nHidden*(nIn+1) + nOut*(nHidden+1);

end