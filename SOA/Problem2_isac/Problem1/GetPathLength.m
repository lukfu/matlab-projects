function   pathLength = GetPathLength(path,cityLocation)
    %distance matrix
    nCities = size(cityLocation,1);
    distanceMatrix = zeros(nCities,nCities);
    for iTmp = 1:nCities 
        xdist = cityLocation(:,1)-cityLocation(iTmp,1);
        ydist = cityLocation(:,2)-cityLocation(iTmp,2);
        distanceMatrix(:,iTmp) = sqrt(xdist.^2+ydist.^2);
    end
    
    %pathlength calculation
    pathLength = 0;
    path = [path, path(1)];
    for iPath = 1:length(path)-1
        iCurrentPath = path(iPath);
        jNextPath = path(iPath + 1);
        pathLength = pathLength + distanceMatrix(iCurrentPath,jNextPath);
    end
end




