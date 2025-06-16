
function [deltaWeight,deltaThetaVisible,deltaThetaHidden] = GetDeltaWeightsAndThreshold(eta,k,weight,trainingData,thetaVisible,thetaHidden)
    
    [vt0,vt100] = BoltzmannSimulation(weight,thetaVisible,thetaHidden,trainingData,k);
    bh0 = weight*vt0-thetaHidden;
    bh100 = weight*vt100-thetaHidden;
    
    w1 = tanh(bh0)*transpose(vt0);
    w2 = tanh(bh100)*transpose(vt100);
    deltaWeight = eta*(w1-w2);
    deltaThetaVisible = -eta*(vt0-vt100);
    
    t1 = tanh(bh0);
    t2 = tanh(bh100);
    deltaThetaHidden = -eta*(t1-t2);
end