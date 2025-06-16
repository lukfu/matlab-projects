
function [particlesWithBestPosition,bestPositionOfSwarm] = UpdateBestParticlesPosition(particlePositions,particlesWithBestPosition,bestPositionOfSwarm)
    
    evaluatedBestPositionOfSwarm = Evaluate(bestPositionOfSwarm);
    for iParticle = 1:size(particlePositions,1)
        particle = particlePositions(iParticle,:);
        evaluatedParticle = Evaluate(particle);
        
        bestPositionParticle = particlesWithBestPosition(iParticle,:);
        evaluatedBestPositionParticle = Evaluate(bestPositionParticle);
        
        if evaluatedParticle < evaluatedBestPositionParticle
            particlesWithBestPosition(iParticle,:) = particle;
        end
        
        if evaluatedParticle < evaluatedBestPositionOfSwarm
            evaluatedBestPositionOfSwarm = evaluatedParticle;
            bestPositionOfSwarm = particle;
        end
    end
    
end