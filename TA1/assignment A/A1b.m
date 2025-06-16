clear

M = 90;
m = 17;
eps = 0.25;
s = 4.79e6;
r = 2e3;
f = linspace(10,3000,9000);
w = @(x) 2 * pi .* x;
w_num = w(f);

eta = @(y) m .* eps .* y.^2 ./ (-y.^2 .* (M + m) + 1i .* y .* r + s);
eta_undamp = @(y) m .* eps .* y.^2 ./ (-y.^2 .* (M + m) + 1i .* y .* r * 1e-3 + s);
displacement = eta(w_num);
displacement_undamp = eta_undamp(w_num);

hold on

plot(log10(f),20*log10(abs(displacement)),'b')
%plot(log10(f),angle(displacement))
plot(log10(f),20*log10(abs(displacement_undamp)),'r')
%plot(log10(f),angle(displacement_undamp))
grid on

legend('dampened','undampened')%1b
ylabel('level of displacement')
xlabel('logarithmic axis for frequency')