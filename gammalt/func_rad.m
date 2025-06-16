function [x,y]=func_rad(a,b)
    t=linspace(0,2*pi);
    x=a+1+4.5*(sin(x*y).^2).*cos(t);
    y=b+1+4.5*(sin(x*y).^2).*sin(t);
end