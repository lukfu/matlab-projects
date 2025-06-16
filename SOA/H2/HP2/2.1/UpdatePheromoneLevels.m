function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
    pheromoneLevel = (1 - rho) * pheromoneLevel + deltaPheromoneLevel;
    for i = 1:length(pheromoneLevel)
        if pheromoneLevel(i) < 10^-15
            pheromoneLevel(i) = 10^-15;
        end
    end
end