clf
clear

p = 3169.79;
rho = 1.2;
S_D = 0.146;
r = 4;
c = 343;

f = linspace(10,500,50);
u_D =@(x) p ./ sqrt(2) .* 1./abs(1i .* 2 .* pi .* f .* rho .* S_D ./ (4.*pi) .* exp(1i .* 2 .* pi .* f ./ c)./r);

u = u_D(f);


plot(log(f),log(u))
title('log-log plot of Freq to Velocity')
xlabel('log(Frequency)');
ylabel('log(Diaphragm Velocity)');

xline(log(50));
xline(log(100));
xline(log(200));
xline(log(400));

grid minor