function bool = hasWon(board)
    for x=1:3
       if abs(sum(board(:,x)))==3
           bool = true;
           return
       end
    end
    for y=1:3
       if abs(sum(board(y,:)))==3
        bool = true;
        return
       end
    end
    c1 = abs(board(1,1)+board(2,2)+board(3,3))==3;
    c2 = abs(board(3,1)+board(2,2)+board(1,3))==3;
    bool = c1 || c2;
end
