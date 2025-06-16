
% Load data
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

% Network
layers = [
    imageInputLayer([28 28 1])
    convolution2dLayer(3,20,'Padding',1,'WeightsInitializer','narrow-normal','BiasInitializer','narrow-normal')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,30,'Padding',1,'WeightsInitializer','narrow-normal','BiasInitializer','narrow-normal')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)
    convolution2dLayer(3,50,'Padding',1,'WeightsInitializer','narrow-normal','BiasInitializer','narrow-normal')
    batchNormalizationLayer
    reluLayer 
    fullyConnectedLayer(10,'WeightsInitializer','narrow-normal','BiasInitializer','narrow-normal')
    softmaxLayer
    classificationLayer
];


options = trainingOptions('sgdm', ...
    'Momentum', 0.9,...
    'MiniBatchSize', 8192,...
    'ValidationData',{xValid, tValid}, ...
    'ValidationFrequency',30, ...
    'MaxEpochs',10, ...
    'ValidationPatience',5, ...
    'Plots','training-progress',...
    'InitialLearnRate',0.01,...
    'L2Regularization', 0, ...
    'Shuffle','every-epoch');


[net,tr] = trainNetwork(xTrain, tTrain, layers, options);
% predict
xTestOpenTA = loadmnist2();
predtTestOpenTA = net.classify(xTestOpenTA);
predtTestOpenTA = cast(predtTestOpenTA,'uint8')-1;
%csvwrite('classifications.csv',predtTestOpenTA)











