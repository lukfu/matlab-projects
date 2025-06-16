%% a
for T=2:0.1:3.8
    plotN(T,500)
    pause(0.1)
end
tmax=500;T=[0.1,2.5,5];
hold off;
for i=1:3
    figure
    plotN(T(i),tmax)
    title('T=' + string(T(i)) )
end
%%  b
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
plot(t,amplitudeDiff) %see T around 1.2 --> start of damped oscillation
plot([1.2,1.2],[-1,40],'k--')
xlabel('t')
ylabel('Amplitude difference')
title('estimate damped oscillation start')
%% c
clf
%search for limitcycle--> grows/shrinks in beginning and periodic always
% TT=10000;
% for T=3.94:0.01:3.95
%     [x,y]=getxy(T,TT);
%     dt=0.1; delay=floor(T/dt);
%     x2 = 0.1:dt:TT;
%     y2 = interp1(x,y,x2,'spline');
%     nty1 = y2(delay+1:end);
%     nty2 = y2(1:end-delay);
%     plot(nty1,nty2,'b')
%     xlim([170,205])
%     ylim([82,102])
%     title(T)
%     pause(1)
% end 

T=3.9;
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
title('Hopf bifurcation Th=3.9')

%We see that T=4.44 limit cycle --> stable cycle)
% we see that T approx 3.94 limit cycle forms
%% d
syms a
k=-2/5;%-2/5 for our problem
N=50;
lambda = zeros(N,1);
delay = zeros(N,1);

for iT=1:N
    iT
    T=iT*5/N;
    sol = solve(a == k*exp(-a*T));    
    delay(iT)=T;
    lambda(iT)=sol;
end
clf
hold on;
plot(delay,imag(lambda),'r')
plot(delay,real(lambda),'b')
plot([3.9,3.9],[-1,0.8],'k--')
plot([0,5],[0,0],'k--')
xlabel('T')
ylabel("\lambda',  \lambda''")
legend('lambda1','lambda2','Th~3.9')
title('analyical solution with  linear stability analysis')
%We see that the 2 values match;
% one approx:3.9 , one approx:4.4
% reason?











function plotN(T,tmax)
    tspan = [0 tmax];
    lags = T;
    sol = dde23(@ddefun, lags, @history, tspan);
    plot(sol.x,sol.y,'')
    title(T)
    xlabel('Time t');
    ylabel('Solution N');
end
function [x,y] = getxy(T,tmax)
    tspan = [0 tmax];
    lags = T;
    sol = dde23(@ddefun, lags, @history, tspan);
    x = sol.x; y = sol.y;
end
function dydt = ddefun(t,N,Z)
    Nlag = Z(:,1);
    A = 20;
    K = 100;
    r = 0.1;
    dydt = r*N * (1 - Nlag(1)/K) * (N/A - 1);
end
function s = history(t)
  s = 50;
end