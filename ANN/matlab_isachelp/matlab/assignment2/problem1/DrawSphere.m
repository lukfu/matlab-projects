
%global variable == dist
%posIndex=1:8
%OUTpUT=0== black,    1= white
function d = DrawSphere(posIndex,outPut)

    dist=2;
    [X,Y,Z] = sphere;
    hold on

    r = 0.2;
    X2 = X * r;
    Y2 = Y * r;
    Z2 = Z * r;

    aColor=[0,0,1]*abs(1-outPut)+[0,0,0]*outPut;

    switch posIndex
        case 1
            surf(X2,Y2,Z2+dist,'FaceColor', aColor,'LineStyle','none')
        case 2
            surf(X2+dist,Y2,Z2+dist,'FaceColor', aColor,'LineStyle','none')  
        case 3
            surf(X2,Y2+dist,Z2+dist,'FaceColor', aColor,'LineStyle','none')  
        case 4
            surf(X2+dist,Y2+dist,Z2+dist,'FaceColor', aColor,'LineStyle','none')  
        case 5
            surf(X2,Y2,Z2,'FaceColor', aColor,'LineStyle','none')  
        case 6
            surf(X2+dist,Y2,Z2,'FaceColor', aColor,'LineStyle','none')  
        case 7
            surf(X2,Y2+dist,Z2,'FaceColor', aColor,'LineStyle','none')  
        otherwise
            surf(X2+dist,Y2+dist,Z2,'FaceColor', aColor,'LineStyle','none')  
    end


end