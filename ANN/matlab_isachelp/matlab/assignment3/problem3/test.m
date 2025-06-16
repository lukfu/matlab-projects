clear
clc
board=zeros(3);
Q1=[];
%%
[bool,i] = doesStateExist(Q1,board);
if bool
    Q1tmp=Q1(4:6,3*i-2:3*i);
    [i1,i2]=find(Q1tmp==max(max(Q1tmp)));
else
    Q1(1:3,end+1:end+3) = board;
    q = NaN(3);
    q(1,board(1,:)==0) = 0; 
    q(2,board(2,:)==0) = 0; 
    q(3,board(3,:)==0) = 0; 
    Q1(4:6,end-2:end) = q;
    [i1,i2]=find(q==max(max(q)));
end
board(i1(1),i2(1)) = 1;
 hasWon(board)
imshow((board+1)/2)