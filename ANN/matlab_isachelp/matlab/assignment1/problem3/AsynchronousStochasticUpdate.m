
%aynchrounous stochastic update of 1 bit
function newState = AsynchronousStochasticUpdate(currentState,weightMatrix, noiseBeta)
    nRand = floor(length(currentState)*rand+1); %update random bit
    bn = weightMatrix(nRand,:)*currentState';
    
    newState = currentState;
    if rand <= Pb(bn,noiseBeta)
        newState(nRand) = 1;
    else
        newState(nRand) = -1;
    end 
end