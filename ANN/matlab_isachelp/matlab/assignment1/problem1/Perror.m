%calculates Perror for 1 timestep
function pErr=Perror(nrOfPatterns,nrOfBits,nrOfTrials)

    pErr = 0;
    for iTrial = 1:nrOfTrials
        patterns = sign(2*rand(nrOfPatterns,nrOfBits)-1);
        weightMatrix = GetWeights(patterns);
        %update
        pErr = pErr + UpdateBit(patterns,weightMatrix);
    end
    pErr = pErr/nrOfTrials;

end