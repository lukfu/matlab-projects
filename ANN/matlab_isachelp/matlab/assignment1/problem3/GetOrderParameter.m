%gets orderparameter
function m1 = GetOrderParameter(N,p,T,noiseBeta)
    m1 = 0;
    patterns = sign(2*rand(p,N)-1);
    weightMatrix = GetWeights(patterns);
    x1 = patterns(1,:);
    currentState = x1;
    for iTrial=1:T
        m1 = m1 + (1/N) * currentState*x1';
        currentState=AsynchronousStochasticUpdate(currentState,weightMatrix,noiseBeta);       
    end
    m1=m1/T;
end
