
function [temperatureMax,mass,tao,cH,temperatureAmbient,...
    cB,vMax,vMin,alphaMax,alphaMin,slopeLength] = InitiateTruckSlopeVariables()

    %Truck constants  (SI units)
    temperatureMax = 750;%k
    mass = 20000;%K
    tao = 30;%s
    cH = 40;%K/s
    temperatureAmbient = 283; %K
    cB = 3000;%N
    vMax = 25;%m/s
    vMin = 1;%m/s

    %slope Constants
    alphaMax = 10;%degree
    alphaMin = 0;%degree
    slopeLength = 1000;%m
end