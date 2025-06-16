d = 14;
m = 21;
j = 1:1:d;
x = linspace(0,1,m);
x=x';
a = ones(d+1,1);
y=p(x);
A = vander(x);
A(:,1:m-d-1)=[];
%normalekv.
at = transpose(A);
ata = at*A;
aty = at*y;
ahat = ata\aty;
anorm = norm(ahat-a)
[Q,R] = qr(A);
ahat2 = R\(transpose(Q)*y);
anorm2 = norm(ahat2-a)
[U,S,V] = svds(A,12);
ahat3 = V*(S^-1)*transpose(U)*y;
ahat4 = V*inv(S)*transpose(U)*y;
anorm3 = norm(ahat3-a)
anorm4 = norm(ahat4-a)

function y=p(x)
    y=0;
    d=14;
    for i=0:d
        y=y+x.^i;
    end
end