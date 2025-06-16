tryck = importdata('tryckfalt.dat');
vind_u = importdata('vindfalt_u.dat');
vind_v = importdata('vindfalt_v.dat');

x = linspace(0,55*30,31);
y = linspace(0,55*29,30);

clf

quiver(x,y,vind_u,vind_v,'r');
%  streamline(x,y,vind_u,vind_v,0,0)
xlim([0 30*55])
ylim([0 55*29])
grid minor
