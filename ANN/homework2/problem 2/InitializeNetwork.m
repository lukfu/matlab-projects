function [W1,W2,TH1,TH2] = InitializeNetwork(inputSize,hiddenLayerSize,outputSize)
    variance1 = 1/sqrt(inputSize);
    variance2 =1/sqrt(hiddenLayerSize);
    W1 = normrnd(0,variance1,hiddenLayerSize,inputSize);
    W2 = normrnd(0,variance2,outputSize,hiddenLayerSize);
    TH1 = zeros(hiddenLayerSize,1);
    TH2 = zeros(outputSize,1);
end