clc
clear

p = 24; % 12, 24, 48, 70, 100, 120
N = 120; nTrials = 100000;
error = 0;
for trial = 1:nTrials
    %generate random patterns
    pattern = randi([0 1],N,p);
%     for i = 1:numel(pattern) % set 0 to -1
%         if pattern(i) == 0
%             pattern(i) = -1;
%         end
%     end
    w = zeros(N);
    for i=1:p
        for j=1:N
            for k=1:N
               w(j,k)= w(j,k)+pattern(j,i) * pattern(k,i) * (1/N);
            end
        end
    end
    for j = 1:N
        w(j,j) = 0;
    end
    randNeuron = randi(p);
    randPattern = pattern(:,randNeuron);
    b = (1 - 1/N) * randPattern + w(randNeuron,:) .* pattern(1:120);
    activation = sign(b);
    
    if activation == 0
        activation = 1;
    end
    
    if activation ~= randPattern
        error = error + 1;
    end
end
errorProbability = error/nTrials;
disp(errorProbability)
