clear
avvikelse = 1.25;
rot = pi/2;
alpha = 0;
alpha1 = pi/4;
alpha2 = -pi/4;
phi = pi/2*avvikelse;

E_opol=[1;1];
E_in=J_pol(alpha+rot)*E_opol;

E_ut1=J_pol(alpha)*J_ret(alpha2,phi)*J_ret(alpha1+rot,phi)*E_in; %alpha1 f�r R p� f�rsta kvartsv�g, alpha2 f�r R p� andra
E_ut2=J_pol(alpha)*J_ret(alpha2,phi)*J_ret(alpha2+rot,phi)*E_in; %alpha1 - R f�rsta, alpha1 - L f�r andra
E_ut3=J_pol(alpha)*J_ret(alpha1,phi)*J_ret(alpha1+rot,phi)*E_in; %2 fast omv�nt
E_ut4=J_pol(alpha)*J_ret(alpha1,phi)*J_ret(alpha2+rot,phi)*E_in; %1 fast omv�nt


I1 = norm(E_ut1)^2; % 85% av ursprunglig intensitet
I2 = norm(E_ut2)^2; %storleksordning e-32 �r typ 0
I3 = norm(E_ut3)^2; %-||-
I4 = norm(E_ut4)^2; % samma som f�r I1