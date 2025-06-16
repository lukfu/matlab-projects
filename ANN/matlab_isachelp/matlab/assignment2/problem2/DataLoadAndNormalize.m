

function [inputTraining,targetTraining,inputValidation,targetValidation] = DataLoadAndNormalize(stringTrain,stringValid)
    %import excel data
    data1 = load(stringTrain);
    data2 = load(stringValid);
    x1train = data1(:,1);
    x2train = data1(:,2);
    x1valid = data2(:,1);
    x2valid = data2(:,2);

    mean1 = mean(x1train);
    mean2 = mean(x2train);
    std1 = std(x1train);
    std2 = std(x2train);
    
    %normalize data
    x1train = (x1train - mean1)/std1; 
    x2train = (x2train - mean2)/std2;

    x1valid = (x1valid - mean1)/std1; 
    x2valid = (x2valid - mean2)/std2;

    inputTraining = transpose([x1train,x2train]);
    targetTraining = data1(:,3);

    inputValidation = transpose([x1valid,x2valid]);
    targetValidation = data2(:,3);
end