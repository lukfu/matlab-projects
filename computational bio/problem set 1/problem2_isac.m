%% a
syms N r K b
assume(N>=0 & r>=0 & K>=0 & b>=1)
F = (r+1)*N / (1+(N/K)^b);
solN = solve( F == N,N)

%% b
eqn(N) = simplify(diff(F,N));
eqn(solN(1));
 simplify(eqn(solN(2)))
% solve(r-b*r+1==0,b)%b>1+1/r---> lambda negative

%% c 
%from b if b=2*(r+1)/r a bifurcation happens from stable to unstable
%% d print behaviour
clf
N0=[1,2,3,10];
t=100;
hold on
colorLine=["r+","gx","b.","p"];
for i=1:4
    nVec = getDynamics(N0(i),t);
    loglog(nVec,colorLine(i))
end
% d print approximation
syms N
K=10^3; b=1; r=0.1;

F = (r+1)*N / (1+(N/K)^b);
eqn(N) = simplify(diff(F,N));
lambda = eqn(0);%0 was unstable F.P

t=50;
approxDynamic=zeros(t,1);
for iN =1:length(N0)
    N=N0(iN);
    for iT =1:t
        approxDynamic(iT)=N;
        N=lambda*N;
    end
    loglog(approxDynamic,'k','LineWidth',1)
end

set(gca, 'XScale', 'log', 'YScale', 'log');
ylim([0,100])
xlabel('t')
ylabel('N(t)')
title('pertubation around N*=0')
ap='aproximate';
legend('N0=1','N0=2','N0=3','N0=10',ap,ap,ap,ap)
%% e
% The higher the initial value the shorter time taken for the approximation
% to become wrong. This seems reasonable since the curve seems to become
% more linear at the t=0 for higher N0, and more exponential for low N0

%% f print lines
K=10^3; b=1; r=0.1;
Nstable = K*r^(1/b);
N0=Nstable+[-10,-3,-2,-1, 1, 2, 3, 10];
clf
t=60;
hold on
for i=1:length(N0)
    nVec = getDynamics(N0(i),t);
    plot(nVec,'r.')
end
% f print approx

syms N
F = (r+1)*N / (1+(N/K)^b);
eqn(N) = simplify(diff(F,N));
lambda = eqn(Nstable);%0 was unstable F.P
t=50;
approxDynamic=zeros(t,1);
for iN =1:length(N0)
    N=N0(iN);
    for iT =1:t
        approxDynamic(iT)=N;
        N=Nstable+lambda*(N-Nstable);
    end
    plot(approxDynamic,'k.','LineWidth',1)
end


xlabel('Time t=0,1,2,...')
ylabel('N')
title('Pertubation around N*=100')
set(gca, 'XScale', 'log', 'YScale', 'log');
ylim([90,110])

% worked bad, half reasonable since all approx are decreasing, but the
% actual lines some are decreasing and some increasing



function nVec = getDynamics(N0,t)
    K=10^3; 
    b=1;
    r=0.1;
    F=@(N) (r+1)*N/(1+(N/K)^b); 
    nVec=zeros(t,1);
    N=N0;
    for iT=1:t
        nVec(iT)=N;
        N=F(N);
    end
end
