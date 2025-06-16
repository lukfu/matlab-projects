function [particlePositions,particleVelocities] = UpdateParticleVelocityAndPosition(...
    particlePositions,particleVelocities,bestOfParticlePosition,bestOfSwarmPosition,iGeneration)
    [~,~,vmax,nVariable,c1,c2,inertiaWeight,~,deltaT] = InitializePSOVariables;

    inertiaWeight = inertiaWeight * 0.99^(iGeneration);
    if inertiaWeight < 0.4
        inertiaWeight = 0.4;
    end

    q = rand(size(particlePositions,1),nVariable);
    r = rand(size(particlePositions,1),nVariable);
    velocityTerm1 = c1 * q .* (bestOfParticlePosition - particlePositions)/deltaT;
    velocityTerm2 = c2 * r .* (bestOfSwarmPosition - particlePositions)/deltaT;
    particleVelocities = inertiaWeight * particleVelocities + velocityTerm1 + velocityTerm2;
    for iParticle = 1:size(particleVelocities,1)
        normParticleVelocity = norm(particleVelocities(iParticle,:),2);
        if normParticleVelocity >= vmax
            particleVelocities(iParticle,:) = (vmax/normParticleVelocity) * particleVelocities(iParticle,:);
        end
    end
    particlePositions = particlePositions + particleVelocities*deltaT;
end