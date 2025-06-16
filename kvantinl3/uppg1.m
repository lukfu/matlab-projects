clf
clc
clear

sigma = 1; %value of sigma can be (somewhat) freely chosen
hbar = 6.626e-34 / (2 * pi);
m = 9.109e-31; %electron mass, change for other particles
N = 1/sqrt(sigma * sqrt(2 * pi));
psiG = @(x,t) N * (sigma / sqrt(sigma^2 + 1i * hbar * t / (2 * m))) * exp(- x.^2 / (4 * (sigma^2 + 1i * hbar * t / (2 * m))));

for x=-10:0.01:10
    psi1 = psiG(x,0);
    plot(x,abs(psi1)^2,'.r')
    hold on
end

for x=-10:0.01:10
    psi2 = psiG(x,25e3);
    plot(x,abs(psi2)^2,'.g')
    hold on
end

for x=-10:0.01:10
    psi3 = psiG(x,5e4);
    plot(x,abs(psi3)^2,'.b')
    hold on
end

for x=-10:0.01:10
    psi4 = psiG(x,1e5);
    plot(x,abs(psi4)^2,'.y')
    hold on
end

grid minor
