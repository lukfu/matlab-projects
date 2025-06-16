 
function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    nCities = size(pheromoneLevel,1);
    path = [];
    path = [path, randi(nCities)];
    for i=1:nCities-1
        path = [path, GetNode(path,pheromoneLevel, visibility, alpha, beta)];
    end
end