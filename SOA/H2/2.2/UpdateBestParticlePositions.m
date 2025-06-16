function [bestOfParticlesPosition,bestOfSwarmPosition] = UpdateBestParticlePositions( ...
    bestOfParticlesPosition,bestOfSwarmPosition,particlePositions)
    bestOfSwarmEvaluated = Evaluate(bestOfSwarmPosition);
    for iParticle = 1:size(particlePositions,1)
        particle = particlePositions(iParticle,:);
        particleEvaluation = Evaluate(particle);

        bestOfParticlesParticle = bestOfParticlesPosition(iParticle,:);
        bestOfParticlesEvaluation = Evaluate(bestOfParticlesParticle);

        if particleEvaluation < bestOfParticlesEvaluation
            bestOfParticlesPosition(iParticle,:) = particle;
        end
        if particleEvaluation < bestOfSwarmEvaluated
            bestOfSwarmPosition = particle;
            bestOfSwarmEvaluated = particleEvaluation;
        end
    end
end