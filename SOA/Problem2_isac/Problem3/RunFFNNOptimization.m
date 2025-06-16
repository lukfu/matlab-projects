function [maximumFitnessList,maximumFitnessListValidation, bestChromosome] =  RunFFNNOptimization(contantsGA, constantsFFNN, timestep)

    %initialize variables
    populationSize = contantsGA.populationSize;
    numberOfGenes = contantsGA.numberOfGenes;
    tournamentProbability = contantsGA.tournamentProbability;
    tournamentSize = contantsGA.tournamentSize;
    mutationProbability = contantsGA.mutationProbability;
    crossoverProbability = contantsGA.crossoverProbability;
    nOut = constantsFFNN.nOut;
    nIn = constantsFFNN.nIn;
    nHidden = constantsFFNN.nHidden;
    wMax = constantsFFNN.wMax;
    iGeneration = 1;
    maximumFitnessList=[];
    maximumFitnessListValidation=[];

    population = InitializePopulation(populationSize,numberOfGenes); 
    conditions = true;
    while conditions
        maximumFitness  = 0.0;
        fitnessList = zeros(populationSize,1);
        %update fitness
        for i = 1:populationSize
            chromosome = population(i,:);
            [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);
            [fitnessEvaluated] = EvaluateIndividual(wIH, wHO, timestep, 1);
            fitnessList(i) = fitnessEvaluated;
            if fitnessList(i) > maximumFitness  
                maximumFitness  = fitnessList(i);
                iBestIndividual = i;
                bestChromosome = chromosome;
                [wIH, wHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);
                validationFitness = EvaluateIndividual(wIH, wHO, timestep, 2);
            end
        end

        
        %selection and crossover
        temporaryPopulation = population;  
        for i = 1:2:populationSize-1
            i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
            i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
            r = rand;
            if (r < crossoverProbability) 
                individual1 = population(i1,:);
                individual2 = population(i2,:);
                newIndividualPair = Cross(individual1, individual2);
                temporaryPopulation(i,:) = newIndividualPair(1,:);
                temporaryPopulation(i+1,:) = newIndividualPair(2,:);
            else
                temporaryPopulation(i,:) = population(i1,:);
                temporaryPopulation(i+1,:) = population(i2,:);     
            end
        end

        %mutation and eliteism
        temporaryPopulation(1,:) = population(iBestIndividual,:);
        for i = 2:populationSize
            tempIndividual = Mutate(temporaryPopulation(i,:),mutationProbability);
            temporaryPopulation(i,:) = tempIndividual;
        end
        population = temporaryPopulation;

        
        %update loop-conditions
        condition1 = (validationFitness < 18E3);
        condition2 = (maximumFitness < 18E3);
        conditions = (condition1 || condition2);
        
 
        maximumFitnessList(iGeneration) = maximumFitness;
        maximumFitnessListValidation(iGeneration) = validationFitness;
        fprintf('Generation: %0.0f, MaxFitness: %0.0f, ValidationFitness: %0.0f\n',iGeneration,maximumFitness,validationFitness);
        iGeneration = iGeneration + 1;
    end

end



