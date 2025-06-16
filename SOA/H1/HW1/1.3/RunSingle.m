%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change: (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;  	   % Do NOT change

tournamentSize = 5;                % Changes allowed
tournamentProbability = 0.6;      % Changes allowed (= pTour)
crossoverProbability = 0.8;        % Changes allowed (= pCross)
mutationProbability = 0.05;        % Changes allowed. (Note: 0.02 <=> 1/numberOfGenes)
numberOfGenerations = 2000;        % Changes allowed.

tabValues = zeros(3,10);
for i = 1:10
[maximumFitness, bestVariableValues] = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                       tournamentProbability, crossoverProbability, mutationProbability, numberOfGenerations);
gValue = 1/maximumFitness;
sprintf('Fitness: %d, g: %0.10f, x(1): %0.10f, x(2): %0.10f', maximumFitness, gValue, bestVariableValues(1), bestVariableValues(2))
tabValues(1,i) = gValue;
tabValues(2,i) = bestVariableValues(1);
tabValues(3,i) = bestVariableValues(2);
end



