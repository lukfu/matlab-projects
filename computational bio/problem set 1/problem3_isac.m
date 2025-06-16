
%% part a
clf
T=1000000;
K=2000;
Rs = ones(K,1);
figure
hold on

for R = 14.7:0.01:14.82
    vec = runDynamics(T,R);
    plot(Rs*R,vec(T+1-K:end),'b.')
end
xlabel('R')
ylabel('\mu_\tau')
title('period doubling cascade')
%saddle node bifurcation

%% part b

Rlist=[5,10,23,13];
for i =1:4
    figure
    vec = runDynamics(50,Rlist(i));
    plot(vec)
    xlabel('eta')
    ylabel('\mu_\eta')
    title('period doubling cascade R='+string(Rlist(i)))
end
%descibe dynamics maybe not a good way, simply say what happens
vec1=vec(2+delay:end);
vec2=vec(1+delay:end-1);
%clf
%plot(vec1,vec2)
%% part c
clf
T=500;
Rs = ones(100,1);
xt=[];yt=[];
for R = 12:0.01:12.5  % test different intervals of R to find bifurcation
    vec = runDynamics(T,R);
    xt=[xt;Rs*R];yt=[yt;vec(201:300)];
end

plot(xt,yt,'b.')
%7.33=1->2  12.25=2->4    14.15=4->8  14.6=8->16   14.738=16->32
x=[7.33,12.25,14.15,14.6,14.738];
x2=x(2:5)-x(1:4);
x=fliplr(x);
y=[1,2,3,4];

T=6000;
for R=12.35:0.001:12.44
    clf
    hold on
    vec = runDynamics(T,R);
    vec2=vec(end-50:end);
    plot(vec2,'b')
    %xlim([900,1000])
    %ylim([432,433])
    [val,loc]=findpeaks(vec2);
    %plot(901+loc,vec2(loc),'rx')
    if abs(max(val)-min(val))>=0.000001
        R
        break;
    end
    title(R)
    pause(0.01)
end
%7.33  --> stable oscillation  12.3973 (no longer)
%% part d  plot and get period

T=1000000;
Rs = ones(100,1);
Rmin=0;
Rmax=15;
dt=0.01;
period = zeros(length(Rmin:dt:Rmax),1);
R=Rmin:dt:Rmax;
clf
hold on
Rf=0;%14.82
for iR = 1:length(R)
    vec = runDynamics(T,R(iR));
    %loglog(Rs*R(iR)-Rf,vec(T+1-100:T),'b.')
    period(iR)=getPeriod(vec(T+1-150:T),0.001);
end
%set(gca, 'XScale', 'log');
%xlim([-16,0])
%ylim([300,500])
%clf
%plot(R,period);
%% 
clf

ind = (period==1)+(period==2)+(period==4)+(period==8)+(period==16)+(period==32)+(period==64);
ind=ones(length(ind),1);
%ind = boolean(ind);
%plot(R(ind),period(ind),'b.')
plot(R,period,'b.')
xlabel('R')
ylabel('Period')
title('Find out R when period is infinite')

%set(gca, 'XScale', 'log');
%xlim([-16,0])
%saddle node bifurcation
%719
%1233
%1412
%1463
%1474
function period = getPeriod(vec,dt)
    ex = [vec(1)];
    for iT =2:length(vec)
        bool = abs(ex-vec(iT))<=dt;
        if max(bool)
        else
            ex=[ex;vec(iT)];
        end
    end
    period=length(ex);
end
function [a,N0] = getVariables()
    a = 0.01;
    N0 = 900;
end
function val = getNext(R,N)
    [a,~] = getVariables;
    val = R*N*exp(-a*N);
end
function vec = runDynamics(t,R)
    [~,N0] = getVariables;    
    vec=zeros(t,1);
    vec(1) = getNext(R,N0);
    for i=2:t
       vec(i) = getNext(R,vec(i-1));  
    end
end
