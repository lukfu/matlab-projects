

function [weight,thetaVisible,thetaHidden] = InitializeNetwork(visibleLayerSize,HiddenlayerSize)
    weight = normrnd(0,1,HiddenlayerSize,visibleLayerSize);
    thetaVisible = zeros(visibleLayerSize,1);
    thetaHidden = zeros(HiddenlayerSize,1);
end













