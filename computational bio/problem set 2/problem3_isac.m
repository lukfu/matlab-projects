



N=1E1;
theta_rand = rand(N,1)*pi-pi/2;
gamma=0.5;%start with 0.5 and try decreaseing later
g = @(w) (gamma/pi)./(gamma^2+w.^2);
w_rand = trnd(gamma,N,1);
hist(w_rand)

x=linspace(-100,100,1E6)';
y=zeros(length(x),1);
for iX=1:length(x)
    y(iX)=g(x(iX));
end
plot(x,y)





%
%r=C Sqrt(u)   where 0<u=(K-Kc)/Kc<<1
%todo: C=??

%|r|=|re^(iY)|=|1/N sum(e^(i theta_j))|
