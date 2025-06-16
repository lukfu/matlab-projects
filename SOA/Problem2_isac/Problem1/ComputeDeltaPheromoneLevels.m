function  deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    pheromoneMatrixSize = size(pathCollection,2);
    nAnts = size(pathCollection,1);
    deltaPheromoneLevel = zeros(pheromoneMatrixSize,pheromoneMatrixSize);
    for iAnt = 1:nAnts
        pathLength = pathLengthCollection(iAnt);
        path = pathCollection(iAnt,:);
        path = [path, path(1)];
        for iPath = 1:length(path)-1
            currentNode = path(iPath);
            nextNode = path(iPath+1);
            deltaPheromoneLevel(nextNode,currentNode) = deltaPheromoneLevel(nextNode,currentNode) + 1/pathLength;
        end
    end
end



