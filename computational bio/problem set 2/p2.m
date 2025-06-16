%% a
clc;clear;
syms a b u v

condition1 = a - (b + 1) * u + u^2 * v;
condition2 = b * u - u^2 * v;
conditions = [condition1 condition2];

sol = solve(conditions,u,v);
u=sol.u
v=sol.v
J = [b + 1 + 2*u*v, u^2 ; b - 2*u, -u^2];
detJ = det(J);
trJ = trace(J);

%% b
a=3;b=8;Du=1;
u=a;
v=b/a;
J=[2*u*v-(b+1),u^2;b-2*u*v,-u^2];

dJ=det(J);
clf
hold on
k=linspace(0,5,10000);
%Dv= 2.692075    K^2c=1.828  
for Dv=1:0.5:3
    d=Dv/Du;
    j12=d*J(1,1)+J(2,2); % trace
    y = d*k.^2 - j12*k + dJ;
    plot(k,y);
end
xlabel('k')
ylabel('y')
legend('1','1.5','2','2.5','3')

%% b
a=3;b=8;Du=1;
u=a;
v=b/a;
J=[2*u*v-(b+1),u^2;b-2*u*v,-u^2];

dJ=det(J);
clf
hold on
k=linspace(0,5,10000); 
Dv= 2.692075;    % K^2c=1.828  

d=Dv/Du;
j12=d*J(1,1)+J(2,2); % trace
y = d*k.^2 - j12*k + dJ; %detK, k==k^2
plot(k,y);
[M,I] = min(y);
kMin = k(I)

xlabel('k')
ylabel('det(K)')

%% c

dt=1E-2;
tmax=2E2;
DvList=[2.3, 3, 5, 9];
Dv=DvList(3); % choose Dv to analyse
u0=a;
v0=b/a;
[vec_start,vec_end,t] = runDynamics2(dt,tmax,Dv,u0,v0);

%% after run till steady state
clf
v1_start = vec_start;
v1_end = vec_end;
v2_start = vec_start;
v2_end = vec_end;
v3_start = vec_start;
v3_end = vec_end;
v4_start = vec_start;
v4_end = vec_end;

subplot(2,1,1)
pcol_plot(v1_start)
subplot(2,1,2)
pcol_plot(v1_end)
% subplot(2,2,3)
% pcol_plot(v2_start)
% subplot(2,2,4)
% pcol_plot(v2_end)

%  ha=get(gcf,'children');
%  set(ha(2),'position',[.4 .1 .4 .4])
%  set(ha(4),'position',[.1 .1 .4 .4])
%  set(ha(6),'position',[.4 .55 .4 .4])
%  set(ha(8),'position',[.1 .55 .4 .4])

% subplot(2,2,1)
% pcol_plot(v3_start)
% subplot(2,2,2)
% pcol_plot(v3_end)
% subplot(2,2,3)
% pcol_plot(v4_start)
% subplot(2,2,4)
% pcol_plot(v4_end)
%  ha=get(gcf,'children');
%  set(ha(2),'position',[.4 .1 .4 .4])
%  set(ha(4),'position',[.1 .1 .4 .4])
%  set(ha(6),'position',[.4 .55 .4 .4])
%  set(ha(8),'position',[.1 .55 .4 .4])

%% functions
function pcol_plot(val)
    pcolor(val);
    shading interp;
    axis square
    colorbar;
   % caxis([1,12])
end

function [vec_u,vec_v,t] = runDynamics(dt,tmax,Dv,u0,v0)
    a=3;
    b=8;
    Du=1;
    t=0:dt:tmax;
    L=128;
    vec_u = u0*ones(L,L)+u0/10*rand(L,L);    
    vec2_u = vec_u;
    vec_v = v0*ones(L,L)+v0/10*rand(L,L);    
    vec2_v = vec_v;
    
    Mod2 = @(x) mod(x-1,L) + 1;
    clf
    hold off
    for iT=2:length(t)
        for iX=1:L
           for iY=1:L
               u = vec_u(iX,iY);
               v = vec_v(iX,iY);

               u_factor1 = a - (b+1)*u + u^2*v;
               v_factor1 = b*u - u^2*v;
          
               u_factorD = vec_u(Mod2(iX+1),iY) + vec_u(Mod2(iX-1),iY) + vec_u(iX,Mod2(iY+1)) + vec_u(iX,Mod2(iY-1)) - 4*u;
               v_factorD = vec_v(Mod2(iX+1),iY) + vec_v(Mod2(iX-1),iY) + vec_v(iX,Mod2(iY+1)) + vec_v(iX,Mod2(iY-1)) - 4*v;
               
               u_factorSum = u_factor1 + Du*u_factorD; 
               v_factorSum = v_factor1 + Dv*v_factorD; 

               vec2_u(iX,iY) = vec_u(iX,iY) + dt*u_factorSum;
               vec2_v(iX,iY) = vec_v(iX,iY) + dt*v_factorSum;
           end
        end
        if (mod(iT,1000)==0)
            iT
            pause(0.01)
            pcolor(vec_u);
            shading interp;
            axis square
            colorbar;
        end
        vec_u=vec2_u;
        vec_v=vec2_v;
    end
    
end

function [vec_start,vec_u,t] = runDynamics2(dt,tmax,Dv,u0,v0)
    a=3;
    b=8;
    Du=1;
    t=0:dt:tmax;
    L=128;
    vec_u = u0*ones(L,L)+u0/10*rand(L,L);    
    vec2_u = vec_u;
    vec_v = v0*ones(L,L)+v0/10*rand(L,L);    
    vec2_v = vec_v;
    
    Mod2 = @(x) mod(x-1,L) + 1;
    clf
    hold off
    for iT=2:length(t)
        for iX=1:L
           for iY=1:L
               u = vec_u(iX,iY);
               v = vec_v(iX,iY);

               u_factor1 = a - (b+1)*u + u^2*v;
               v_factor1 = b*u - u^2*v;
          
               u_factorD = vec_u(Mod2(iX+1),iY) + vec_u(Mod2(iX-1),iY) + vec_u(iX,Mod2(iY+1)) + vec_u(iX,Mod2(iY-1)) - 4*u;
               v_factorD = vec_v(Mod2(iX+1),iY) + vec_v(Mod2(iX-1),iY) + vec_v(iX,Mod2(iY+1)) + vec_v(iX,Mod2(iY-1)) - 4*v;
               
               u_factorSum = u_factor1 + Du*u_factorD; 
               v_factorSum = v_factor1 + Dv*v_factorD; 

               vec2_u(iX,iY) = vec_u(iX,iY) + dt*u_factorSum;
               vec2_v(iX,iY) = vec_v(iX,iY) + dt*v_factorSum;
           end
        end
        if iT==10
           vec_start=vec2_u;
        end
        
        if (mod(iT,200)==0)
            iT
            pause(0.01)
            pcolor(vec_u);
            shading interp;
            axis square
            colorbar;
        end
        vec_u=vec2_u;
        vec_v=vec2_v;
    end
    
end