function bestOfSwarmPosition = RunPSO(nParticles,nGenerations,plotAnimation)
[particlePositions,particleVelocities] = InitializeParticles(nParticles);
bestOfParticlesPositions = particlePositions;
bestOfSwarmPosition = particlePositions(1,:);

for iGeneration = 1:nGenerations
    [bestOfParticlesPositions,bestOfSwarmPosition] = UpdateBestParticlePositions(...
        bestOfParticlesPositions,bestOfSwarmPosition,particlePositions);

    [particlePositions,particleVelocities] = UpdateParticleVelocityAndPosition(...
        particlePositions,particleVelocities,bestOfParticlesPositions,bestOfSwarmPosition,iGeneration);
    if plotAnimation == true
        PlotGraphAndParticles;
    end
end
