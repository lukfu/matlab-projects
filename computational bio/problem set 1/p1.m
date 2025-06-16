%% problem 1
%a

clear;clc;clf;

T_all = linspace(0.1,5,50);
for T=T_all
    plotN(T,500)
    pause(0.1)
end
tmax=500;T=[0.1,3,5];
hold off;
for i=1:3
    figure
    plotN(T(i),tmax)
    title('T=' + string(T(i)) )
end

%% b
clf
t=(0.1:0.1:5)';
tmax = 100;
amplitudeDiff=zeros(length(t),1);
for iT=1:50
    T=iT/10;
    [x,y]=getxy(T,tmax);
    TF = islocalmax(y);
    amplitudeDiff(iT) = max(y(TF))-min(y(TF));
end
hold on
plot(t,amplitudeDiff) % amp diff starts increasing around T=1.2
plot([1.2,1.2],[-1,40],'r--')
xlim([0 5])
ylim([-1 50])
xlabel('T')
ylabel('Amplitude difference')
title('Start of damped oscillation, Estimate')

%% c
clf
%search for limitcycle--> grows/shrinks in beginning and periodic always
T=3.9; %also run for 3.7 and 4.1 to show difference before and after TH
TT=6000;
[x,y]=getxy(T,TT);
dt=0.1; delay=floor(T/dt);
x2 = 0.1:dt:TT;
y2 = interp1(x,y,x2,'spline');
nty1 = y2(delay+1:end);
nty2 = y2(1:end-delay);
plot(nty1,nty2,'b')
xlabel('N(t)')
ylabel('N(t+1)')
title('Hopf bifurcation at Th=3.9')
%title('T=3.7')
%title('T=4.1')

%% d
syms a
k=-2/5; %-2/5 for our problem
N=50;
lambda = zeros(N,1);
delay = zeros(N,1);

% solving each eq for eigenvalues
for iT=1:N
    iT
    T=iT*5/N;
    sol = solve(a == k*exp(-a*T));    
    delay(iT)=T;
    lambda(iT)=sol;
end
clf
hold on;
plot(delay,imag(lambda),'r') %imaginary part
plot(delay,real(lambda),'b') %real part
plot([3.9,3.9],[-1,0.8],'k--') %hopf bifurcation point
plot([0,5],[0,0],'k--')
xlabel('T')
ylabel("\lambda',  \lambda''")
legend('IM lambda','RE lambda','Th~3.9')
title('Analyical solution using linear stability analysis')

%% functions

function plotN(T,tmax)
    tspan = [0 tmax];
    lags = T;
    sol = dde23(@ddefunc, lags, @history, tspan);
    plot(sol.x,sol.y,'')
    title(T)
    xlabel('Time t');
    ylabel('Population N');
end
function [x,y] = getxy(T,tmax)
    tspan = [0 tmax];
    lags = T;
    sol = dde23(@ddefunc, lags, @history, tspan);
    x = sol.x; y = sol.y;
end
function dydt = ddefunc(t,N,Z)
    Nlag = Z(:,1);
    A = 20;
    K = 100;
    r = 0.1;
    dydt = r*N * (1 - Nlag(1)/K) * (N/A - 1);
end
function s = history(t)
  s = 50;
end
