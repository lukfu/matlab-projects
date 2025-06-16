function kapacitet = C_V(T,T_E,N)
k_b = 1.381*1e-23;
limit = 3*N*k_b;
exponent = exp(T_E./T)./(exp(T_E./T) - 1).^2;
potens = (T_E./T).^2;
kapacitet = limit.*potens.*exponent;
end