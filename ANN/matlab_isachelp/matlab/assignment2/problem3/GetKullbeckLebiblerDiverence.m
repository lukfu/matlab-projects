
function DKL = GetKullbeckLebiblerDiverence(Pb,weight,thetaVisible,thetaHidden,patterns)
    
    pData=1/4;
    DKL =0;
    for iPattern =1:4 %pdata(x5-x8)=0, else =1/4
        DKL = DKL + pData*log(pData/Pb(iPattern));
    end 
end



















