clear
close all
full_white_value=64; % �ldre matlabversion
%full_white_value=255; % nyare matlabversion

N=1024; % NxN �r matrisstorleken (rekommenderad storlek N=1024)
sidlaengd_Plan1=4e-3; % det samplade omr�dets storlek i Plan 1 (rekommenderad storlek 4 mm)
a=sidlaengd_Plan1/N; % samplingsavst�nd i Plan 1
%L=100e-3; % propagationsstr�cka (1->2)

lambda_noll=633e-9; % vakuumv�gl�ngd f�r r�tt ljus fr�n en HeNe-laser
n_medium=1; % brytningsindex f�r medium mellan Plan 1 och 2
k=(2 * pi * n_medium) / lambda_noll; % k-vektorns l�ngd

xvekt=-N/2*a:a:(N/2-1)*a; % vektor med sampelpositioner i x-led
yvekt=xvekt;              % och y-led
[xmat,ymat]=meshgrid(xvekt,yvekt); % koordinatmatriser med x- och y-v�rdet i varje sampelposition
rmat=sqrt(xmat.^2+ymat.^2); % avst�ndet till origo i varje sampelpunkt.



                            %******* F�lt i Plan 1 *******
f_lins=100e-3;                  % fokall�ngd p� linsen f�re Plan 1
L=f_lins;
T_lins=exp(-1i*k*rmat.^2/(2*f_lins));                    % Transmissionsfunktion f�r en lins

D_apertur=2e-3;
T_apertur=rmat<(D_apertur/2);                % Transmissionsfunktion f�r en cirkul�r apertur

omega_in=1e-3;              % 1/e2-radie (f�r intensiteten, dvs 1/e-radie f�r amplituden) f�r infallande Gaussiskt f�lt
E_in_gauss=exp(-rmat.^2/omega_in^2);                

E_in_konstant=ones(N,N);          

E_in_hermitegauss = E_in_gauss .* xmat;

%----eye----
f_lins2=100e-3;
T_lins2=exp(-1i * k * rmat.^2 / (2 * f_lins2));
T_DOE=cell2mat(struct2cell(load('T_DOE_gen2')));
E1_eye=E_in_konstant .*T_lins2 .* T_DOE .* T_lins;


E1_gauss=E_in_gauss.*T_lins; 
E1_hermitegauss=E_in_hermitegauss.*T_lins;
E1_cirkular=E_in_konstant.* T_apertur .* T_lins;  

%v�lj fall
E1=E1_cirkular; 

I1=abs(E1).^2;

figure(1)
image(xvekt*1e3,yvekt*1e3,I1/max(max(I1))*full_white_value)
title(['Intensitet i Plan 1'])
xlabel('x[mm]')
ylabel('y[mm]')
colormap(gray) 
drawnow
axis('equal')

figure(2)
imagesc(xvekt*1e3,yvekt*1e3,angle(E1))
title(['Fas i Plan 1'])
xlabel('x[mm]')
ylabel('y[mm]')
colormap(gray) 
colorbar
drawnow
axis('equal')

%pause


            %**** Plan 2 ****

E2=PAS(E1,L,N,a,lambda_noll,n_medium); % Propagation med PAS-funktionen

I2=abs(E2).^2; 

mattnadsfaktor_plot=50; % anger hur m�nga g�nger maxv�rdet ska vara m�ttat i plotten (>1, kan vara bra om man vill se svagare detaljer)
figure(3)
image(xvekt*1e3,yvekt*1e3,I2/max(max(I2))*full_white_value*mattnadsfaktor_plot)
title(['Intensitet efter ' num2str(L*1e3) ' mm propagation (mattnadsfaktor=' num2str(mattnadsfaktor_plot) ')'])
xlabel('x[mm]')
ylabel('y[mm]')
colormap(gray) 
drawnow
axis('equal')

figure(4)
plot(xvekt*1e3,I2(N/2+1,:))
title(['Intensitet l�ngs x-axeln efter ' num2str(L*1e3) ' mm propagation'])
xlabel('x[mm]')
drawnow

 %% Gauss
   I2_max=max(max(I2));
   [~,pos]=min(abs(I2(N/2+1,:)-0.135*I2_max));
   omega2 =abs(xvekt(pos));
   Dspot=2* omega2
   Dstart=2* omega_in
   C=Dspot*Dstart/lambda_noll/L


 %% Cirkul�r
Ix=I2(N/2+1,:);
[peaks,b]=findpeaks(-Ix(N/2+1:end)); %hittar alla negativ peaks (djup) p� h�gra halvplan b(1)= position av f�rsta m�rka ring i Ix
omega2=xvekt(N/2+b(1)); %radien av f�rsta m�rka ring

Dstart=2*omega_in;
Dspot=2*omega2;
C=Dspot*Dstart/lambda_noll/L