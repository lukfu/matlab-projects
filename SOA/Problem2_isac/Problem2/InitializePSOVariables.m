
function [xMin,xMax,nVariable,alpha,deltaT,vMax,...
    c1,c2,inertiaWeight] = InitializePSOVariables()
    
    xMin = -5;
    xMax = 5;
    nVariable = 2;
    alpha = 1;
    deltaT = 0.01;
    vMax = 25;
    c1 = 2;
    c2 = 2;
    inertiaWeight = 1.4;
end