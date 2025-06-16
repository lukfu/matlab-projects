
%% pasta
x=linspace(0,5,30); y=linspace(0,5,30);
[X,Y]=meshgrid(x,y);
Z=X.*cos(2*X).*sin(Y);
s=surfc(X,Y,Z,'facecolor','interp')
lighting phong, camlight right
grid on
xlabel('x'), ylabel('y'), zlabel('z = x cos(2x) sin(y)')
%s.EdgeColor='none';
colormap(parula)

%% mer pasta
r=0.8; a=2; n=150; m=400;
s=linspace(-pi,pi,n); t=linspace(0,2*pi,m);
[S,T]=meshgrid(s,t);
% Genererar n x m matriser X, Y, Z, s?a att surf(X,Y,Z) ger torusen
X=(a+r*cos(S)).*cos(T);
Y=(a+r*cos(S)).*sin(T);
Z=r*sin(S);
s=surf(X,Y,Z)
lighting phong, camlight right
axis equal
s.EdgeColor='none';
colormap(copper)

%% pasta boll o näs
n=150; m=200;
s=linspace(0,pi,n); t=linspace(0,2*pi,m);
[S,T]=meshgrid(s,t);
% Genererar n x m matriser X, Y, Z, s?a att surf(X,Y,Z) ger sf¨aren
X=abs(cos(S)).*sin(S).*cos(T);
Y=abs(cos(S)).*sin(S).*sin(T);
Z=abs(cos(S)).*cos(S);
h=surf(X,Y,Z);
lighting phong, camlight right
axis equal
s.EdgeColor='none';
