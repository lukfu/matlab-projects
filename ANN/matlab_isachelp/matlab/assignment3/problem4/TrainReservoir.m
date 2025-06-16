function wOut = TrainReservoir(wIn, wReservoir,xTrain,kRidge)
   
   nReservoir = size(wReservoir,1);
   Ttrain = size(xTrain,2);
   R = zeros(nReservoir,Ttrain);   
   rNext = zeros(nReservoir,1);
   
   for t = 1:Ttrain
      R(:,t) = rNext;
      xNext = xTrain(:,t);
      rNext = tanh(wReservoir*rNext+wIn*xNext); 
   end
   Rt = transpose(R);
   wOut = xTrain*Rt*inv(R*Rt+kRidge*eye(nReservoir));
    % CHECK it learned well
    %    x = wOut*R;
    %    hold on
    %    plot3(x(1,:),...
    %       x(2,:),...
    %       x(3,:),'r+');
    %    plot3(xTrain(1,:),...
    %       xTrain(2,:),...
    %       xTrain(3,:),'bo');
end