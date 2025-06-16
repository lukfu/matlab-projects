function [particlePositions,particleVelocities] = InitializeParticles(nParticles)
    [xmin,xmax,~,nVariable,~,~,~,alpha,deltaT] = InitializePSOVariables();
    particlePositions = xmin + (xmax-xmin) * rand(nParticles,nVariable);
    particleVelocities = alpha/deltaT * ((xmax-xmin) * rand(nParticles,nVariable) - (xmax-xmin)/2);
end