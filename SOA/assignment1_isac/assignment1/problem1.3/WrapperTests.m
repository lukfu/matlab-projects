clc
% mutation test
nGenes=10^5;
individual = ones(1,nGenes);
mutationProbability = 0.5;
individual2 = Mutate(individual, mutationProbability);
condition1 = (0.48<sum(individual2)/nGenes && sum(individual2)/nGenes<0.52);
condition2 = (Mutate(individual, 0) ==individual);
condition3 = (Mutate(individual, 1) ==(1-individual));
TestSucess = condition1 .* condition2 .* condition3;
if TestSucess
   disp('mutation test success')
else
    disp('mutation test fail')
end

% cross test

TestSucess=true;
individual1=[0,0,0,0,1,1,1,1];
individual2=[1,1,1,1,0,0,0,0];
newIndividuals=Cross(individual1, individual2);
newIndividual1=newIndividuals(1,:);
newIndividual2=newIndividuals(2,:);

condition1 = (newIndividual1(1)==0 && newIndividual2(1)==1);
condition2 = (sum(newIndividual1+newIndividual2)==sum(individual1+individual2));
condition3 = sum(abs(newIndividual1-individual1));
TestSucess = condition1 .* condition2 .* condition3;
if TestSucess
   disp('crossover test success')
else
    disp('crossover test fail')
end

% InitalizePopulation test

N=50;
population=InitializePopulation(N,N);
TestSucess=(0.48<sum(sum(population))/N^2 && sum(sum(population))/N^2<0.52);
if TestSucess
   disp('InitalizePopulation test success')
else
    disp('InitalizePopulation test fail')
end

% evaluateIndividual test
TestSucess=(EvaluateIndividual([1,0]) >= EvaluateIndividual([0,0]));
if TestSucess
   disp('evaluateIndividual test success')
else
    disp('evaluateIndividual test fail')
end

% DecodeChromosome test
chromosome = [1,1,1,1,0,0,0,0,0];
nVariables = 3;
maxInterval = 3;
x = DecodeChromosome(chromosome,nVariables,maxInterval);
condition1 = (x(1) > x(2)) && (x(2) > x(3));
condition2 = (x(1) == 3) && (x(3) == -3);
TestSucess = condition1 .* condition2;
if TestSucess
   disp('DecodeChromosome test success')
else
    disp('DecodeChromosome test fail')
end


% TournamentSelect test from book page50

fitnessList=[2,1,5,11,14];
selectF1Sum=0;
trials=10^5;
for iTemp=1:trials
    selectedIndex=TournamentSelect(fitnessList, 0.8, 2);
    if selectedIndex==1
        selectF1Sum=selectF1Sum+1;
    end
end
probSelectF1=selectF1Sum/trials;
condition1=(0.148<probSelectF1) && (probSelectF1<0.156);
TestSucess = condition1;
if TestSucess
   disp('TournamentSelect test success')
else
    disp('TournamentSelect test fail')
end













