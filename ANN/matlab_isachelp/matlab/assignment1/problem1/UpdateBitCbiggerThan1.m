
function errorBit = UpdateBitCbiggerThan1(patterns,weight)
    Npatterns=size(patterns,1);   
    Nbits=size(patterns,2);

    pRand=fix(Npatterns*rand+1);
    errorBit=0;
    for i=1:Nbits %check for just a single error
        b_n=patterns(pRand,:)*weight(:,i);  %could check if c>1 or not
        sgn_bn=sign(b_n);
        if sgn_bn==0 
            sgn_bn=1;
        end
        if sgn_bn~=patterns(pRand,i)
            errorBit=1;
        end
    end

end