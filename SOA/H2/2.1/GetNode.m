function nextNode = GetNode(tabuList,pheromoneLevel,visibility,alpha,beta)
    nodes = size(pheromoneLevel,1);
    currentNodeIndex = tabuList(end);
    sum = 0;
    probabilities = [];
    for l = 1:nodes
        if ~ismember(l,tabuList)
            sum = sum + pheromoneLevel(l,currentNodeIndex)^alpha * visibility(l,currentNodeIndex)^beta;
        end
    end
    for i = 1:nodes
        if ~ismember(i,tabuList)
            probability = (pheromoneLevel(i,currentNodeIndex)^alpha * visibility(i,currentNodeIndex)^beta) / sum;
            probabilities = [probabilities ; [i probability]];
        end
    end
    if size(probabilities,1) == 1
        nextNode = probabilities(1,1);
        return
    end
    r = rand;
    probSum = 0; iteration = 1;
    while r>probSum && size(probabilities,1)>iteration
        probSum = probSum + probabilities(iteration,2);
        iteration = iteration + 1;
    end
    nextNode = probabilities(iteration-1,1);
end