

function neuronValue = GetNeuronValue(weights,input,theta)
    expTerm = weights*input - theta;
    neuronValue = 1./(1+exp(-expTerm));
end




















