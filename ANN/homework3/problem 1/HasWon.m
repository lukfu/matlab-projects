function bool = HasWon(board)
for x = 1:3
    if abs(sum(board(:,x)))==3
        bool = true;
        return
    end
end
for y = 1:3
    if abs(sum(board(y,:)))==3
        bool = true;
        return
    end
end
diagonal1 = abs(sum(board(1,1) + board(2,2) + board(3,3))) == 3;
diagonal2 = abs(sum(board(3,1) + board(2,2) + board(1,3))) == 3;
bool = diagonal1 || diagonal2;
end