

%load data
[xTrain, xTarget, vTrain, vTarget, testTrain, testTarget] = LoadMNIST(2);
 xTrain = xTrain + 0.1*rand(size(xTrain,1),size(xTrain,2));
 xTrain = abs(xTrain)/max(max(xTrain));

nInputs = size(xTrain,1);
nOutputs = size(xTarget,1);
pPatterns = size(xTrain,2);
%Parameter TO be tested
M=30;
eta=0.01;

%initialize weights/threshold
[weightMatrix1,weightMatrix2,theta1,theta2] = InitializeNetwork(nInputs,M,nOutputs);
clc
C=1;
while C>0.04 
    C_copy = C;
    for iPattern=1:pPatterns
        indexChosen=fix(rand*pPatterns)+1;
        target = xTarget(:,indexChosen);
        X = xTrain(:,indexChosen);
        V = GetNeuronValue(weightMatrix1,X,theta1);
        O = GetNeuronValue(weightMatrix2,V,theta2);
        [weightMatrix1,weightMatrix2,theta1,theta2] = UpdateWeightsAndTheta(eta,weightMatrix1,weightMatrix2...
            ,theta1,theta2,X,V,O,target);
    end
    C = ClassificationError(weightMatrix1,weightMatrix2,theta1,theta2,vTrain, vTarget);
    fprintf('C: %0.4f\n',C)
    if C > C_copy
        break 
    end
end

xTest2 = loadmnist2();
patterns = length(xTest2(1,1,1,:));
xTest = zeros(28*28,patterns);
for i=1:patterns
    xTest(:,i)= reshape(xTest2(:,:,:,i),[28*28,1]);
end
xTest = xTest/255;

predictionList = zeros(patterns,1);
for iPattern=1:patterns
    inputP=xTest(:,iPattern);
    V = GetNeuronValue(weightMatrix1,inputP,theta1);
    O = GetNeuronValue(weightMatrix2,V,theta2);
    [~,iVal] = max(O);
    predictionList(iPattern) = iVal-1;
end

csvwrite('classifications.csv',predictionList);






