function predictionOutput = Predict(wIn,wReservoir,xTest,wOut,predictTimestep)
nInput = size(xTest,1);
nReservoir = size(wReservoir,2);
testT = size(xTest,2);
R = zeros(nReservoir,testT+predictTimestep);
rNext = zeros(nReservoir,1);
for t = 1:testT
    R(:,t) = rNext;
    xNext = xTest(:,t);
    rNext = tanh(wReservoir * rNext + wIn * xNext);
end

predictionOutput = zeros(nInput,predictTimestep);
for t = 1:predictTimestep
    outputNow = wOut*rNext;
    predictionOutput(:,t) = outputNow;
    rNext = tanh(wReservoir * rNext + wIn * outputNow);
end
end