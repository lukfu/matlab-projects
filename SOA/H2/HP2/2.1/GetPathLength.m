function pathLength = GetPathLength(path,cityLocation)
    pathLength = 0;
    for i = 1:length(path)-1
        indexPoint1 = path(i);
        indexPoint2 = path(i+1);
        point1 = cityLocation(indexPoint1,:);
        point2 = cityLocation(indexPoint2,:);
        pathLength = pathLength + norm(point2-point1);
    end
end