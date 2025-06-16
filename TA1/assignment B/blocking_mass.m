clear
R = @(t,m) -10*log10(1 - (abs(( -m + t^2 * m^3 + t^2 * m^4 / 2)./((m + t^2 * m^3) - 1i * (4 + m - t^2 * m^3 - t^2 * m^4 / 2)))).^2);
t_val = 8.6569;
m_val = 0.0121;

R_res = R(t_val,m_val)
