function [x,y]=cirkel(a,b,r)
%Potion seller, I want to buy your strongest potion.
    t=linspace(0,2*pi);
    x=a+r*cos(t);
    y=b+r*sin(t);