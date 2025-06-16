clear; clc; clf;

nEpoch = 10;
eta = 0.1;
sigma = 10;
irisData = load('iris-data.csv');
irisLabels = load('iris-labels.csv');
maxIrisData1 = max(irisData);
maxIrisData = max(maxIrisData1);
stdIrisData = irisData/maxIrisData;
nPattern = size(irisData,1);
outputDimensions = 40; % dimensions as in matrix dimensions dim x dim

weights = zeros(40,40,4);
for k = 1:size(weights,1)
    for l = 1:size(weights,2)
        for m = 1:size(weights,3)
            weights(k,l,m) = rand;
        end
    end
end


for epoch = 1:nEpoch
    position = zeros(nPattern,2);
    for trial = 1:nPattern
        iPattern = 1 + fix(rand*nPattern);
        pattern(1,1,:) = stdIrisData(iPattern,:);
        [i0,j0] = FindWinningNeuron(pattern,weights);
        r0 = [i0 j0];
        position(trial,:) = r0;
        
        it = 0;
        for i = 1:outputDimensions
            for j = 1:outputDimensions
                r = [i j];
                dRtoR0 = vecnorm(r-r0);
                
                if dRtoR0 < 3 * sigma
                    it = it + 1;
                    h = exp(-dRtoR0^2 / (2*sigma^2));
                    dw = eta * h * (pattern - weights(i,j,:));
                    weights(i,j,:) = weights(i,j,:) + dw;
                end
                disp(it)
            end
        end
    end
    if epoch==1
        subplot(3,1,1)
        gscatter(position(:,1),position(:,2),irisLabels)
    end
    if epoch==2
        subplot(3,1,2)
        gscatter(position(:,1),position(:,2),irisLabels)
    end
    if epoch==3
        subplot(3,1,3)
        gscatter(position(:,1),position(:,2),irisLabels)
    end
end