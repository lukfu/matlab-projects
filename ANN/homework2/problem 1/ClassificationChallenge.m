
[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);

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
    'Momentum',0.9, ...
    'MinibatchSize',8192, ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',30, ...
    'Shuffle','every-epoch', ...
    'ValidationData',{xValid, tValid}, ...
    'ValidationFrequency',30, ...
    'ValidationPatience',5, ...
    'L2Regularization', 0, ...
    'Plots','training-progress');

net = trainNetwork(xTrain,tTrain,layers,options);
xTest2 = loadmnist2();
predtTest2 = net.classify(xTest2);
predtTest2 = cast(predtTest2,'uint8')-1;
%writematrix(predtTest2,'classifications.csv')