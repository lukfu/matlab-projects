clear; clc; clf;

nEpoch = 10;
eta = 0.1;
sigma = 10;
irisData = load('iris-data.csv');
irisLabels = load('iris-labels.csv');
maxIrisData = max(irisData);
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

    for trial = 1:nPattern
        iPattern = 1 + fix(rand*nPattern);
        pattern(1,1,:) = irisData(iPattern,:);
        [i0,j0] = FindWinningNeuron(pattern,weights);
        i0 = i0 + normrnd(0,0.02);
        j0 = j0 + normrnd(0,0.02);
        r0 = [i0 j0];

        for i = 1:outputDimensions
            for j = 1:outputDimensions
                r = [i j];
                distanceToR0 = vecnorm(r-r0);

                if distanceToR0 < 3 * sigma
                    h = exp(-distanceToR0^2 / (2*sigma^2));
                    dw = eta * h * (pattern - weights(i,j,:));
                    weights(i,j,:) = weights(i,j,:) + dw;
                end
            end
        end
    end
    if epoch == 1
        subplot(2,1,1)
        position = zeros(nPattern,2);
        for k = 1:nPattern
            x(1,1,:) = irisData(k,:);
            [i0,j0] = FindWinningNeuron(x,weights);
            position(k,:) = [i0,j0];
        end
        gscatter(position(:,1),position(:,2),irisLabels)
    end
    
    [sigma,eta] = UpdateSigmaEta(sigma,eta,epoch);
end
subplot(2,1,2)
position = zeros(nPattern,2);
for k = 1:nPattern
    x(1,1,:) = irisData(k,:);
    [i0,j0] = FindWinningNeuron(x,weights);
    position(k,:) = [i0,j0];
end
gscatter(position(:,1),position(:,2),irisLabels)