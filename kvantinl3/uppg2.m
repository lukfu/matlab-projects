clear
clc
clf

sigma = 1;
hbar = 6.626e-34 / (2 * pi);
m = 9.109e-31; %electron mass, change for other particles
N = 1/sqrt(sigma * sqrt(2 * pi));

psiG = @(x,t) N * (sigma / sqrt(sigma^2 + 1i * hbar * t / (2 * m))) * exp(- x.^2 / (4 * (sigma^2 + 1i * hbar * t / (2 * m))));

a = 5;
v = 299792458;

psiGxy = @(x,y) N .* (sigma ./ sqrt(sigma^2 + 1i .* hbar .* y ./ (2 .* m))) .* exp(- x.^2 ./ (4 * (sigma^2 + 1i * hbar .* y ./ (2 * m))));

x = linspace(-30,30,1000);
y = linspace(0,2.5e5,1000);
[X,Y] = meshgrid(x,y);
z = psiGxy(X + a,Y) + psiGxy(X - a,Y);
surf(X,Y,abs(z).^2)
h = surf(X,Y,abs(z).^2);
rotate3d on
set(h,'edgecolor','none')

%for x=-10:0.02:10
%    psi1 = psiG(x - a,0);
%    psi2 = psiG(x + a,0);
%    psi12 = psi1 + psi2;
%    plot(x,abs(psi1)^2,'.g')
%    plot(x,abs(psi2)^2,'.g')
%    plot(x,abs(psi12)^2,'.k')
%    hold on
%end

%for x=-10:0.02:10
%    psi3 = psiG(x - a,1e5);
%    psi4 = psiG(x + a,1e5);
%    psi34 = psi3 + psi4;
%    %plot(x,abs(psi3)^2,'.y')
%    %plot(x,abs(psi4)^2,'.y')
%    plot(x,abs(psi34)^2,'.r')
%    hold on
%end

%for x=-10:0.02:10
%    psi5 = psiG(x - a,2e5);
%    psi6 = psiG(x + a,2e5);
%    psi56 = psi5 + psi6;
%    %plot(x,abs(psi5)^2,'.y')
%    %plot(x,abs(psi6)^2,'.y')
%    plot(x,abs(psi56)^2,'.b')
%    hold on
%end
%legend('t=0','t=1e5','t=2e5')





