
function [particlePositions,particleVelocity] = InitializeParticles(nParticles)
    [xMin,xMax,nVariable,alpha,deltaT,~,~,~,~] = InitializePSOVariables();
    xDist = xMax - xMin; 
    particlePositions = xMin + xDist*rand(nParticles,nVariable);   
    particleVelocity = alpha/deltaT * (xDist*rand(nParticles,nVariable) - xDist/2);
end