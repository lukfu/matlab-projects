
function [particlePositions,particleVelocity] = UpdateParticleVelocityAndPosition(particlePositions,particleVelocity,...
    particlesWithBestPosition,bestPositionOfSwarm,iGeneration)

    [~,~,nVariable,~,deltaT,vMax,...
        c1,c2,inertiaWeight] = InitializePSOVariables();
    inertiaWeight = inertiaWeight*(0.99)^(iGeneration);
    if inertiaWeight < 0.4
        inertiaWeight = 0.4;
    end

    q = rand(size(particlePositions,1),nVariable);
    r = rand(size(particlePositions,1),nVariable);
    velocityTerm2 = c1*q.*(particlesWithBestPosition-particlePositions)/deltaT;
    velocityTerm3 = c2*r.*(bestPositionOfSwarm-particlePositions)/deltaT;
    particleVelocity = inertiaWeight*particleVelocity + velocityTerm2 + velocityTerm3;
    for iParticle = 1:size(particlePositions,1)
        normParticleVelocity = norm(particleVelocity(iParticle,:),2);
        if normParticleVelocity >= vMax
            particleVelocity(iParticle,:) = (vMax/normParticleVelocity) * particleVelocity(iParticle,:);
        end
    end
    
    particlePositions = particlePositions + particleVelocity*deltaT;
end




