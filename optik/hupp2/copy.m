rotation=0; %för 1c) rotation = pi/2                  (roterar glasögonen man kollar på)
av=1; % för 1b) av=1.25                              (fasförskjutning är 25% för mycket/lite)
alfa2=pi/4 ; % positivt 45grader för högra glaset
alfa1 =-pi/4+rotation; % -45 grader för vänstra glaset
phi=pi/2*av; % fasförskjutning för kvartvågsplattan
alfa=0;
alfa_obj=0;

E_opolariserat=[1;1];
E_in=j_pol(rotation)*E_opolariserat

%läs från höger till vänster för effekt
E_1=j_pol(0)*j_ret(alfa,phi)*j_ret(alfa_obj,phi)*E_in;
I=norm(E_1)^2;  %intensiteten som når ögat
%       övre kommentar == undre kod
Intensitet(E_in,-alfa1,alfa2,pi/2*av) 

%svar:
%till 1d) ser man 15% vilket innan var 0.00001%

%till 1e) priset man får betala är att ljusets intensitet som kommer genom har minskat
%med 15%
%% uppgift 2
E_In=[1;1];
alfa=pi/4;
phi=pi/2;

E_in=j_pol(0)*E_opolariserat;%=[1,0]
spegel=[-1,0;0,1];%perfect spegel  bör antingen vara [-1,0;0,1] eller [1,0;0,-1]
E_1= j_pol(0) * j_ret(-alfa,phi) * spegel * j_ret(alfa,phi) * E_in
I=norm(E_1)^2  %intensiteten som når ögat


%% funktioner

% får jones matris som projicerar alfa radianer vridet moturs
function matris_j_proj=j_proj(alfa)
%matris_j_proj(1,1)=cos(alfa); %varför tog han med detta?
matris_j_proj=[cos(alfa),-sin(alfa);sin(alfa),cos(alfa);];
end
    
%får Jones-matrisen för en roterad polarisator med transmissionsriktningen vinkeln ?alfa från x-axeln
function matris_j_pol=j_pol(alfa)
    matris_j_pol=j_proj(-1*alfa)*[1,0;0,0]*j_proj(alfa);
end

%får: jones-matrisen för roterad ”retarder” med fasförskjutningen ?phi radianer
function matris_j_ret=j_ret(alfa,phi)
    matris_j_ret=j_proj(-1*alfa)*[exp(1i*phi),0;0,1]*j_proj(alfa);
end

%beräknar elfältsintensitet, som passerar genom två 3dglasögon där 1
%noterar första 3d glasögon ljuset passerar
function intensitet=Intensitet(ein,alfa1,alfa2,phi)
    %läs från höger till vänster för effekt
    intensitet=norm(j_pol(0)*j_ret(alfa2,phi)*j_ret(alfa1,phi)*ein)^2;
end