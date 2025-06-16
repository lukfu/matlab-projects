clear
clc
clf

k_B = 1.38 * 10^-23;
T1 = 223;
T2 = 293;
T3 = 373;
m = 2.67 * 10^-23;
h = 6.626 * 10^-34;
P = linspace(0,500,501);

S1 = @(x) k_B .* (log(k_B .* T1 ./ x .* (2 .* pi .* m ./ h.^2 .* k_B .* T1).^(3/2)) + 5/2);
S2 = @(x) k_B .* (log(k_B .* T2 ./ x .* (2 .* pi .* m ./ h.^2 .* k_B .* T2).^(3/2)) + 5/2);
S3 = @(x) k_B .* (log(k_B .* T3 ./ x .* (2 .* pi .* m ./ h.^2 .* k_B .* T3).^(3/2)) + 5/2);

entropy1 = S1(P);
entropy2 = S2(P);
entropy3 = S3(P);

hold on
grid minor
plot(P,entropy1)
plot(P,entropy2)
plot(P,entropy3)

title('Entropiförändring som funktion av tryck')
xlabel('Tryck P [Pa]')
ylabel('Entropiförändring S per partikel')
legend('T=-50C','T=20C','T=100C')
