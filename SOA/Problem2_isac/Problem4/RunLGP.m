function [fitnessGenerations, bestChromosome] =  RunLGP(constantsGA)
    %initiate variable
    tournamentSize = constantsGA.tournamentSize;
    tournamentProbability = constantsGA.tournamentProbability;
    crossoverProbability = constantsGA.crossoverProbability;
    populationSize = constantsGA.populationSize;
    nGenerations = constantsGA.nGenerations;
    population = InitializePopulation(populationSize);
    fitnessGenerations=zeros(nGenerations,1);

    for iGeneration = 1:nGenerations
        maximumFitness  = 0;
        fitnessList = zeros(populationSize,1);

        %update fitness
        for i = 1:populationSize
            chromosome = population(i);
            fitnessList(i) = EvaluateIndividual(chromosome);
            if (fitnessList(i) > maximumFitness ) 
                maximumFitness  = fitnessList(i);
                bestChromosome = chromosome;
            end
        end
        fitnessGenerations(iGeneration) = maximumFitness;
        temporaryPopulation = population; 
                  
        %tournament select and cross Over
        for i = 1:2:populationSize
            i1 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
            i2 = TournamentSelect(fitnessList,tournamentProbability,tournamentSize);
            r = rand;
            if (r < crossoverProbability) 
                individual1 = population(i1);
                individual2 = population(i2);
                newIndividualPair = Cross(individual1, individual2);
                temporaryPopulation(i) = newIndividualPair(1);
                temporaryPopulation(i+1) = newIndividualPair(2);
            else
                temporaryPopulation(i) = population(i1);
                temporaryPopulation(i+1) = population(i2);     
            end
        end
        
        temporaryPopulation(1) = bestChromosome;
        %Eliteism and Mutation   
        for i = 2:populationSize
            tempIndividual = Mutate(temporaryPopulation(i));
            temporaryPopulation(i) = tempIndividual;
        end         
        
        population = temporaryPopulation;
        if (mod(iGeneration,100) == 0)
            fprintf('Gen %0.0f, fitness: %0.4f\n',iGeneration,maximumFitness)
        end
        
    end

end