%% uppgift 1
x=(-pi/2)+0.1:0.01:(pi/2)-0.01;

plot(x,tan(x))
grid on
grid minor

%% uppgift 2
d=linspace(2,14,5)

%% uppgift 3
x=(0:0.01:8);
func=x-x.*cos(7.*x);
plot(x,func)
grid on
grid minor

%% uppgift 4
t=(0:0.01:2*pi);
func_x=cos(t)+cos(3*t);
func_y=sin(2*t);
subplot(1,2,1)
plot(func_x,func_y)
grid on
grid minor

subplot(1,2,2)
func_x=cos(t)+cos(4*t);
func_y=sin(2*t);
plot(func_x,func_y)
grid on
grid minor

%% uppgift 5


