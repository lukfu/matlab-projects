
function C = ClassificationError(weightMatrix1,weightMatrix2,theta1,theta2,input,target)
    % Evaluate data
    pPatterns = size(input,2);
    C = 0;
    for iPattern=1:pPatterns
        inputP=input(:,iPattern);
        V = GetNeuronValue(weightMatrix1,inputP,theta1);
        O = GetNeuronValue(weightMatrix2,V,theta2);
        %IF FAILS: get index of max value in O, put rest to 0, and max=1
        [~,iVal] = max(O);
        O=zeros(length(O),1);
        O(iVal)=1;
        targetI = target(:,iPattern);
        isCorrect = sum(abs(O-targetI));
        C = C + isCorrect;
    end
    C = C/(2*pPatterns);
end













