function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)
    ants = size(pathCollection,1);
    deltaPheromoneLevel = zeros(ants,ants);
    kDeltaPheromoneLevel = zeros(ants,ants);
    for k = 1:ants
        antPath = pathCollection(k,:);
        antPathLength = pathLengthCollection(k);
        for l = 1:length(antPath)-1
            iPath1 = antPath(l);
            iPath2 = antPath(l+1);
            kDeltaPheromoneLevel(iPath1,iPath2) = 1/antPathLength;
        end
        deltaPheromoneLevel = deltaPheromoneLevel + kDeltaPheromoneLevel;
    end
end