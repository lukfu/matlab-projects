clear
clc
n=4; % #dimensions 2,3,4,5
nTrials = 10000; nEpochs = 20;
eta = 0.05; % learning rate
counter = 0;
%booleanInputs = [0 0 ; 0 1 ; 1 0 ; 1 1];
booleanInputs = [];
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
for i = 1:numel(booleanInputs) % set 0 to -1
   if booleanInputs(i) == 0
       booleanInputs(i) = -1;
   end
end
usedBool = {};
duplicateCounter = 0;
for trial = 1:nTrials
    %sample boolean function
    booleanOutput = randi([0 1],2^n,1); % random vector of 1 and 0
    for i = 1:length(booleanOutput) % set 0 to -1
       if booleanOutput(i) == 0
           booleanOutput(i) = -1;
       end
    end
    isNotMember = true;
    for l = 1:length(usedBool)
        if usedBool{l} == booleanOutput
            isNotMember = false;
            duplicateCounter = duplicateCounter +1 ;
            break
        end
    end
    if isNotMember %if output not in usedBool
        w = randn(1,n) / sqrt(n); %weight
        th = 0; %threshold
    
        for epoch = 1:nEpochs
            totalError = 0;
            for mu = 1:2^n % compute output
                b = 0;
                for j = 1:n
                    b = b + w(j) * booleanInputs(mu,j);
                end
                if b == 0
                    y = 1;
                else
                    y = sign(b-th);
                end
                error = booleanOutput(mu) - y;
                %update weight and threshold
                dw = eta * (error) * booleanInputs(mu,:);
                dth = -eta * (error);
                w = w + dw;
                th = th + dth;
                totalError = totalError + abs(error);
            end
            if totalError == 0
                counter = counter+1;
                break
            end
        end
    end
    usedBool{end+1} = booleanOutput; % add booleanOutput array to usedBool array
end
numberOfBoolFunc = nTrials - duplicateCounter;
disp(numberOfBoolFunc)
disp(counter)