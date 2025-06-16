rotation=0; %f�r 1c) rotation = pi/2                  (roterar glas�gonen man kollar p�)
av=1; % f�r 1b) av=1.25                              (fasf�rskjutning �r 25% f�r mycket/lite)
alfa2=pi/4 ; % positivt 45grader f�r h�gra glaset
alfa1 =-pi/4+rotation; % -45 grader f�r v�nstra glaset
phi=pi/2*av; % fasf�rskjutning f�r kvartv�gsplattan
alfa=0;
alfa_obj=0;

E_opolariserat=[1;1];
E_in=j_pol(rotation)*E_opolariserat

%l�s fr�n h�ger till v�nster f�r effekt
E_1=j_pol(0)*j_ret(alfa,phi)*j_ret(alfa_obj,phi)*E_in;
I=norm(E_1)^2;  %intensiteten som n�r �gat
%       �vre kommentar == undre kod
Intensitet(E_in,-alfa1,alfa2,pi/2*av) 

%svar:
%till 1d) ser man 15% vilket innan var 0.00001%

%till 1e) priset man f�r betala �r att ljusets intensitet som kommer genom har minskat
%med 15%
%% uppgift 2
E_In=[1;1];
alfa=pi/4;
phi=pi/2;

E_in=j_pol(0)*E_opolariserat;%=[1,0]
spegel=[-1,0;0,1];%perfect spegel  b�r antingen vara [-1,0;0,1] eller [1,0;0,-1]
E_1= j_pol(0) * j_ret(-alfa,phi) * spegel * j_ret(alfa,phi) * E_in
I=norm(E_1)^2  %intensiteten som n�r �gat


%% funktioner

% f�r jones matris som projicerar alfa radianer vridet moturs
function matris_j_proj=j_proj(alfa)
%matris_j_proj(1,1)=cos(alfa); %varf�r tog han med detta?
matris_j_proj=[cos(alfa),-sin(alfa);sin(alfa),cos(alfa);];
end
    
%f�r Jones-matrisen f�r en roterad polarisator med transmissionsriktningen vinkeln ?alfa fr�n x-axeln
function matris_j_pol=j_pol(alfa)
    matris_j_pol=j_proj(-1*alfa)*[1,0;0,0]*j_proj(alfa);
end

%f�r: jones-matrisen f�r roterad �retarder� med fasf�rskjutningen ?phi radianer
function matris_j_ret=j_ret(alfa,phi)
    matris_j_ret=j_proj(-1*alfa)*[exp(1i*phi),0;0,1]*j_proj(alfa);
end

%ber�knar elf�ltsintensitet, som passerar genom tv� 3dglas�gon d�r 1
%noterar f�rsta 3d glas�gon ljuset passerar
function intensitet=Intensitet(ein,alfa1,alfa2,phi)
    %l�s fr�n h�ger till v�nster f�r effekt
    intensitet=norm(j_pol(0)*j_ret(alfa2,phi)*j_ret(alfa1,phi)*ein)^2;
end