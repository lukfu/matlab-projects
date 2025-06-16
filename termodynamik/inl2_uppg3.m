N = 6.022e23;
k_B = 1.38e-23;
T = 293;
P = 101.3;
V = N * k_B * T / P;
m = 28 / (6.022e23);
h_bar = 1.054e-34;


F = - N * k_B * T * (log(V/h_bar^3 * (2 * k_B * T * m / pi)^3/2) * (k_B * T / 0.00025) - log(N) - 1)

my = -k_B * T * log(k_B * T/(h_bar^3 * P) * (2 * k_B * T * m / pi)^3/2 * (k_B * T / 0.00025)) + k_B * T