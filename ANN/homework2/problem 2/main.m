clc
%input
[inputTrain,targetTrain,inputValid,targetValid] = DataLoadAndNorm('training_set.csv','validation_set.csv');
%initialize constants  
patterns = size(inputTrain,2);
M = 15; %hidden layer size
eta = 0.005;
%initialize weights and thresholds
[w1Mat,w2Mat,th1,th2] = InitializeNetwork(2,M,1);

%while error C is below 0.12
C = 1;
myTrys = zeros(1000,2);
iteration = 0;
while C > 0.12
    iteration = iteration + 1;
    for i = 1:patterns
        iChosen = fix(rand*patterns) + 1;
        target = targetTrain(iChosen);
        X = inputTrain(:,iChosen);
        V = GetNeuronValue(X,w1Mat,th1);
        O = GetNeuronValue(V,w2Mat,th2);
        [w1Mat,w2Mat,th1,th2] = UpdateWeightsAndTheta(eta,w1Mat,w2Mat,th1,th2,X,V,O,target);
    end
    C = ClassificationError(w1Mat,w2Mat,th1,th2,inputValid,targetValid);
    myTrys(iteration,1) = iteration;
    myTrys(iteration,2) = C;
    if iteration == 1000
        break
    end
end
C = ClassificationError(w1Mat,w2Mat,th1,th2,inputValid,targetValid,'plot')

%write csv files for w1, w2, t1, t2
% writematrix(w1Mat,'w1.csv')
% writematrix(w2Mat,'w2.csv')
% writematrix(th1,'t1.csv')
% writematrix(th2,'t2.csv')