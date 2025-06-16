function as = UpdateQ(Q,i,board2)
       b1 = (board2<=i-1).*board2;
       b2 = (board2<=i).*board2;
       b3 = (board2<=i+1).*board2;
       previousBoard = mod(b1,2)*2-1;
       currentBoard = mod(b2,2)*2-1;
       nextBoard =  mod(b3,2)*2-1;
end