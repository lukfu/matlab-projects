
function estimatedYValue = Decode(individual,xValue,shouldDecodeString)
    if nargin <=2
        shouldDecodeString=false; 
    end
    [~,~, operatorSet, constantRegister, nVariableRegister] = InitializeLGPConstants();
    individual = individual.Chromosome;    
    
    if shouldDecodeString
       syms x
       variableRegister = [x,(1:nVariableRegister-1)*0];
    else
        variableRegister = zeros(1,nVariableRegister);
        variableRegister(1) = xValue;
    end
    register = [variableRegister,constantRegister];
    %update register for each block of 4 genes
    for iBlock = 1:length(individual)/4
       chromosomePart = individual(4*iBlock-3 : 4*iBlock);
       operator = chromosomePart(1);
       destination = chromosomePart(2);
       operand1 = chromosomePart(3);
       operand2 = chromosomePart(4);
       register(destination) = DecodeOperators(operatorSet(operator),...
           register(operand1),register(operand2),constantRegister); 
    end
    estimatedYValue = register(1);
end