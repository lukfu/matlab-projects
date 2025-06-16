

function DrawCube(dist)
   
   x=[0,dist];
   y=[0,dist];
   [X,Y]=meshgrid(x,y);
   Z=zeros(size(X,1),size(X,2));
   hold on
   color='#555555';
   alpha=0.5;
   surf(X, Y, Z, 'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','black')
   surf(X, Y, Z+dist, 'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','black')
    surf(Z, X, Y, 'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','black')
    surf(Z+dist, X, Y, 'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','black')
    surf(X, Z, Y, 'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','black')
    surf(X, Z+dist, Y, 'FaceColor',color,'FaceAlpha',alpha,'EdgeColor','black')
     
end








