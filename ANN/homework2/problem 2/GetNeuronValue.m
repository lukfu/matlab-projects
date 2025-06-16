function neuronValue = GetNeuronValue(input, weights, theta)
    neuronValue = tanh(weights*input - theta);
end