

%could restructure code such that we don't generate a whole weight matrix
%but simply a Rowvector of weightmatrix at nRand

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