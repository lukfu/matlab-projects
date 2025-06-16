
function [minInstructionLength,maxInstructionLength,operatorSet,constantRegister,nVariableRegister] = InitializeLGPConstants()
    minInstructionLength = 5;
    maxInstructionLength = 17;
    operatorSet = ['+','-','*','/'];
    constantRegister = [1,2,4];
    nVariableRegister = 3;
end