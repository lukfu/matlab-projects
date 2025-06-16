function DrawPlane(xval,yval,zval,dist)
    x=-1:0.5:dist+1;
    y=-1:0.5:dist+1;
    [X,Y] = meshgrid(x,y);
    Z1 = dist/2 +  (xval(1)-xval(2))*X + (yval(1)-yval(2))*Y;
    surf(X,Y,Z1)
end