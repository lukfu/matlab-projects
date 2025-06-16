function nextNode = GetNode(currentPath,pheromoneLevel, visibility, alpha, beta)
    
    allPaths = 1:size(pheromoneLevel,1);
    possiblePaths = allPaths;
    possiblePaths(currentPath) = [];
    currentNode = currentPath(end);
    
    normalizeFactor = 0;
    for iPath = 1:length(possiblePaths)
        nextNode = possiblePaths(iPath);
        tmp1 = pheromoneLevel(nextNode,currentNode)^alpha;
        tmp2 = visibility(nextNode,currentNode)^beta;
        normalizeFactor = normalizeFactor + tmp1 * tmp2;
    end
    
    %choose path to add
    r = rand;
    pathProbability = 0;
    for iPath = 1:length(possiblePaths)
        nextNode = possiblePaths(iPath);
        tmp1 = pheromoneLevel(nextNode,currentNode)^alpha;
        tmp2 = visibility(nextNode,currentNode)^beta;
        pathProbability = pathProbability + (tmp1 * tmp2)/normalizeFactor;
        if r < pathProbability
            return
        end
    end
    
end