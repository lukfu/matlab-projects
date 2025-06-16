clc
clear
clf

E = 0.2 * 1.602e-19;
V1 = 0.1 * 1.602e-19; V2 = 0.3 * 1.602e-19;
m = 9.109e-31;
L = 0.5e-9;
a1 = 0.3e-9; a2 = 0.75e-9;
x1 = a1; x2 = a1 + L; x3 = a1 + L + a2;
hbar = 6.626e-34 / (2 * pi);
k = sqrt(2 * m * E) / (hbar);
q1 = sqrt(2 * m * (E-V1)) /(hbar);
q2 = sqrt(2 * m * (V2-E)) /(hbar);

I = @(x) [exp(1i*k*x) , exp(-1i*k*x) ; 1i*k*exp(1i*k*x) , -1i*k*exp(-1i*k*x)];
II1 = @(x) [exp(1i*q1*x) , exp(-1i*q1*x) ; 1i*q1*exp(1i*q1*x) , -1i*q1*exp(-1i*q1*x)];
II2 = I;
II3 = @(x) [exp(-q2*x) , exp(q2*x) ; -q2*exp(-q2*x) , q2*exp(q2*x)];
III = I;

%I(0) * [A;B] = II1(0) * [A1;B1]
%II1(x1) * [A1;B1] = II2(x1) * [A2;B2]
%II2(x2) * [A2;B2] = II3(x2) * [A3;B3]
%II2(x3) * [A3;B3] = III(x3) * [F;0]

%[A3;B3] =II2(x3)^(-1) * III(x3) * [F;0]
%II2(x2) * [A2;B2] = II3(x2) * [A3;B3] = II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%II2(x2) * [A2;B2] = II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%[A2;B2] = II2(x2)^(-1) *  II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%II1(x1) * [A1;B1] = II2(x1) * [A2;B2] = II2(x1) * II2(x2)^(-1) *  II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%II1(x1) * [A1;B1] = II2(x1) * II2(x2)^(-1) *  II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%[A1;B1] = II1(x1)^(-1) * II2(x1) * II2(x2)^(-1) *  II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%I(0) * [A;B] = II1(0) * II1(x1)^(-1) * II2(x1) * II2(x2)^(-1) *  II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 
%[A;B] = I(0)^(-1) * II1(0) * II1(x1)^(-1) * II2(x1) * II2(x2)^(-1) *  II3(x2) * II2(x3)^(-1) * III(x3) * [F;0] 

i = I(0);
ii1_1 = II1(0);

ii1_2 = II1(x1);
ii2_1 = II2(x1);

ii2_2 = II2(x2);
ii3_1 = II3(x2);

ii3_2 = II3(x3);
iii = III(x3);

MAT = I(0)^(-1) * II1(0) * II1(x1)^(-1) * II2(x1) * II2(x2)^(-1) *  II3(x2) * II3(x3)^(-1) * III(x3);

A = 1;
F = A / MAT(1,1);

A3B3 = II3(x3)^(-1) * III(x3) * [F;0];
A2B2 = II2(x2)^(-1) * II3(x2) * A3B3;
A1B1 = II1(x1)^(-1) * II2(x1) * A2B2;
AB = I(0)^(-1) * II1(0) * A1B1

T = (abs(F)^2)/(abs(A)^2)

for x = -6:0.01:0;
phi1 = AB(1,1) * exp(1i * k * x * 1e-9) + AB(2,1) * exp(-1i * k * x * 1e-9);
plot(x,real(phi1),'k.');
hold on
end

for x = 0:0.01:0.3;
phi2 = A1B1(1,1) * exp(1i * q1 * x * 1e-9) + A1B1(2,1) * exp(-1i * q1 * x * 1e-9);
plot(x,real(phi2),'g.');
hold on
end

for x = 0.3:0.01:0.8;
phi3 = A2B2(1,1) * exp(1i * k * x * 1e-9) + A2B2(2,1) * exp(-1i * k * x * 1e-9);
plot(x,real(phi3),'b.');
hold on
end

