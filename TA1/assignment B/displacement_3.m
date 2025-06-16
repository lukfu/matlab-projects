clear
rho = 680;
E = 10e6;
L = 4;
h = 0.1;
k = 2 * pi * 50 / sqrt(E / rho);
B = E * (h/2)^3 / 12;
C = [-1i*k 1i*k -k k;B*k^2 B*k^2 -B*k^2 -B*k^2;-1i*k*exp(-1i*k*L) 1i*k*exp(1i*k*L) -k*exp(-k*L) k*exp(k*L);B*k^2*exp(-1i*k*L) B*k^2*exp(1i*k*L) -B*k^2*exp(-k*L) -B*k^2*exp(k*L)];
D = [0 ; 0 ; 0 ; 0];
eta = linsolve(C,D);
eta1 = (eta(1))
eta2 = (eta(2))
eta3 = (eta(3))
eta4 = (eta(4))