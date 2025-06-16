function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    indices = size(pheromoneLevel,1);
    startingIndex = randi(indices);
    tabuList = startingIndex;
    for i = 1:indices-1
        nextNode = GetNode(tabuList,pheromoneLevel,visibility,alpha,beta);
        tabuList(end+1) = nextNode;
    end
    tabuList(end+1) = startingIndex;
    path = tabuList;
    path(1) = [];
end