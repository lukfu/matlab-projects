clf
clc

hold on
T_E = 124.9;
T = linspace(0,500,1e3);
m = 1;
M = 23;
avogadro = 6.022*1e23;
N = m/M*avogadro;

plot(T,C_V(T,T_E,N),'k','Linewidth',1.5)

limit = 3*N*1.381*1e-23;
Limit = ones(size(T))*limit;
plot(T,Limit,'r--')
title('Värmekapacitet C_v för Natrium')
xlabel('T [K]'); ylabel('C_v [J/K]')

hold off