for x = 0.8:0.01:1.55;
phi4 = A3B3(1,1) * exp(- q2 * x * 1e-9) + A3B3(2,1) * exp(q2 * x * 1e-9);
plot(x,real(phi4),'r.');
hold on
end

for x = 1.55:0.01:8;
phi5 = F * exp(1i * k * x * 1e-9);
plot(x,real(phi5),'k.');
hold on
end
grid minor

%% uppg b
clc
clear
clf

V1 = 0.1; V2 = 0.3;
m = 9.109e-31;
L = 0.5e-9; %vary L
a1 = 0.3e-9; a2 = 0.75e-9;
x1 = a1; x2 = a1 + L; x3 = a1 + L + a2;
hbar = 6.626e-34 / (2 * pi);


A=zeros(2000,2);
N=0;
for E = 0.0005:0.001:2
N=N+1;
A(N,1)=E;
    
k = sqrt(2 * m * E * 1.602e-19) / (hbar);
q1 = sqrt(2 * m * (E-V1) * 1.602e-19) /(hbar);
q2 = sqrt(2 * m * (V2-E) * 1.602e-19) /(hbar);

I = @(x) [exp(1i*k*x) , exp(-1i*k*x) ; 1i*k*exp(1i*k*x) , -1i*k*exp(-1i*k*x)];
II1 = @(x) [exp(1i*q1*x) , exp(-1i*q1*x) ; 1i*q1*exp(1i*q1*x) , -1i*q1*exp(-1i*q1*x)];
II2 = I;
II3 = @(x) [exp(-q2*x) , exp(q2*x) ; -q2*exp(-q2*x) , q2*exp(q2*x)];
III = I;

MAT = I(0)^(-1) * II1(0) * II1(x1)^(-1) * II2(x1) * II2(x2)^(-1) *  II3(x2) * II3(x3)^(-1) * III(x3);

A1 = 1;
F = A1 / MAT(1,1);

T = (abs(F)^2)/(abs(A1)^2);
A(N,2)=T;
plot(E,T,'r.')
hold on
end
save('data.txt','A','-ASCII')

%% uppg c
clc
clear
clf

V1 = 0.1;
m = 9.109e-31;
a1 = 0.3e-9; a2 = 0.75e-9;
x1 = a1 + a2;
hbar = 6.626e-34 / (2 * pi);

A=zeros(1899,2);
L=0;
for E = 0.3:0.001:2
L=L+1;
A(L,1)=E;
    
k = sqrt(2 * m * E * 1.602e-19) / (hbar);
q = sqrt(2 * m * (E-V1) * 1.602e-19) /(hbar);

I = @(x) [exp(1i*k*x) , exp(-1i*k*x) ; 1i*k*exp(1i*k*x) , -1i*k*exp(-1i*k*x)];
II = @(x) [exp(1i*q*x) , exp(-1i*q*x) ; 1i*q*exp(1i*q*x) , -1i*q*exp(-1i*q*x)];
III = I;

MAT = I(0)^(-1) * II(0) * II(x1)^(-1) * III(x1);

A1 = 1;
F = A1 / MAT(1,1);
A1B1 = II(x1)^(-1) * III(x1) * [F;0];
AB = I(0)^(-1) * II(0) * A1B1;

T = (abs(F)^2)/(abs(A1)^2);
A(L,2)=T;
plot(E,T,'r.')
hold on
end

save('data.txt','A','-ASCII')

%% calc wavelength/barrier width
clc
clear

V1 = 0.1;
m = 9.109e-31;
hbar = 6.626e-34 / (2 * pi);
a1 = 0.3e-9; a2 = 0.75e-9;
x1 = a1 + a2;

E1 = 0.441;
q1 = sqrt(2 * m * (E1-V1) * 1.602e-19) /(hbar);
lambda = 2 * pi / q1
lambda / x1

E2 = 1.464;
q2 = sqrt(2 * m * (E2-V1) * 1.602e-19) /(hbar);
lambda2 = 2 * pi / q2
lambda2 / x1

