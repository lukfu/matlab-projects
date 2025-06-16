function OutputPredict = predict(wIn,wReservoir,wOut,xTest,TimeStepsPredict)
    
    nInput = size(xTest,1);
    nReservoir = size(wReservoir,2);
    Ttest = size(xTest,2);
    R = zeros(nReservoir,Ttest+TimeStepsPredict);   
    rNext = zeros(nReservoir,1);
    for t = 1:Ttest-1
      R(:,t) = rNext;
      xNext = xTest(:,t);
      rNext = tanh(wReservoir*rNext+wIn*xNext); 
    end

    OutputPredict = zeros(nInput,TimeStepsPredict);
    for t = 1:TimeStepsPredict
      oNow = wOut*rNext;
      OutputPredict(:,t)  = oNow;
      rNext = tanh(wReservoir*rNext+wIn*oNow); 
    end
end