
%Load Data
[xTrain,tTrain, xValid,tValid,xTest,tTest] = LoadMNIST(3);

xTrain = reshape(double(xTrain),28*28,5*10^4)/255;
xValid = reshape(double(xValid),28*28,1*10^4)/255;
xTest = reshape(double(xTest),28*28,1*10^4)/255;

%% Train network
epochs = 1500;
bottleneckSize = 2;
[net, tr, net_encode,net_decode]  = TrainNetworkFunction(epochs,bottleneckSize,xTrain,xValid);
epochs = 1500;
bottleneckSize = 4;
[net2, tr2, net_encode2,net_decode2]  = TrainNetworkFunction(epochs,bottleneckSize,xTrain,xValid);
save('nets','net','net2','tr','tr2','net_encode','net_decode','net_encode2','net_decode2');
%% Analysis
%% Montage
load('nets.mat')
MontagePlot(xTest,tTest,net_encode,net_decode);
MontagePlot(xTest,tTest,net_encode2,net_decode2);
%% AutoEncoder1:ScatterPlot, visualization of decision line
numbers=[0,1];
ik = randi(size(xTest,2)-1000);
PlotScatter(numbers,net_encode,xTest,tTest,true,ik);
xlabel('x')
ylabel('y')

imageSet = {};
  x = linspace(0,15,15);
  y = linspace(0,15,15);
  K=zeros(length(y),length(x));
for j = 1:length(y)
    for i = 1:length(x)
        point=[x(i);y(end+1-j)];
        img = reshape(net_decode.predict(point),[28,28]);
        imageSet = [imageSet,img];
    end
end
figure;
montage(imageSet,'Size',[length(x),length(y)]);
%% autoencoder 2: Test Decision Boundary and scatter plot
numbers=[0,1,9];
scatter4d(numbers,net_encode2,xTest,tTest,false,ik);
 
points=zeros(4,3);
for i=1:length(numbers)
    targetNumber = (double(tTest)-1)==numbers(i);
    vectors = net_encode2.predict(xTest(:,targetNumber));
    vectors = mean(vectors')';
    a = vectors;
    [~,a1] = max(a);a(a1)=-100;
    [~,a2] = max(a);a(a2)=-100;
    [~,a3] = max(a);a(a3)=-100;
    [~,a4] = max(a);
    vectors(a1)=4;
    vectors(a2)=3;
    vectors(a3)=2;
    vectors(a4)=1;
    points(:,i)=vectors;
end
%%
for i=1:3
imshow(reshape(net_decode2.predict(points(:,i)*4),[28,28]))
pause(0.5)
end
%%
numbers = double(tTest)-1;
imageSet = {};
v=perms([1,2,3,4]*4)';
for i=1:size(v,2)
    img1 = reshape(net_decode2.predict(v(:,i)),[28,28]);
    imageSet = [imageSet,img1];
end
montage(imageSet,'Size',[5,4]);





