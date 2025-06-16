%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...
mutationProbability = 0;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList000 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList000(i,1) = maximumFitness;
end

mutationProbability = 0.01;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList001 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList001(i,1) = maximumFitness;
end

mutationProbability = 0.02;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList002 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList002(i,1) = maximumFitness;
end

% ... and here (pMut > 0.02)

mutationProbability = 0.05;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList005 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList005(i,1) = maximumFitness;
end

mutationProbability = 0.1;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList010 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList010(i,1) = maximumFitness;
end

mutationProbability = 0.2;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList020 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList020(i,1) = maximumFitness;
end

mutationProbability = 0.3;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList030 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList030(i,1) = maximumFitness;
end

mutationProbability = 0.5;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList050 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList050(i,1) = maximumFitness;
end

mutationProbability = 0.7;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList070 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList070(i,1) = maximumFitness;
end

mutationProbability = 0.99;
sprintf('Mutation rate = %0.5f', mutationProbability)
maximumFitnessList099 = zeros(numberOfRuns,1);
for i = 1:numberOfRuns 
 [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
 sprintf('Run: %d, Score: %0.10f', i, maximumFitness)
  maximumFitnessList099(i,1) = maximumFitness;
end

%included pmut = 0, 0.01, 0.02, 0.05, 0.1, 0.2, 0.3, 0.5, 0.7, 0.99

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on
grid on

% Add more results summaries here (pMut < 0.02) ...
average000 = mean(maximumFitnessList000);
median000 = median(maximumFitnessList000);
std000 = sqrt(var(maximumFitnessList000));
sprintf('PMut = 0.00: Median: %0.10f, Average: %0.10f, STD: %0.10f', median000, average000, std000)
plot(0,median000,'rx')

average001 = mean(maximumFitnessList001);
median001 = median(maximumFitnessList001);
std001 = sqrt(var(maximumFitnessList001));
sprintf('PMut = 0.01: Median: %0.10f, Average: %0.10f, STD: %0.10f', median001, average001, std001)
plot(0.01,median001,'rx')

average002 = mean(maximumFitnessList002);
median002 = median(maximumFitnessList002);
std002 = sqrt(var(maximumFitnessList002));
sprintf('PMut = 0.02: Median: %0.10f, Average: %0.10f, STD: %0.10f', median002, average002, std002)
plot(0.02,median002,'rx')

% ... and here (pMut > 0.02)
average005 = mean(maximumFitnessList005);
median005 = median(maximumFitnessList005);
std005 = sqrt(var(maximumFitnessList005));
sprintf('PMut = 0.05: Median: %0.10f, Average: %0.10f, STD: %0.10f', median005, average005, std005)
plot(0.05,median005,'rx')

average010 = mean(maximumFitnessList010);
median010 = median(maximumFitnessList010);
std010 = sqrt(var(maximumFitnessList010));
sprintf('PMut = 0.10: Median: %0.10f, Average: %0.10f, STD: %0.10f', median010, average010, std010)
plot(0.10,median010,'rx')

average020 = mean(maximumFitnessList020);
median020 = median(maximumFitnessList020);
std020 = sqrt(var(maximumFitnessList020));
sprintf('PMut = 0.20: Median: %0.10f, Average: %0.10f, STD: %0.10f', median020, average020, std020)
plot(0.20,median020,'rx')

average030 = mean(maximumFitnessList030);
median030 = median(maximumFitnessList030);
std030 = sqrt(var(maximumFitnessList030));
sprintf('PMut = 0.30: Median: %0.10f, Average: %0.10f, STD: %0.10f', median030, average030, std030)
plot(0.30,median030,'rx')

average050 = mean(maximumFitnessList050);
median050 = median(maximumFitnessList050);
std050 = sqrt(var(maximumFitnessList050));
sprintf('PMut = 0.50: Median: %0.10f, Average: %0.10f, STD: %0.10f', median050, average050, std050)
plot(0.50,median050,'rx')

average070 = mean(maximumFitnessList070);
median070 = median(maximumFitnessList070);
std070 = sqrt(var(maximumFitnessList070));
sprintf('PMut = 0.70: Median: %0.10f, Average: %0.10f, STD: %0.10f', median070, average070, std070)
plot(0.70,median070,'rx')

average099 = mean(maximumFitnessList099);
median099 = median(maximumFitnessList099);
std099 = sqrt(var(maximumFitnessList099));
sprintf('PMut = 0.99: Median: %0.10f, Average: %0.10f, STD: %0.10f', median099, average099, std099)
plot(0.99,median099,'rx')

medianVal = [median000 median001 median002 median005 median010 median020 median030 median050 median070 median099];

xlim([-0.1 1.1])
ylim([0.99 1.003])
xlabel('pMut')
ylabel('Median performance')
