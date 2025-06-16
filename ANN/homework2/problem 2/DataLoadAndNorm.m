function [inputTraining,targetTraining,inputValidation,targetValidation] = DataLoadAndNorm(stringTrain,stringValid)
    %import
    dataTrain = load(stringTrain);
    dataValid = load(stringValid);
    %split
    x1Train = dataTrain(:,1);
    x1Valid = dataValid(:,1);
    x2Train = dataTrain(:,2);
    x2Valid = dataValid(:,2);
    %mean
    mean1 = mean(x1Train);
    mean2 = mean(x2Train);
    %std
    std1 = std(x1Train);
    std2 = std(x1Train);
    %normalize
    x1Train = (x1Train - mean1)/std1;
    x1Valid = (x1Valid - mean1)/std1;
    x2Train = (x2Train - mean2)/std2;
    x2Valid = (x2Valid - mean2)/std2;
    %(input1,input2,target)
    inputTraining = transpose([x1Train,x2Train]);
    targetTraining = dataTrain(:,3);

    inputValidation = transpose([x1Valid,x2Valid]);
    targetValidation = dataValid(:,3);
end