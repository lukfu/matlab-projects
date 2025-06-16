function [xmin,xmax,vmax,nVariable,c1,c2,w,alpha,deltaT] = InitializePSOVariables
nVariable = 2; % 2d, x,y -> x1,x2
xmin = -5; xmax = 5;
alpha = 1; deltaT = 1;
vmax = (xmax - xmin) / deltaT;
c1 = 2; c2 = 2;
w = 1.4;
end