[x,y]=cirkel(0,0,1);
plot(x,y,'k')
hold on
[x,y]=cirkel(0,0,2);
plot(x,y,'k')
hold on
[x,y]=cirkel(0,0,3);
plot(x,y,'k')
hold on
axis([-3 5.7 -3.8 3])
set(findall(gcf,'-property','FontSize'),'FontSize',20)

plot(1.1,-0.8,'ro')
text(1.3,-0.9,'V')
plot(2.1,-0.8,'ro')
text(2.3,-0.9,'H')

plot(0,0,'k.')
text(0.1,0,'t_0')
text(1,0.6,'t_1')
text(1.9,1.1,'t_2')
text(2.8,1.6,'t_3')
axis off
hold off
