%generate random genes for a given populationsize, with n genes
%each row represents a different individual
function population = InitializePopulation(populationSize, nGenes)
    population = zeros(populationSize, nGenes);
    for i = 1:populationSize
        for j = 1:nGenes
            s = rand;% 0<s<1
            if (s < 0.5)
                population(i,j)=0;
            else
                population(i,j)=1;
            end
        end
    end
end

%function equivalent to 

%population = fix(2.0*rand(populationSize,numberOfGenes));