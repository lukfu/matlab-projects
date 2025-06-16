function visibility = GetVisibility(cityLocation)
    nCities = size(cityLocation,1);
    distanceMatrix = zeros(nCities,nCities);
    for iTmp = 1:nCities 
        xdist = cityLocation(:,1)-cityLocation(iTmp,1);
        ydist = cityLocation(:,2)-cityLocation(iTmp,2);
        distanceMatrix(:,iTmp) = sqrt(xdist.^2+ydist.^2);
    end
    visibility = 1./distanceMatrix; 
end
