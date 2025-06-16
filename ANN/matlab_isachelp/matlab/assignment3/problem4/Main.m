clear
clf
clc

%variables
xTrain = readtable('training-set.csv');
xTest = readtable('test-set-8.csv');
xTrain = table2array(xTrain);
xTest = table2array(xTest);
nInput = size(xTrain,1);
nReservoir = 500;
kRidge = 0.01;
[wIn,wReservoir] = InitializeNetwork(nInput,nReservoir); 

TimeStepsPredict = 500;

wOut = TrainReservoir(wIn,wReservoir,xTrain,kRidge);
OutputPredict = predict(wIn,wReservoir,...
    wOut,xTest,TimeStepsPredict);

hold on
plot3(OutputPredict(1,:),...
      OutputPredict(2,:),...
      OutputPredict(3,:),'b','LineWidth',0.1);
  
plot3(xTest(1,:),...
      xTest(2,:),...
      xTest(3,:),'r');
view(3)
legend('testData','prediction')
%% plot 2d
clf
hold on

plot(xTest(2,:),'b')
l1 = length(xTest(2,:));
l2 = length(OutputPredict(2,:));
plot(l1:l1+l2-1,OutputPredict(2,:),'r')



%%
csvwrite('prediction.csv',OutputPredict(2,:)');
    
%%
s=10;
r=28;
b=8/3;

syms x y z
cond1= s*(y-x)==0;
cond2 = -x*z+r*x-y==0;
cond3= x*y-b*z==0;
sol = solve([cond1,cond2,cond3],x,y,z);
sol.x(3)

x=sqrt(b*(r-1));  y=x;   z=r-1;
a=[-s s 0;r-z -1 -x; y x -b];
det(a)



