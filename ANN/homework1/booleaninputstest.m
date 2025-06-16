booleanInputs = [];
n = 5;
% D = 2;
% binNum = dec2bin(D,n);
% binNumCell = regexp(binNum,'\d','match');
% num1 = str2double(binNumCell{1});
% num2 = str2double(binNumCell{2});
for D = 1:2^n
    binNum = dec2bin(D-1,n);
    binNumArray = regexp(binNum,'\d','match');
    binVec = [];
    for i = 1:n
        binDigit = str2double(binNumArray{i});
        binVec = [binVec binDigit];
    end
    booleanInputs = [booleanInputs ; binVec];
end