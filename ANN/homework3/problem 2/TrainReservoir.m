function wOut = TrainReservoir(wIn,wReservoir,kRidge,xTrain)
    nReservoir = size(wReservoir,1);
    trainT = size(xTrain,2);
    R = zeros(nReservoir,trainT);
    rNext = zeros(nReservoir,1);

    for t = 1:trainT
        R(:,t) = rNext;
        xNext = xTrain(:,t);
        rNext = tanh(wReservoir * rNext + wIn * xNext);
    end
    wOut = xTrain * R.' * inv(R * R.' + kRidge * eye(nReservoir));
end