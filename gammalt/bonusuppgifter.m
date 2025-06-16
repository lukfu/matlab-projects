%% test a
clear

syms x y
fimplicit(x.^2+y.^2 == 1+4.5*(sin(x.*y).^2))


%% a
clf
%x=rcos(v), y=rsin(v), f=y^2
f=@(r,v) r^2-1-4.5*sin(r^2*cos(v)*sin(v))^2;
R=zeros(1,1000); %will be filled with values of the radius
n=1000;
v=linspace(0,2*pi,n);
for i=1:n
    R(i)=fzero(@(r) f(r,v(i)), 1);
end
X=R.*cos(v);
Y=R.*sin(v);
plot(X,Y);
axis equal

l=length(X);
L=0;
for i=1:n-1
    L=L+sqrt((X(i+1)-X(i))^2+(Y(i+1)-Y(i))^2);
end
L


%% a
R=zeros(1,1000);
theta=zeros(1,1000);
for i=1:1000
    theta(i)=(i-1)*2*pi/1000.0;
    dr=0.1;
    r=-dr;
    B=1.0;
    for j=1:10000
        r=r+dr;
        A=1-r^2+4.5*(sin(r*r*sin(theta(i))*cos(theta(i))))^2;
        if j == 1
            if A < 0
                B=-1.0;
            end
        end
        if A*B < 0
            r=r-dr;
            dr=dr*0.1;
            if dr < 1.0e-9
                break;
            end
        end
    end
    R(i)=r;
end

x=R.*cos(theta);
y=R.*sin(theta);

plot(x,y)
axis equal

%%
v=linspace(0,2*pi);
x= r.*cos(v);
y= r.*sin(v);


%% b
r= @(v) 2+sin(5*v+2.2*cos(5*v));
v=linspace(0,2*pi, 2000);
x=r(v).*cos(v);
y=r(v).*sin(v);
plot(x,y,'b')
hold on
plot([-4 4],[0 0],'k')
hold on
plot([0 0],[-3.2 3.2],'k')
grid on
axis equal

n=length(x);
L=0;
for i=1:n-1 %i börjar på 1, n-1 ger 499 punkter från 1-500
    L=L+sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);
end
L

q=integral(@(v) 2+sin(5*v+2.2*cos(5*v)),0,2*pi);
q

hold off

%% c
clf
clear

x=linspace(0,25,5000);
y=1.5 + sin(0.02*x.^2);

plot(x,y)
grid on
grid minor
axis([0 25 0 3])

n=length(x);
L=0;
for i=1:n-1
    L=L+sqrt((x(i+1)-x(i))^2+(y(i+1)-y(i))^2);
end
A=2*pi*L

q=integral(@(x) 1.5 + sin(0.02*x.^2),0,25);
V=pi*(q.^2)
