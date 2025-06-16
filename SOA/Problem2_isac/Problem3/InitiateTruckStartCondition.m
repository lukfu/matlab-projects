
function [temperatureBrake,x,v,gear,deltaTb] = InitiateTruckStartCondition(temperatureAmbient)
    temperatureBrake = 500;%K
    x = 0; %m
    v = 20;%m/s
    gear = 7;
    deltaTb = temperatureBrake-temperatureAmbient;
end