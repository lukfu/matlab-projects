
TGamesTrain = 4*10^3;
mu = 0.8;
mucopy = mu;
a = 0.9;
Q1=[];
Q2=[];

winnerList=zeros(TGamesTrain,1);
for iGame = 1:TGamesTrain
    if mod(iGame,1000)==0
       fprintf('game: %0.0f',iGame) 
    end
    board = zeros(3,3);
    board2 = board;
    
    for iRound=1:5
        [bool,i] = doesStateExist(Q1,board);
        if bool
            q = Q1(4:6,3*i-2:3*i); 
        else
            Q1(1:3,end+1:end+3) = board;
            q = NaN(3);
            q(1,board(1,:)==0) = 0; 
            q(2,board(2,:)==0) = 0; 
            q(3,board(3,:)==0) = 0; 
            Q1(4:6,end-2:end) = q;
        end
        [i1,i2] = newPos(q,mu);
        board(i1,i2) = 1;
        board2(i1,i2) = 2*iRound-1;
        if hasWon(board) break, end
        if iRound == 5 break, end
        
        %player2
        [bool,i] = doesStateExist(Q2,board);
        if bool
            q = Q2(4:6,3*i-2:3*i);
        else
            Q2(1:3,end+1:end+3) = board;
            q = NaN(3);
            q(1,board(1,:)==0) = 0; %random values betwen 0-0.1!
            q(2,board(2,:)==0) = 0; 
            q(3,board(3,:)==0) = 0; 
            Q2(4:6,end-2:end) = q;
        end
        [i1,i2] = newPos(q,mu);
        board(i1,i2) = -1;
        board2(i1,i2) = 2*iRound;
        
        if hasWon(board) break, end
    end    
    
    %update qMatrix
    maxIndex = max(max(board2));
    winner = mod(maxIndex,2)*2-1;
    if maxIndex == 9
        if not(hasWon(board))
            winner=0;
        end
    end
    winnerList(iGame)=winner;
    for i=1:maxIndex-1
       b1 = (board2<=i-1).*board2;
       b2 = (board2<=i+1).*board2;
       previousBoard = mod(b1,2)*2-1;
       nextBoard =  mod(b2,2)*2-1;
       if mod(i,2)==0
           [~,i1] = doesStateExist(Q1,previousBoard);
           [~,i2] = doesStateExist(Q1,nextBoard);
           q1 = Q1(4:6,3*i1-2:3*i1);
           q2 = Q1(4:6,3*i2-2:3*i2);
           mQ = max(max(q2));
           maxNextState = (q2==mQ)*mQ;
           newQ = q1+a*(maxNextState-q1);
           Q1(4:6,3*i1-2:3*i1) = newQ;
       else
           [~,i1] = doesStateExist(Q2,previousBoard);
           [~,i2] = doesStateExist(Q2,nextBoard);
           q1 = Q2(4:6,3*i1-2:3*i1);
           q2 = Q2(4:6,3*i2-2:3*i2);
           mQ = max(max(q2));
           maxNextState = (q2==mQ)*mQ;
           newQ = q1+a*(maxNextState-q1);
           Q2(4:6,3*i1-2:3*i1) = newQ;
       end
    end
    
    if winner == 1 || winner ==0
       board(board2==maxIndex)=0;
       [~,i1] = doesStateExist(Q1,board);
       Q1(4:6,i1*3-2:i1*3) = Q1(4:6,i1*3-2:i1*3)+winner*a*(board2==maxIndex);
       board(board2==maxIndex-1)=0;
       [~,i1] = doesStateExist(Q2,board);
       Q2(4:6,i1*3-2:i1*3) = Q2(4:6,i1*3-2:i1*3)+winner*a*(board2==(maxIndex-1));   
    else
       board(board2==maxIndex)=0;
       [~,i1] = doesStateExist(Q2,board);
       Q2(4:6,i1*3-2:i1*3) = Q2(4:6,i1*3-2:i1*3)+winner*a*(board2==maxIndex);
       board(board2==maxIndex-1)=0;
       [~,i1] = doesStateExist(Q1,board);
       Q1(4:6,i1*3-2:i1*3) = Q1(4:6,i1*3-2:i1*3)+winner*a*(board2==(maxIndex-1));  
    end

    mu = mu-mucopy/TGamesTrain;
end
plot(winnerList)
csvwrite('player1.csv',Q1);
csvwrite('player2.csv',Q1);


