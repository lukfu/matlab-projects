


%parameters
m=15;
eta=0.005;

[inputTraining,targetTraining,inputValidation,targetValidation] = DataLoadAndNormalize('training_set.csv','validation_set.csv');
[weight,Weight,theta,Theta] = InitializeNetwork(2,m,1);
ndata=size(inputTraining,2);

c=1;
mytry=zeros(100,2);
itry=1;
while c > 0.12

    for i=1:ndata
        ichosen=fix(rand*ndata)+1;
        x=inputTraining(:,ichosen);
        target=targetTraining(ichosen);
        v=GetNeuronValue(weight,x,theta);
        O=GetNeuronValue(Weight,v,Theta);       
        [weight,Weight,theta,Theta] = UpdateWeightsAndTheta(eta,weight,Weight,theta,Theta,x,v,O,target);
    end

     c=ClassificationError(weight,Weight,theta,Theta,inputValidation,targetValidation);
    
     mytry(itry,1)=itry;
     mytry(itry,2)=c;
     itry=itry+1;
 end

plot(mytry(1:end-40,1),mytry(1:end-40,2),'o-')