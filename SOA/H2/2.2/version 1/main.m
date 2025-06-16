clc; clf, clear;
a = 0.01;
x = linspace(-5,5,1000);
y = linspace(-5,5,1000);
[X,Y] = meshgrid(x,y);
f = FunctionPSO(X,Y);
%f = sin(X) + cos(Y);
Z = log(a + f);
contourf(X,Y,Z,10)

hold on
minimaVecLength = 50;
allMinima = zeros(minimaVecLength,3);
for i = 1:minimaVecLength
    minima = RunPSO;
    allMinima(i,:) = minima;
    x = minima(1);
    y = minima(2);
    plot(x,y,'rx')
end