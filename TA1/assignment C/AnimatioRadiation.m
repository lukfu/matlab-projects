% Animation of a sound field
close all
clear

%Number of frames
Nframes=50;

rho=1.2
omega=10*2*pi;
c=340;
k0=omega/c;

%Part1 vibrating plate
%create x-vector
x=0:0.1:40;
xp=1:1:40;
yp=1:1:20;
nx=length(xp);
ny=length(yp);

[xp,yp]=meshgrid(xp,yp);
xp=reshape(xp,nx*ny,1);
yp=reshape(yp,nx*ny,1);



%wavelength on the plate
lambda=10;
%wavnumber: 
kb=2*pi/lambda;

k0=kb*1.1


% Amplitude of the wave
vb=0.4;

% wave
xi=vb*exp(-j*kb*x);

figure(1);
kx=kb;
ky=sqrt(k0^2-kx^2);
ky=real(ky)-j*imag(ky);
Ay=vb;
Ax=kx*vb/ky;

xiAirX= Ax*exp(-j*kx*xp).*exp(-j*ky*yp);
xiAirY= Ay*exp(-j*kx*xp).*exp(-j*ky*yp);

for iframe=1:Nframes
    ExpTime=exp(j*2*pi*iframe/20);
    xiReal=real(xi*ExpTime);
    xiAirXReal=xp+real(xiAirX*ExpTime);
    xiAirYReal=yp+real(xiAirY*ExpTime);
    
    clf
    plot(x,xiReal,'LineWidth',2,'Color',[0 0 0]);hold on
    plot(xiAirXReal, xiAirYReal, 'MarkerFaceColor',[0 0.447058826684952 0.74117648601532],...
    'Marker','o',...
    'LineStyle','none',...
    'Color',[0 0.447058826684952 0.74117648601532]);
    hold off
    
    xlim([-2 22])
    ylim([-2 22])
    axis equal
    axis off
    
    drawnow
    %pause(0.5)
end







