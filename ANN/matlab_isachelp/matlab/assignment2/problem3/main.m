clear
clc

visibleLayerSize = 3;
HiddenlayerSize = [1;2;4;8];
k=100;
eta=0.1;
mu=40;
trials=300;
averageLoop = 10;
%P(pdata(1:4))=1/4, rest =0
pdata = transpose([
    [-1,-1,-1];
    [+1,-1,+1];
    [-1,+1,+1];
    [+1,+1,-1];
    [+1,+1,+1];
    [-1,+1,-1];
    [+1,-1,-1];
    [-1,-1,+1]
]);


dklList = zeros(length(HiddenlayerSize),1);
for iHiddenSize =1:length(HiddenlayerSize)
    pbAverage=zeros(8,1);
    for iAverage =1:averageLoop
        [weight,thetaVisible,thetaHidden] = InitializeNetwork(visibleLayerSize,HiddenlayerSize(iHiddenSize));
        for IEpoch = 1:trials
            deltaWeight = zeros(HiddenlayerSize(iHiddenSize),visibleLayerSize);
            deltaThetaVisible = zeros(visibleLayerSize,1);
            deltaThetaHidden = zeros(HiddenlayerSize(iHiddenSize),1);
            for iMiniBatch = 1:mu 
                input = pdata(:,randi(4));
                [dw1,dt1,dt2] =  GetDeltaWeightsAndThreshold(eta,k,weight,input,thetaVisible,thetaHidden);
                deltaWeight = deltaWeight + dw1;
                deltaThetaVisible = deltaThetaVisible + dt1;
                deltaThetaHidden = deltaThetaHidden + dt2;
            end
            weight = weight + deltaWeight;
            thetaVisible = thetaVisible + deltaThetaVisible; 
            thetaHidden =  thetaHidden + deltaThetaHidden;
        end
        Pb = PbSimulation(weight,thetaVisible,thetaHidden,pdata);
        pbAverage = pbAverage+Pb; 
    end
    pbAverage = pbAverage/averageLoop;
    dklList(iHiddenSize) = GetKullbeckLebiblerDiverence(pbAverage,weight,thetaVisible,thetaHidden,pdata);
end
plot(HiddenlayerSize,dklList)
title('KullbeckLeibler Divergence');
xlabel('M hidden neurons')
ylabel(texlabel('D_{KL}(M)'))
