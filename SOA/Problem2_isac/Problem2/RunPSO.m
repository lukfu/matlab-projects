function bestPositionOfSwarm = RunPSO(nParticles,nGenerations,shouldPlotAnimation)
    [particlePositions,particleVelocity] = InitializeParticles(nParticles);
    particlesWithBestPosition = particlePositions;
    bestPositionOfSwarm = particlePositions(1,:);
    
    for iGeneration = 1: nGenerations 
        [particlesWithBestPosition,bestPositionOfSwarm] = UpdateBestParticlesPosition(particlePositions,...
            particlesWithBestPosition,bestPositionOfSwarm);
        
        [particlePositions,particleVelocity] = UpdateParticleVelocityAndPosition(particlePositions,...
            particleVelocity,particlesWithBestPosition,bestPositionOfSwarm,iGeneration); 
        if shouldPlotAnimation == true
            PlotGraphAndParticles(particlePositions)
        end
    end    
end