clear;clc;clf;

% initialize variables
xTrain = load('training-set.csv');
xTest = load('test-set-5.csv');
nInput = size(xTrain,1);
nReservoir = 500;
kRidge = 0.01;
[wIn,wReservoir] = InitializeNetwork(nInput,nReservoir);

predictTimeStep = 500;

wOut = TrainReservoir(wIn,wReservoir,kRidge,xTrain);
predictionOutput = Predict(wIn,wReservoir,xTest,wOut,predictTimeStep);
hold on
grid on
plot3(predictionOutput(1,:),predictionOutput(2,:),predictionOutput(3,:), ...
    'b',LineWidth=0.01)
plot3(xTest(1,:),xTest(2,:),xTest(3,:),'r')
v = [-2 3 2];
[caz,cel] = view(v);
legend('Test Data','Prediction')
%% csv write
writematrix(predictionOutput(2,:),'prediction.csv')