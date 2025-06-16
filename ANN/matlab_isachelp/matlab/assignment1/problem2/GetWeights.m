
%get weightMatrix (P x N size)
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