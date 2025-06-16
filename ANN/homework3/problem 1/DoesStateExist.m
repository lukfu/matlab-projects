function [bool,i] = DoesStateExist(Q,board)
bool = 0;
for i = 1:size(Q,2)/3
    if sum(sum(abs(Q(1:3,3*i-2:3*i)-board)))==0
        bool = 1;
        return
    end
end