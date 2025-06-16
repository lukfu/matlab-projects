clear

alpha=pi/4;
phi=pi/2;

E_opol=[1;1];
E_in=J_pol(0)*E_opol; %=[1,0]
spegling=[-1,0;0,1]; %perfect spegel  bör antingen vara [-1,0;0,1] eller [1,0;0,-1]
                     %beroende på hur man ser koord.system efter reflektion
                     %spegling längs x-axeln ger [1,0;0,-1], - y-axeln ger
                     %[-1,0;0,1]
E_1= J_pol(0) * J_ret(-alpha,-phi) * spegling * J_ret(alpha,phi) * E_in
I=norm(E_1)^2  