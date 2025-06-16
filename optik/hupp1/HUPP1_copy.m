clear
close all
full_white_value=64; % äldre matlabversion - detta värde plottas som vitt (max) med image-kommandot
%full_white_value=255; % nyare matlabversion - prova denna om din plot verkar mörk!

N=1024; % NxN är matrisstorleken (rekommenderad storlek N=1024)
sidlaengd_Plan1=4e-3; % det samplade områdets storlek (i x- eller y-led) i Plan 1 (rekommenderad storlek 4 mm)
a=sidlaengd_Plan1/N; % samplingsavstånd i Plan 1 (och Plan 2 eftersom vi använder PAS)

lambda_noll=633e-9; % vakuumvåglängd för rött ljus från en HeNe-laser
n_medium=1; % brytningsindex för medium mellan Plan 1 och 2
k=(2*pi*n_medium)/(lambda_noll); % k-vektorns längd * Ej klar

xvekt=-N/2*a:a:(N/2-1)*a; % vektor med sampelpositioner i x-led
yvekt=xvekt; % och y-led
[xmat,ymat]=meshgrid(xvekt,yvekt); % koordinatmatriser med x- och y-värdet i varje sampelposition
rmat=sqrt(xmat.^2+ymat.^2); % avståndet till origo i varje sampelpunkt. Observera att alla operationer är elementvisa!

%******* Fält i Plan 1
omega_in=1e-3; % 1/e2-radie (för intensiteten, dvs 1/e-radie för amplituden) för infallande Gaussiskt fält
f_lins=1000e-3; % fokallängd på linsen före Plan 1   ofta 100e-3 eller 20e-3
L=f_lins; % propagationssträcka (dvs avstånd mellan Plan 1 och 2)
T_lins=exp(-1i*k*rmat.^2/(2*f_lins)); % Transmissionsfunktion för en lins (linsen är TOK)



%-------gauss-----------
E_in_gauss=exp(-rmat.^2/omega_in^2); % Infallande fält: Gaussiskt med plana vågfronter och normalinfall (dvs konstant fas, här=0)
E1_gauss=E_in_gauss.*T_lins; % Fältet i Plan 1 (precis efter linsen) för gaussisk stråle 

%-------cirkular-----------
D_apertur=2*omega_in;
E_in_konstant=ones(N,N); % Infalla nde fält: Plan våg med normalt infall
T_apertur=rmat<(D_apertur/2); % Transmissionsfunktion för en cirkulär apertur ("pupill") 
E1_cirkular=E_in_konstant.*T_apertur.*T_lins; % Fältet i Plan 1 (precis efter linsen) för konstant fält som passerat genom cirkulär apertur * Ej klar 

  
%fel?    fokallins2 100 m eller uppåt, mattnadsfaktor=50

f_lins2=100e-3; % propagationssträcka (dvs avstånd mellan Plan 1 och 2)
T_lins2=exp(-1i*k*rmat.^2/(2*f_lins2)); % Transmissionsfunktion för en lins (linsen är TOK)


%-----eye-----------
E_in_konstant=ones(N,N); % Infallande fält: Plan våg med normalt infall
T_DOE=cell2mat(struct2cell(load('T_DOE_gen2')));
%f__DVL=...;
%T_DVL=exp(-1i*k*rmat.^2/(2*f__DVL));
E1_eye=E_in_konstant.*T_DOE.*T_lins; %.*T_lins2 för farligt medelande f_lins2 är inte 100e-3 men omkring, mättnadsfaktor nedan ska ändras tillbaka till 50
%E1_eye=E_in_gauss.*T_lins.*T_DOE.*T_DVL;



% --------Välj fall!-------------
E1=E1_cirkular; 
%E1=E1_gauss; 
I1=abs(E1).^2; % intensiteten är prop mot kvadraten på fältets amplitud (normalt struntar man i proportionalitetskonstanten)
% 
% figure(1)
% image(xvekt*1e3,yvekt*1e3,I1/max(max(I1))*full_white_value)
% title(['Intensitet i Plan 1. Verkar OK, eller?'])
% xlabel('x[mm]')
% ylabel('y[mm]')
% colormap(gray) 
% drawnow
% axis('equal')
% 
% figure(2)
% imagesc(xvekt*1e3,yvekt*1e3,angle(E1))
% title(['Fas i Plan 1. Verkar OK, eller?'])
% xlabel('x[mm]')
% ylabel('y[mm]')
% colormap(gray) 
% colorbar
% drawnow
% axis('equal')

%pause % tryck på valfri tangent för att fortsätta

%**** Och nu propagerar vi till Plan 2!
E2=PAS(E1,L,N,a,lambda_noll,n_medium); % Propagation med PAS-funktionen * Ej klar

I2=abs(E2).^2; 

hold on
mattnadsfaktor_plot=50;%ta ca 10000 för ofarligt medelande annars 50
figure(3)
image(xvekt*1e3,yvekt*1e3,I2/max(max(I2))*full_white_value*mattnadsfaktor_plot)
title(['Intensitet efter ' num2str(L*1e3) ' mm propagation (mattnadsfaktor=' num2str(mattnadsfaktor_plot) '). Verkar OK, eller?'])
xlabel('x[mm]')
ylabel('y[mm]')
colormap(gray) 
drawnow
axis('equal')

% hold off
% figure(4)
% hold on
% plot([-2,2],[0.135,0.135],'r--')
% plot(xvekt*1e3,I2(N/2+1,:)) % för att få enhet rätt
% title(['Intensitet längs x-axeln efter ' num2str(L*1e3) ' mm propagation. Verkar OK, eller?'])
% xlabel('x[mm]') 
% axis('equal')
% drawnow

%% Gausse
[~,pos]=min(abs(I2(N/2+1,:)-0.135* max(max(I2))));
omega2=abs(xvekt(pos));
%plot([-omega2*1e3,0],[0.135,0.135],'k-')
Dstart=2*omega_in;
Dspot=2*omega2;
C=Dspot*Dstart/lambda_noll/L
%Dspotmin=lambda_noll/Dstart*L

%% cir
Ix=I2(N/2+1,:);
[peaks,b]=findpeaks(-Ix(N/2+1:end)); %hittar alla negativ peaks (djup) på högra halvplan b(1)= position av första mörka ring i Ix
omega2=xvekt(N/2+b(1)); %radien av första mörka ring

Dstart=2*omega_in;
Dspot=2*omega2;
C=Dspot*Dstart/lambda_noll/L

%% ginput
[x,y]=ginput(2);
omeee=abs(x(1)-x(2))/1e3