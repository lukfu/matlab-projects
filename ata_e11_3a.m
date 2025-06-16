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


plot(f,u)
title('Plot of Freq to Velocity')
xlabel('log(Frequency)');
ylabel('log(Diaphragm Velocity)');

xline(50);
xline(100);
xline(200);
xline(400);

grid minor