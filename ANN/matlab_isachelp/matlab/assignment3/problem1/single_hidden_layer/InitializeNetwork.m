

function [W1,W2,TH1,TH2] = InitializeNetwork(inputSize,HiddenlayerSize,OutputSize)
    variance1 = 1/sqrt(inputSize);
    variance2 = 1/sqrt(HiddenlayerSize);
    W1 = normrnd(0,variance1,HiddenlayerSize,inputSize);
    W2 = normrnd(0,variance2,OutputSize,HiddenlayerSize);
    TH1 = zeros(HiddenlayerSize,1);
    TH2 = zeros(OutputSize,1);
end













