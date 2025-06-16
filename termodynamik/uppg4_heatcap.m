clear
clf

k_B = 1.38 * 10^-23;
T_E = 276.5;
N_cu = 1000 / 63.55 * 6.022 * 10^23;
N_al = 1000 / 26.9815 * 6.022 * 10^23;

CV = @(x) 3 .* k_B .* (T_E ./ x).^2 .* (exp(T_E ./ x) ./ (exp(T_E ./ x) - 1).^2);

T = linspace(0,1000,1001);
CV_cu = N_cu * CV(T);
CV_al = N_al * CV(T);

hold on
plot(T,CV_cu)
plot(T,CV_al)

grid minor
legend('Koppar','Aluminium')
title('Värmekapacitet för koppar och aluminium, 1kg')
xlabel('Temperatur T')
ylabel('Värmekapacitet C_v')