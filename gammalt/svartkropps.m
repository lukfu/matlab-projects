%% svartkropp del a
x= linspace(0,5e-6,100000);
y1= planck(x,3000);
y2= planck(x,4000);
y3= planck(x,5000);

plot(x,y1,'k');
hold on
plot(x,y2,'k');
hold on
plot(x,y3,'k');

negplanck1=@(x)-planck(x,3000);
negplanck2=@(x)-planck(x,4000);
negplanck3=@(x)-planck(x,5000);

option=optimset('TolX',1e-10);
max1= fminbnd(negplanck1,5e-7,1e-6,option);
max2= fminbnd(negplanck2,5e-7,1e-6,option);
max3= fminbnd(negplanck3,5e-7,1.5e-6,option);

disp(max1);
disp(max2);
disp(max3);

plot(max1, planck(max1,3000),'rx');
plot(max2, planck(max2,4000),'rx');
plot(max3, planck(max3,5000),'rx');

wiens1=max1*3000;
wiens2=max2*4000;
wiens3=max3*5000;

disp(wiens1);
disp(wiens2);
disp(wiens3);

hold off

%% uppg b
func = @(x) (5-x).* exp(x)-5;
pFunc = @(x) (5-x).* exp(x) - exp(x);
%x=linspace(-5, 5.5,100);
%y=func(x);
%plot(x,y)
%grid on
%hold on

xp=4.8;                                         
nmax=20;                                        
felv=1;                                          
xvals=xp;                                        
n=0;                                           

while felv>=1e-5&n<=nmax                        
    xp1=xp-((5-xp).* exp(xp)-5)/((5-xp).* exp(xp) - exp(xp));  
    xvals=[xvals;xp1];                            
    felv=abs(xp1-xp);                              
    xp=xp1;n=n+1;                                 
end 
xvals;
h=6.6256e-34;c=2.9979e8;k=1.3805e-23;
wiens = h*c/(k*xp)


%% uppg c
sig = 5.67e-8;
Me = @(T)sig*T.^4;
Ms = quadl(me, 4e-7,7e-7);
T=linspace(100,10000,100);
q=Me(T)./Ms;
plot(T,q)
grid on

