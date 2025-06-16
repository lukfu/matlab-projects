%main code
p = [12,24,48,70,100,120];
N = 120;
trial = 10^5;

p_error = [];
for i = 1:length(p)
    p_error = [p_error; Perror(p(i),N,trial)];
end
disp(round(p_error,4))

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


%Gets weightMatrix (P x N size)
function WeightMatrix=GetWeights(patterns)
    Npatterns = size(patterns,1);   
    Nbits = size(patterns,2);
    WeightMatrix = zeros(Nbits,Nbits);
    
    for iPattern = 1:Npatterns
        patternI = patterns(iPattern,:);
        WeightMatrix = WeightMatrix+mtimes(patternI',patternI);
    end
    WeightMatrix = WeightMatrix/Nbits;
    
    %remove in part B
    for iBits = 1:Nbits
        WeightMatrix(iBits,iBits)=0;
    end

end


%update 1 bit asynchrounosly
function errorBit = UpdateBit(patterns,weight)
    Npatterns = size(patterns,1);   
    Nbits = size(patterns,2);

    pRand = fix(Npatterns*rand+1);
    nRand = fix(Nbits*rand+1);
 
    errorBit = 0;
    b_nRand = patterns(pRand,:)*weight(:,nRand);  %could check if c>1 or not
  
    sgn_bn = Sgn(b_nRand);
    if sgn_bn ~= patterns(pRand,nRand)
        errorBit = 1;
    end
end



%sign(x) with if == 0--> =1
function sgn = Sgn(x)
    sgn = sign(x);
    if sgn == 0 
        sgn = 1;
    end
end