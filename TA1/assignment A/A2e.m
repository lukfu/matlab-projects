clf

load('imp2a.mat');
M = 90;
m = 17;
eps = 0.25-0.1;
s = 4.79e6;
r = 2e3;

A = @(x,Z_var) [-x.^2.*(M+m) 1i*x.*Z_var ; s+1i.*x*r -s-1i*x*r-1i*x.*Z_var];
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
grid on

title('displacement level as a function of frequency')
ylabel('level of displacement')
xlabel('logarithmic axis for frequency')