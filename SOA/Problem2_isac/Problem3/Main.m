clear
clc

[contantsGA,constantsFFNN] = InitializeGAAndFFNNConstants();
timestep = 0.01;

%Run optimization algorithm
[maximumFitnessList,maximumFitnessListValidation, bestChromosome] = RunFFNNOptimization(contantsGA,constantsFFNN,timestep);

% update bestChromosome.m
fileID = fopen('BestChromosome.m','wt+');
    chromosome = string(bestChromosome);
    stringSum = "bestChromosome = ["+string(chromosome(1));
    for i=2 : length(chromosome)
        stringSum = stringSum +','+ chromosome(i);
    end
    stringSum = stringSum +'];';

    fwrite(fileID,stringSum);
fclose(fileID);
%%
hold on
plot(maximumFitnessList,'b')
plot(maximumFitnessListValidation,'r')
xlabel('generation')
ylabel('max fitness')
legend('training fitness','validation fitness','Location','southeast')
%%
RunTest(5);

