%% bonus a
x=linspace(-10,10,200); y=linspace(-10,10,200);
[X,Y]=meshgrid(x,y);
z1= X.*Y + exp(X) + X - 3;
z2= X.*sin(X) + Y.^2 - 2;

contour(X,Y,z1,[0,0],'b')
hold on
contour(X,Y,z2,[0,0],'r')
grid on

fun=@(x)[x(1).*x(2)+exp(x(1))+x(1)-3 ; x(1).*sin(x(1))+x(2).^2-2];

x1=fsolve(fun,ginput(1));
x2=fsolve(fun,ginput(1));
x3=fsolve(fun,ginput(1));
x4=fsolve(fun,ginput(1));
disp(x1);
disp(x2);
disp(x3);
disp(x4);

hold off


%% bonus b
x=linspace(-5,5,100); y=linspace(-5,5,100);
[X,Y]=meshgrid(x,y);
z= ((sin(X+Y)+3*(X-Y/2).^2).* exp(-(X.^2+Y.^2)));
%s=surfc(X,Y,z)
contour(X,Y,z)

%for minimum values
[input1,min1]=fminunc(@(x) (sin(x(1) + x(2)) + 3*(x(1) - x(2)/2).^2) .*exp(-(x(1).^2+x(2).^2)),ginput(1));
disp(min1)

%% for maximum values bonus b
x=linspace(-5,5,100); y=linspace(-5,5,100);
[X,Y]=meshgrid(x,y);
z= -((sin(X+Y)+3*(X-Y/2).^2).* exp(-(X.^2+Y.^2)));
%s=surfc(X,Y,z)
contour(X,Y,z)

[input2,val2inv]=fminunc(@(x) -((sin(x(1)+x(2))+3*(x(1)-x(2)/2).^2).*exp(-(x(1).^2+x(2).^2))),ginput(1));
[input3,val3inv]=fminunc(@(x) -((sin(x(1)+x(2))+3*(x(1)-x(2)/2).^2).*exp(-(x(1).^2+x(2).^2))),ginput(1));
max2=-val2inv;
max3=-val3inv;


%% display values bonus b
disp(input1)
disp(min1)
disp(input2)
disp(max2)
disp(input3)
disp(max3)

%% bonus c 
fun = @(x,y) y.* sin(y+x.^2);
fmax = @(x) 1- x.^2;
I = integral2(fun,-1,1,0,fmax)