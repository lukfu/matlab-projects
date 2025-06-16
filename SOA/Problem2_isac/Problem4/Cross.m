
function newIndividuals = Cross(individual1, individual2)
    individual1 = individual1.Chromosome;
    individual2 = individual2.Chromosome;

    %divide chromosome into blocks and choose crossOverPoint
    nGenes1Tmp = length(individual1)/4;
    nGenes2Tmp = length(individual2)/4;
    blockCrossPoint1Gene1 = 1 + randi(nGenes1Tmp-2);   
    blockCrossPoint2Gene1 = 1 + randi(nGenes1Tmp-2);
    blockCrossPoint1Gene2 = 1 + randi(nGenes2Tmp-2);
    blockCrossPoint2Gene2 = 1 + randi(nGenes2Tmp-2);
    
    if blockCrossPoint1Gene1 > blockCrossPoint2Gene1
        tmpCopy = blockCrossPoint1Gene1;
        blockCrossPoint1Gene1 = blockCrossPoint2Gene1;
        blockCrossPoint2Gene1 = tmpCopy;
    end
    if blockCrossPoint1Gene2 > blockCrossPoint2Gene2
        tmpCopy = blockCrossPoint1Gene2;
        blockCrossPoint1Gene2 = blockCrossPoint2Gene2;
        blockCrossPoint2Gene2 = tmpCopy;
    end
    %blockCrossOverPoint --> GeneCrossOverPoint
    GeneCrossPoint1Gene1 = 4*(blockCrossPoint1Gene1-1)+1;
    GeneCrossPoint2Gene1 = 4*blockCrossPoint2Gene1;
    GeneCrossPoint1Gene2 = 4*(blockCrossPoint1Gene2-1)+1;
    GeneCrossPoint2Gene2 = 4*blockCrossPoint2Gene2;
    
    %update new individuals
    newIndvidual1 = [];
    newIndvidual1 = [newIndvidual1,individual1(1:GeneCrossPoint1Gene1-1)];
    newIndvidual1 = [newIndvidual1,individual2(GeneCrossPoint1Gene2:GeneCrossPoint2Gene2)];
    newIndvidual1 = [newIndvidual1,individual1(GeneCrossPoint2Gene1+1:end)];

    newIndvidual2 = [];
    newIndvidual2 = [newIndvidual2,individual2(1:GeneCrossPoint1Gene2-1)];
    newIndvidual2 = [newIndvidual2,individual1(GeneCrossPoint1Gene1:GeneCrossPoint2Gene1)];
    newIndvidual2 = [newIndvidual2,individual2(GeneCrossPoint2Gene2+1:end)];

    newIndividuals = [struct('Chromosome',newIndvidual1),struct('Chromosome',newIndvidual2)];
end