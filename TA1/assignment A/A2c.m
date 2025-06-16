%clf

load('imp2a.mat');
M = 90;
m = 17;
eps = 0.25;
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
    plot(log10(f(i)),20*log10(abs(eta(1))),'k.') %displacement of machine
    plot(log10(f(i)),20*log10(abs(eta(2))),'r.') %displacement of coupling point
    hold on
end
grid on

title('displacement level as a function of frequency')
ylabel('level of displacement')
xlabel('logarithmic axis for frequency')

%for loop, increment f from 10Hz to 3000Hz by one Hz steps (f+i)
%for each increment i, take element Z_help(i) for A
%calculate A numerically
%invert A
%solve for n_m and n_c (machine and coupling point displacements)