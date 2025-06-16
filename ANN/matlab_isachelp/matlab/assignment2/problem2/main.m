
[inputTtrain,targetTrain,inputValidation,targetValidation] = DataLoadAndNormalize('training_set.csv','validation_set.csv');
pPatterns = size(inputTtrain,2);
%Parameter TO be tested
M=15;
eta=0.005;

%initialize weights/threshold
[weightMatrix1,weightMatrix2,theta1,theta2] = InitializeNetwork(2,M,1);

C=1;
while C>0.12 
    for iPattern=1:pPatterns
        indexChosen=fix(rand*pPatterns)+1;
        target = targetTrain(indexChosen);
        X = inputTtrain(:,indexChosen);
        V = GetNeuronValue(weightMatrix1,X,theta1);
        O = GetNeuronValue(weightMatrix2,V,theta2);
        [weightMatrix1,weightMatrix2,theta1,theta2] = UpdateWeightsAndTheta(eta,weightMatrix1,weightMatrix2...
            ,theta1,theta2,X,V,O,target);
    end
    C = ClassificationError(weightMatrix1,weightMatrix2,theta1,theta2,inputValidation,targetValidation);
end
C = ClassificationError(weightMatrix1,weightMatrix2,theta1,theta2,inputValidation,targetValidation,'plot')

% write to file
if C <0.12 
    csvwrite('w1.csv',weightMatrix1);
    csvwrite('w2.csv',weightMatrix2);
    csvwrite('t1.csv',theta1);
    csvwrite('t2.csv',theta2);
end