%
% Uppgift 1: Ers�tt uttrycket to_be_inserted_by_user_uppg_1 (p� 2 st�llen) med r�tt uttryck! 
%

%
% Uppgift 5: Ers�tt uttrycket to_be_inserted_by_user_uppg_5 (p� 1 st�lle) med r�tt uttryck! 
%


close all
clear

D_lins=.5; % Linsdiameter
L=3; % Avst�nd mellan Plan 1 och Plan 2
f_lins=L; % Fokall�ngden p� linsen
lambda=600e-9; % V�gl�ngd (Mars �r r�daktig s� vi antar detta v�rde som en typisk v�gl�ngd)
k=2*pi/lambda;

%**** parameter f�r uppgift 2
c_4=0; % f�r korrektion av linsens fasmodulering, se uppgift 2 (i uppgift 1 ska c_4=0) 
%**** slut parameter f�r uppgift 2

%**** parametrar f�r uppgift 5
sampla_om_till_2D=0; % S�tts =1 n�r du vill sampla om ber�knade PSFen till en tv�dimensionell funktion (i uppgifterna 1-4 ska den vara noll)
if sampla_om_till_2D==1
    N_2D=5000; % matrisstorleken hos omsamplade PSFen: ska vara samma som matrisstorleken hos den perfekta bilden som du ska falta med
    samplavst_2D=to_be_inserted_by_user_uppg_5; % samplingsavst�ndet hos omsamplade PSFen: ska vara lika med samplingsavst�ndet hos den perfekta bilden i detektorplanet
end
%**** slut parametrar f�r uppgift 5

% Plan 1 (efter lins)
N=1024; % matrisstorlek
a=D_lins/N; % samplingsavst�nd
xvekt=-N/2*a:a:(N/2-1)*a; 
yvekt=xvekt;
[xmat,ymat]=meshgrid(xvekt,yvekt); 
rmat=sqrt(xmat.^2+ymat.^2); % radialavst�nd i Plan 1

% Linsens fasmodulering
fi_lins=-k*rmat.^2/(2*f_lins)+c_4*rmat.^4; % linsens fasmoduleringsfunktion (andra termen �r en icke-paraxiell korrektion, se uppg 2)
T_lins=exp(1i*fi_lins).*(rmat<=D_lins/2); % linsens transmissionsfunktion

% V�lj punkter l�ngs u-axeln i Plan 2 d�r PSFen ska evalueras
steg_i_u_led=0.25e-6;
u_max=30e-6;
u_eval_vekt=0:steg_i_u_led:u_max; % ineh�ller u-positioner f�r punkterna d�r PSFen ska ber�knas

% Utf�r f�ltber�kningen i varje punkt i u_eval_vekt
disp('Ber�knar f�ltet i alla u-positioner')
pause(0.1)
for berpunkt_nummer=1:length(u_eval_vekt) % g� igenom ber�kningspunkterna l�ngs u-axeln
    if rem(berpunkt_nummer,10)==0
        disp(['Ber�kningspunkt nummer ' num2str(berpunkt_nummer) ' av ' num2str(length(u_eval_vekt)) ' l�ngs u-axeln'])
    end
    u=u_eval_vekt(berpunkt_nummer); % u-koordinat f�r aktuell ber�kningspunkt
    r=to_be_inserted_by_user_uppg_1; % matris med avst�nd fr�n alla sampelpunkter i Plan 1 till aktuell ber�kningspunkt
    E_PSF_i_aktuellt_u=to_be_inserted_by_user_uppg_1; % f�ltet i ber�kningspunkten, ber�knat med HFM-integralen
    E_PSF_radiell_ickeparaxiell(berpunkt_nummer)=E_PSF_i_aktuellt_u; % spara resultatet i en vektor  
end

E_PSF_radiell_paraxiell_teori_paraxiell_linsfasmod=besselj(1,k*D_lins/(2*L)*(u_eval_vekt+steg_i_u_led*1e-5))./(u_eval_vekt+steg_i_u_led*1e-5); % Detta �r Airy-funktionen, som kan beskrivas analytiskt med besselfunktioner.
                                                                                                                                               % Detta �r resultatet man f�r om man har lins med paraxiella v�rdet p� fasmoduleringen, 
                                                                                                                                               % och dessutom antar att paraxiella approximationen �r giltig (som t.ex i HUPP1).
                                                                                                                                               
figure(201)
plot(u_eval_vekt*1e6,abs(E_PSF_radiell_ickeparaxiell)/abs(E_PSF_radiell_ickeparaxiell(1)))
hold on
plot(u_eval_vekt*1e6,abs(E_PSF_radiell_paraxiell_teori_paraxiell_linsfasmod)/abs(E_PSF_radiell_paraxiell_teori_paraxiell_linsfasmod(1)),'r')
legend('Korrekt (icke-approximativt) resultat med angiven faskorrektion (v�rdet p� c_4) hos lins','Enligt paraxiella approximationen, med paraxiella uttrycket f�r fasmodulering hos lins')
xlabel('u (v=0) [�m]')
title(['|E_{PSF}|   (c_4= ' num2str(c_4) ')' ]);

PSF_radiell_ickeparaxiell=abs(E_PSF_radiell_ickeparaxiell).^2; % PSFen �r intensitetsf�rdelningen

% G�r om den ber�knade radiella PSFen till en 2D-funktion
% samplad i en N_2D x N_2D-matris med samplingsavst�ndet samplavst_2D
if sampla_om_till_2D==1
    [PSF_2D, uvekt, vvekt, umat, vmat]=Sampla_om_radiell_till_2D(PSF_radiell_ickeparaxiell, u_eval_vekt, N_2D, samplavst_2D);
    figure(221)
    imagesc(uvekt*1e6,vvekt*1e6,PSF_2D)
    title('Den omsamplade funktionen (PSFen i detektorplanet p� HiRISE)')
    xlabel('u [�m]')
    ylabel('v [�m]')
    colormap(jet)
    colorbar
end
