function [net, tr, net_encode,net_decode] = TrainNetworkFunction(epochs,bottleneckSize,xTrain,xValid,net)

layers = [
    sequenceInputLayer(784)
    fullyConnectedLayer(50,'WeightsInitializer','glorot')
    reluLayer
    fullyConnectedLayer(bottleneckSize,'WeightsInitializer','glorot')
    reluLayer
    fullyConnectedLayer(784,'WeightsInitializer','glorot')
    reluLayer
    regressionLayer
];
if nargin ==5
    layers = net.Layers;
end
options = trainingOptions('adam', ...
    'MiniBatchSize', 8192,...
    'ValidationData',{xValid, xValid}, ...
    'ValidationFrequency',30, ...
    'MaxEpochs',epochs, ...
    'ValidationPatience',5, ...
    'Plots','training-progress',...
    'InitialLearnRate', 0.001,...
    'Shuffle','every-epoch');

[net, tr] = trainNetwork(xTrain, xTrain, layers, options);
layers_encode(1:5) = net.Layers(1:5);%or 1:5
layers_encode(6) = net.Layers(8);
net_encode = assembleNetwork(layers_encode);

layers_decode(1) = sequenceInputLayer(bottleneckSize);
layers_decode(2:5) = net.Layers(5:8);%or 6:8
net_decode = assembleNetwork(layers_decode);
end