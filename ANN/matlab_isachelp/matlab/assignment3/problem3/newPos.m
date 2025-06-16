function [i1,i2] = newPos(board,mu)
    if rand >= mu
        [i1,i2]=find(board==max(max(board)));
        r1 = randi(max(1,length(i1)));
        r2 = randi(max(1,length(i2)));
        i1=i1(r1);
        i2=i2(r2);
    else
        [i1,i2]=find(isnan(board)==0);
        r1 = randi(max(1,length(i1)));
        r2 = randi(max(1,length(i2)));
        i1=i1(r1);
        i2=i2(r2);
    end
end