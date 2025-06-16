% radiation Rayleigh integral
clear

close all

% definition of basic quantities
% density 
rho=1.2;
%speed of sound
c=344;

%frequency
f=100;
omega=2*pi*f;
k=omega/c;

%definition v0
v0=1;
%v1=v0;
%v2=2*v0;
%v3=v0;
%v4=-v0;
%v5=-2*v0;
%v6=-v0;

% half the distance between the  sourceas
a=0.1;

% Distance for the receiving positions
R=3000;
fi=-pi/2:0.001:pi/2;
Nr=length(fi);

%source definitions

%coordinates
x=(-5:2:5)*a;
%amplitudes
v=[v0 2*v0 v0 -v0 -2*v0 -v0];

%switch
%the elements set to one are switched on
%for single source (only first switch on) it would be [1 0 0 0 0 0]
s=[ 1 0 0 0 0 0];

q=s.*v*4*a^2;

Ns=length(v);




%receiving positions
xr=R*sin(fi);
zr=R*cos(fi);

% create distance between each source and all receiver

for i=1:6
    ri(i,:)=sqrt((x(i)-xr).^2+zr.^2);
end

ri_e=sqrt((repmat(x',1,Nr)-repmat(xr,Ns,1)).^2+repmat(zr,Ns,1).^2);


%calculate the pressure

p=1i*omega*rho/2/pi*sum(repmat(q',1,Nr)./ri.*exp(-1i*k*ri),1);
%check repmat by typing help repmat or by using small vectors

Lp=20*log10(abs(p));
figure(1);plot(fi,Lp)

grid on

xlim([-pi/2 pi/2])
xlabel('fi from -pi/2 to pi/2')
ylabel('level of pressure L_p [dB]')











