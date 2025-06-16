clc; clear;
nGames = 4000;
eps = 1;
alpha = 0.9;
Q1 = [];
Q2 = [];
winnerList = zeros(nGames,1);
for iGame = 1:nGames
    if mod(iGame,100) == 0
        fprintf('game: %0.0f',iGame)
        fprintf('\n')
    end
    %initialize board
    board = zeros(3,3);
    board2 = board;
    %for loop over 5 rounds
    for iRound = 1:5
        %player 1
        [bool,i] = DoesStateExist(Q1,board);
        if bool
            q = Q1(4:6,3*i - 2:3*i);
        else
            Q1(1:3,end+1:end+3) = board;
            q = NaN(3);
            q(1,board(1,:)==0) = 0;
            q(2,board(2,:)==0) = 0;
            q(3,board(3,:)==0) = 0;
            Q1(4:6,end-2:end) = q;
        end
        [i1,i2] = NewPosition(q,eps);
        board(i1,i2) = 1;
        board2(i1,i2) = 2 * iRound - 1;
        if HasWon(board)
            break
        end
        if iRound == 5
            break
        end
        %player 2
        [bool,i] = DoesStateExist(Q2,board);
        if bool
            q = Q2(4:6,3*i - 2:3*i);
        else
            Q2(1:3,end+1:end+3) = board;
            q = NaN(3);
            q(1,board(1,:)==0) = 0;
            q(2,board(2,:)==0) = 0;
            q(3,board(3,:)==0) = 0;
            Q2(4:6,end-2:end) = q;
        end
        [i1,i2] = NewPosition(q,eps);
        board(i1,i2) = -1;
        board2(i1,i2) = 2 * iRound;
        if HasWon(board)
            break
        end
    end

    %check winner, update Q
    maxIndex = max(max(board2));
    winner = mod(maxIndex,2) * 2 - 1;
    if maxIndex == 9
        if not(HasWon(board))
            winner = 0;
        end
    end
    winnerList(iGame) = winner;
    for i = 1:maxIndex-1
        b1 = (board <= i-1).* board2;
        b2 = (board <= i+1).* board2;
        previousBoard = mod(b1,2)*2 - 1;
        nextBoard = mod(b2,2)*2 - 1;
        if mod(i,2) == 0
            [~,iPrevious] = DoesStateExist(Q1,previousBoard);
            [~,iNext] = DoesStateExist(Q1,nextBoard);
            q1 = Q1(4:6,3*iPrevious - 2:3*iPrevious);
            q2 = Q1(4:6,3*iNext - 2:3*iNext);
            maxQ = max(max(q2));
            nextMaxState = (q2==maxQ) * maxQ;
            newQ = q1 + alpha * (nextMaxState - q1);
            Q1(4:6,3*iPrevious - 2:3*iPrevious) = newQ;
        else
            [~,iPrevious] = DoesStateExist(Q2,previousBoard);
            [~,iNext] = DoesStateExist(Q2,nextBoard);
            q1 = Q2(4:6,3*iPrevious - 2:3*iPrevious);
            q2 = Q2(4:6,3*iNext - 2:3*iNext);
            maxQ = max(max(q2));
            nextMaxState = (q2==maxQ) * maxQ;
            newQ = q1 + alpha * (nextMaxState - q1);
            Q2(4:6,3*iPrevious - 2:3*iPrevious) = newQ;
        end
    end
    
    if winner == 1 || winner == 0
        board(board2==maxIndex) = 0;
        [~,i1] = DoesStateExist(Q1,board);
        Q1(4:6,3*i1 - 2:3*i1) = Q1(4:6,3*i1 - 2:3*i1) + winner * alpha*(board2==maxIndex);
        board(board2==maxIndex-1) = 0;
        [~,i1] = DoesStateExist(Q2,board);
        Q2(4:6,3*i1 - 2:3*i1) = Q2(4:6,3*i1 - 2:3*i1) + winner * alpha*(board2==maxIndex-1);
    else
        board(board2==maxIndex) = 0;
        [~,i1] = DoesStateExist(Q2,board);
        Q2(4:6,3*i1 - 2:3*i1) = Q2(4:6,3*i1 - 2:3*i1) + winner * alpha*(board2==maxIndex);
        board(board2==maxIndex-1) = 0;
        [~,i1] = DoesStateExist(Q1,board);
        Q1(4:6,3*i1 - 2:3*i1) = Q1(4:6,3*i1 - 2:3*i1) + winner * alpha*(board2==maxIndex-1);
    end
    hold on
    if mod(iGame,100) == 0
        eps = eps * 0.95;
        p1Win = 0;
        p2Win = 0;
        draw = 0;
        for games = iGame-100:iGame
            if winnerList(games+1) == 1
                p1Win = p1Win+1;
            elseif winnerList(games+1) == -1
                p2Win = p2Win+1;
            elseif winnerList(games+1) == 0
                draw = draw + 1;
            end
            plot(p1Win,iGame,'rx')
            plot(p2Win,iGame,'bx')
            plot(draw,iGame,'gx')
        end
    end
end

