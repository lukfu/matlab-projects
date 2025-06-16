clf

load('imp2a.mat');
M = 90;
m = 17;
eps = 0.25;
s = 4.79e6;
r = 2e3;
Z = Z_help(2000-9);
w = 2 * pi * 2000 / 60; %for 2kHz
%m_c will be new variable, concentrated mass

A_mass = @(m_c) [-w.^2.*(M+m) 1i*w.*Z ; s+1i.*w*r -s-1i*w*r-1i*w.*Z-w.^2*m_c];
A_massless = [-w.^2.*(M+m) 1i*w.*Z ; s+1i.*w*r -s-1i*w*r-1i*w.*Z];
B_num = [m * eps * w.^2 ; 0];

for m_c_var = 0:0.1:500 %m_c in kg
    A_num = A_mass(m_c_var);
    eta = linsolve(A_num,B_num);
    eta_massless = linsolve(A_massless,B_num);
    plot(m_c_var,20*log10(abs(eta(2))),'r.')
    plot(m_c_var,20*log10(abs(eta_massless(2))),'k.')
    hold on
end
grid on

title('displacement dB-diff. as a function of concentrated mass')
xlabel('concentrated mass in kg')
ylabel('level of displacement')

%eta is displacement, top of the beam is eta+h/2
%5dB reduction at 400kg

%%
%clf

load('imp2a.mat');
M = 90;
m = 17;
eps = 0.25;
s = 4.79e6;
r = 2e3;
m_c = 400;

A = @(x,Z_var) [-x.^2.*(M+m) 1i*x.*Z_var ; s+1i.*x*r -s-1i*x*r-1i*x.*Z_var-x.^2*m_c];
B = @(x) [m * eps * x.^2 ; 0];

for i = 1:1:2991
    w = 2 * pi * f(i);
    Z = Z_help(i);
    A_temp = A(w,Z);
    B_temp = B(w);
    %A_inv = inv(A_temp);
    eta = linsolve(A_temp,B_temp);
    plot(log10(f(i)),20*log10(abs(eta(1))),'b.') %displacement of machine
    plot(log10(f(i)),20*log10(abs(eta(2))),'m.') %displacement of coupling point
    hold on
end
xline(log10(2*pi*2000/60),'--r');
grid on
