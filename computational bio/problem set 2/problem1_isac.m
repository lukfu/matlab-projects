syms p q u
ode = 0 == p*u*(1-u/q)-u/(u+1);
ySol = solve(ode,u);
f1 = @(p,q) (p*q - p + (p*(p - 4*q + 2*p*q + p*q^2))^(1/2))/(2*p);%stable
f2 = @(p,q) -(p - p*q + (p*(p - 4*q + 2*p*q + p*q^2))^(1/2))/(2*p);%unstable and positive iff p<1


clc
p=0.5;q=8;
f1(p,q)
f2(p,q)

x0List=[20,50,50,50];
u0List=[f1(p,q),f2(p,q),f2(p,q)*1.1,f2(p,q)-0.001];
i=4;
u0=u0List(i);
x0=x0List(i);

u_start = @(x) u0./(1+exp(x-x0));
dt=1E-3;
tmax=1E3;
% run
clf
[vec,t] = runDynamics(u_start,dt,tmax,2000);
%% get speedvector
vec3 = getSpeedVector(vec,u0/2,true);
%%
imin = 5E4;
imax=3.2E5;
speed = getSpeed(t(imin:imax),vec3(imin:imax),true)
%% get img side by side
clf
u=vec(:,2E5);
v = getV(u,true);
%% get stability of fixed points by c, seems wrong
getStability(speed,f2(p,q));

%% 1c


dt=1E-4;
tmax=1E1;
u0=f1(p,q);
x0=50;
u_start = @(x) u0*exp(-(x-x0).^2);

[vec,t] = runDynamics(u_start,dt,tmax);

%% Functions

function isStable = getStability(cc,ustar)
    p=0.5;q=8;
    u_func = @(u) p - 2*p*u/q - 1/(1+u)^2;
    A=[0,1;-u_func(ustar),-cc];
    lambda = eig(A)%-signs cancel out somehow
    [det(A),trace(A)];
    isStable = (lambda(1)<0) && (lambda(2)<0);
end

function v = getV(u,shouldPlot)
    if nargin <=1
       shouldPlot=false; 
    end
    
    v = zeros(length(u),1);
    for i=1:length(u)
       if i==1
           v(i)=u(i+1)-u(i); 
       elseif i==length(u)
            v(i)=u(i-1)-u(i); 
       else
           v(i)=(u(i+1)-u(i-1))/2; 
       end
    end
    
    if shouldPlot
        subplot(1,2,1)
        plot(u);
        xlabel("xpos")
        ylabel("u(xpos)")
        subplot(1,2,2)
        plot(u,v)
        xlabel("u")
        ylabel("v")
    end
end

function speed = getSpeed(t,vec,shouldPlot)
    if nargin <= 2
        shouldPlot=false;
    end
    c = polyfit(t,vec,1);
    speed = c(1);
    if (shouldPlot)
        clf
        hold on
        plot(t,vec);
        plot(t,c(2)+c(1)*t); 
    end
end

function vec3 = getSpeedVector(vec,val,shouldPlot)
    if nargin <=2
        shouldPlot=false;
    end
    iMax=length(vec(1,:));
    vec2 = abs(vec-val);
    vec3 = zeros(iMax,1);
    for i=1:iMax
       [~,minIndex] = min(vec2(:,i));
       vec3(i)=minIndex;
    end
    
    if shouldPlot
       plot(vec3) 
    end
end

function [vec,t] = runDynamics(u_start,dt,tmax,updateTime)
    if nargin <=3
        updateTime=1000;
    end

    p=0.5;
    q=8;
    t=0:dt:tmax;
    L=100;
    vec = zeros(L,length(t));
    vec(:,1) = u_start(1:L);
    
    hold off
    for iT=2:length(t)
        for iX=1:L
           factor1 = p*vec(iX,iT-1) * (1 - vec(iX,iT-1)/q);
           factor2 = vec(iX,iT-1) / (vec(iX,iT-1) + 1);
           if (iX==1)
              factorDxx = vec(iX+1,iT-1)-vec(iX,iT-1);
           elseif (iX==L)
              factorDxx = vec(iX-1,iT-1)-vec(iX,iT-1);
           else
              factorDxx = vec(iX-1,iT-1)+vec(iX+1,iT-1)-2*vec(iX,iT-1);
           end
           factorSum = factor1-factor2+factorDxx; 
           vec(iX,iT) = vec(iX,iT-1) + dt*factorSum;
        end
        if (mod(iT,updateTime)==0)
            pause(0.01)
            plot(vec(:,iT))
            ylim([0,6])
        end
    end
end