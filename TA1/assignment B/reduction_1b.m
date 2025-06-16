%% interlayer
clf
clear
R_int = @(e,v) 10*log10(1 + ((1 - e.^2 .* v.^3) / 2).^2);
E = 10e6;
E_e = 5.04e6; 
l_0 = 0.001;
h = 0.1;
rho = 680;

eps = E_e / E * h / (2 * l_0);
v = @(lambda) E ./ E_e .* l_0 ./ (lambda ./ (2 * pi));

f = linspace(20,10000,500);
lambda1 = sqrt(E/rho) ./ f;
v_val = v(lambda1);

R_val = R_int(eps,v_val);
plot(f,R_val)
grid on

title('reduction index of SR450 interlayer')
xlabel('frequency [Hz]')
ylabel('reduction index [dB]')
%% blocking mass
clf
clear
R_block = @(t,m) -10*log10(1 - (abs(( -m + t.^2 .* m.^3 + t.^2 .* m.^4 / 2)./((m + t.^2 .* m.^3) - 1i * (4 + m - t.^2 .* m.^3 - t.^2 .* m.^4 / 2)))).^2);
E = 10e6;
l_0 = 0.001;
h = 0.1;
b = 0.1;
rho = 680;
rho_block = 7850;
m_prim = 6.8;
m_mass = 0.0785;

theta_big = m_mass * (l_0^2 + h^2);
theta = m_prim / m_mass * sqrt(theta_big / m_mass);
my = @(lambda) m_mass ./ (m_prim .* lambda ./(2 * pi));

f = linspace(20,10000,500);
lambda1 = sqrt(E/rho) ./ f;
my_val = my(lambda1);

R_val = R_block(theta,my_val);
plot(f,R_val)
grid on

title('reduction index of steel blocking mass')
xlabel('frequency [Hz]')
ylabel('reduction index [dB]')