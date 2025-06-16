function [x,y]=cirkel2(a,b)
    v=linspace(0,2*pi,1000);
    x=linspace(-10,10,1000);
    y=linspace(-10,10,1000);
    r= 1+4.5*sin(x.*y);
    x=a+r.*cos(v);
    y=b+r.*sin(v);
end