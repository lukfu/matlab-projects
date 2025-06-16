%% par 1
clf
clear
s=tf('s');
Kp=0.1; Ki=0;
Km=0.155; b=0.0025;J=0.00115;Ku=0.3078;Ra=2.4;
%F=(Kp*s+Ki)/s
%Guw=K_m/((b+J*s)*Ra + Ku*Km)
G=(Kp*s+Ki)/s * (1/s) /(1+(Kp*s+Ki)/s * Km/((b+J*s)*Ra + Ku*Km));
step(G)
axis equal
grid on

%% par 2
clf
clear
s=tf('s');
Kp=5; Ki=0;
Km=0.155; b=0.0025;J=0.00115;Ku=0.3078;Ra=2.4;
%F=(Kp*s+Ki)/s
%Guw=K_m/((b+J*s)*Ra + Ku*Km)
G=(Kp*s+Ki)/s * (1/s) /(1+(Kp*s+Ki)/s * Km/((b+J*s)*Ra + Ku*Km));
step(G)
axis equal
grid on

%% par 3
clf
clear
s=tf('s');
Kp=0; Ki=4;
Km=0.155; b=0.0025;J=0.00115;Ku=0.3078;Ra=2.4;
%F=(Kp*s+Ki)/s
%Guw=K_m/((b+J*s)*Ra + Ku*Km)
G=(Kp*s+Ki)/s * (1/s) /(1+(Kp*s+Ki)/s * Km/((b+J*s)*Ra + Ku*Km));
step(G)
axis equal
grid on

%% par 4
clf
clear
s=tf('s');
Kp=0.1; Ki=4;
Km=0.155; b=0.0025;J=0.00115;Ku=0.3078;Ra=2.4;
%F=(Kp*s+Ki)/s
%Guw=K_m/((b+J*s)*Ra + Ku*Km)
G=(Kp*s+Ki)/s * (1/s) /(1+(Kp*s+Ki)/s * Km/((b+J*s)*Ra + Ku*Km));
step(G)
axis equal
grid on


