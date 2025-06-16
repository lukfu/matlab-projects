function C = ClassificationError(wMat1,wMat2,theta1,theta2,input,target,plot)
    patterns = size(target,1);
    C = 0;
    outputVec = zeros(patterns,1);
    for i = 1:patterns
        inputP = input(:,i);
        V = GetNeuronValue(inputP,wMat1,theta1);
        O = GetNeuronValue(V,wMat2,theta2);
        outputVec(i) = O;
        C = C + abs(sign(O)-target(i));
    end
    if nargin == 7
        PlotTraining(input,outputVec,target)
    end
    C = 1/(2*patterns) * C;
end