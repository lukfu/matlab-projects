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

mutationProbability=[0,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04...
                     0.1,0.3,0.5,0.7,0.9,1];
maximumFitnessList = zeros(numberOfRuns,length(mutationProbability));
for iMutation=1:length(mutationProbability)
    sprintf('Mutation rate = %0.5f', mutationProbability(iMutation))
    for iRun = 1:numberOfRuns 
     [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProbability(iMutation), numberOfGenerations);
      maximumFitnessList(iRun,iMutation) = maximumFitness;
    end
end
sprintf('program finished')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Summary of results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add more results summaries here (pMut < 0.02) ...
resultAverage=zeros(length(mutationProbability),3);
for iMutation = 1:length(mutationProbability)
    averageFitness = mean(maximumFitnessList(:,iMutation));
    medianFitness = median(maximumFitnessList(:,iMutation));
    stdFitness = sqrt(var(maximumFitnessList(:,iMutation)));
    resultAverage(iMutation,:)=[averageFitness,medianFitness,stdFitness];
end

%print result
PrintableVector = zeros(length(mutationProbability)*4,1);
PrintableVector(1:4:end-3) = mutationProbability;
PrintableVector(2:4:end-2) = averageFitness*1E-8;
PrintableVector(3:4:end-1) = medianFitness*1E-8;
PrintableVector(4:4:end) = stdFitness*1E-8;
fprintf('fitness divided by 10^8 to make ite more easily read\n')
fprintf('%13s %13s %13s %13s \n','p_mu','mean(x)','median(x)','std(x)');
fprintf('%12.4f %12.4f %12.4f %12.4f\n',PrintableVector);


%plot figure
plot(mutationProbability',resultAverage(:,2))
xlabel('probability of mutation')
ylabel('fitness')
title('median fitness for different mutation probabilities')
