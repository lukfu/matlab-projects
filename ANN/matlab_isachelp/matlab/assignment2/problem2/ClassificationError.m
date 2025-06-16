



function C = ClassificationError(weightMatrix1,weightMatrix2,theta1,theta2,input,target,plot)
    % Evaluate data
    pPatterns = size(input,2);
    C = 0;
    Ovector = zeros(pPatterns,1);
    for iPattern=1:pPatterns
        inputP=input(:,iPattern);
        V = GetNeuronValue(weightMatrix1,inputP,theta1);
        O = GetNeuronValue(weightMatrix2,V,theta2);
        Ovector(iPattern) = O; %interesting sign(O)<0 for all values
        C = C + abs(sign(O)-target(iPattern));
    end
    if nargin == 7 
      plotTraining(input,Ovector,target); 
    end   
    C = C/(2*pPatterns);

end













