n=11; %funkar bra f�r n<12
x=[1;1;1;1;1;1;1;1;1;1;1];
H = hilb(n);
k = cond(H);
b = H * x;
xh = H \ b
diffx = xh-x
r = b - H * xh