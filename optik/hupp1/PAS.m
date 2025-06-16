function E2=PAS(E1,L,N,a,lambda_noll,n_medium)

% Varje sampelpunkt i k-planet motsvarar en plan v�g med en viss riktning (kx,ky,kz)

delta_k=2 * pi /(N * a);            %  samplingsavst�nd i k-planet
kxvekt=-N/2*delta_k:delta_k:(N/2-1)*delta_k; % vektor med sampelpositioner i kx-led
kyvekt=kxvekt; % och ky-led
[kxmat,kymat]=meshgrid(kxvekt,kyvekt); % k-vektorns x- resp y-komponent i varje sampelpunkt i k-planet

k= n_medium * 2 * pi / lambda_noll;           % k-vektorns l�ngd (skal�r) f�r en plan v�g i ett material med brytningsindex n_medium
kzmat=sqrt(k^2 - kxmat.^2 - kymat.^2); % k-vektorns z-komponent i varje sampelpunkt i k-planet *** Ej klar (Obs! Matlab till�ter att en skal�r direkt adderas/subtraheras med matris, man beh�ver allts� tex inte skriva "skal�r*ones(N,N)-matris")

fasfaktor_propagation=exp(1i* kzmat * L);% faktorn varje sampelpunkt i k-planet multas med f�r att propagera str�ckan L i z-led

A= a^2/(2 * pi)^2 *fft2c(E1); % Planv�gsspektrum i Plan 1

B=A.*fasfaktor_propagation; % Planv�gsspektrum i Plan 2

E2= delta_k^2 * N^2 *ifft2c(B); 
