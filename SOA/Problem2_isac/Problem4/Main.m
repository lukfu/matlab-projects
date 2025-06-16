clc

constantsGA = struct;
constantsGA.tournamentSize = 2;
constantsGA.tournamentProbability = 0.75;
constantsGA.crossoverProbability = 0.02;
constantsGA.populationSize = 100;
constantsGA.nGenerations = 4000;

%run algorithm
[fitnessGenerations, bestChromosome] = RunLGP(constantsGA);

%save chromosome
fileID = fopen('BestChromosome.m','w+');
    chromosome = bestChromosome.Chromosome;       
    chromosome =string(chromosome);
    stringSum = "bestChromosome = ["+string(chromosome(1));
    for i=2 : length(chromosome)
        stringSum = stringSum +','+ chromosome(i);
    end
    stringSum = stringSum +'];';
    fwrite(fileID,stringSum);
fclose(fileID);

% printing and plotting
TestLGPChromosome()
figure;
plot(fitnessGenerations);
xlabel('Generation');
ylabel('Fitness');




