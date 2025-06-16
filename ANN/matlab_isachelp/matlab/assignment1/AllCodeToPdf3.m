%Main code
N = 200;
p = 45;
T = 2*10^5;
noise_beta = 2;

%for loop to average m1 to be implemented
mAverage = 0;
averageTrial = 100;
for i = 1:averageTrial
    mAverage = mAverage + GetOrderParameter(N,p,T,noise_beta);
end
round(mAverage/averageTrial,3)

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

%stochastic update probability
function pB = Pb(bi,noise_beta)
    pB=1/(1+exp(-2*noise_beta*bi));
end


%get WeightMatrix (P x N size)
function WeightMatrix = GetWeights(patterns)
    Npatterns = size(patterns,1);   
    Nbits = size(patterns,2);
    WeightMatrix = zeros(Nbits,Nbits);
    
    for iPattern = 1:Npatterns
        patternI = patterns(iPattern,:);
        WeightMatrix = WeightMatrix+mtimes(patternI',patternI);
    end
    WeightMatrix = WeightMatrix/Nbits;
    
    %modified hebbs rule
    for iBits = 1:Nbits
        WeightMatrix(iBits,iBits) = 0;
    end
end


%sign(x) but if ==0 -> =1
function sgn = Sgn(x)
    sgn = sign(x);
    if sgn == 0 
        sgn = 1;
    end
end