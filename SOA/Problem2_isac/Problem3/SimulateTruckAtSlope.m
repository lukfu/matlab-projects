
function [fitness,SlopeDataSimulated] = SimulateTruckAtSlope(wIH, wHO, timestep, iSlope, iDataSet)
    
    %initialize output
    SlopeDataSimulated = struct;
    allTbValues = zeros(10^4,1);
    allXvalues = zeros(10^4,1);
    allVelocitiesValues = zeros(10^4,1);
    allGearValues = zeros(10^4,1);
    allPpValues = zeros(10^4,1);
    allAlphaValues = zeros(10^4,1);
    nValuesStored = 0;
    

    %initiate constants
    [temperatureMax,~,~,~,temperatureAmbient,...
    ~,vMax,vMin,alphaMax,alphaMin,slopeLength] = InitiateTruckSlopeVariables();
    [temperatureBrake,x,v,gear,deltaTb] = InitiateTruckStartCondition(temperatureAmbient);

    
    activationFunction = @(x) 1./(1+exp(-2*x));
    biasIH = wIH(:,end);
    wIH = wIH(:,1:end-1);
    biasHO = wHO(:,end);
    wHO = wHO(:,1:end-1);    
    
    gearTimeKeeper = 0;
    conditions = true;
    alpha = GetSlopeAngle(x, iSlope, iDataSet);
    while conditions
        %fix input to neuralNet
        velocityInput = v/vMax;
        alphaInput = alpha/alphaMax;
        breakTemperatureInput = temperatureBrake/temperatureMax;

        %run Network and get new OutPut
        I = [velocityInput; alphaInput; breakTemperatureInput];
        H = activationFunction(wIH*I+biasIH);
        O = activationFunction(wHO*H+biasHO);
        pressurePedal = O(1);
       
        if gearTimeKeeper >= 2
            deltaGear = round(2*O(2)-1);
            gear = gear + deltaGear; 
            if gear >= 10
                gear = 10;
            elseif gear <= 1
                gear = 1;
            end
            if deltaGear ~=0
                gearTimeKeeper = 0;
            end
        end
        gearTimeKeeper = gearTimeKeeper + timestep;
        
        %add to stored LastSlopeInformation
        xLength = length(allXvalues);
        if nValuesStored == length(allXvalues)-10
            allTbValues = [allTbValues; zeros(xLength,1)];
            allXvalues = [allXvalues; zeros(xLength,1)];
            allVelocitiesValues = [allVelocitiesValues; zeros(xLength,1)];
            allGearValues = [allGearValues; zeros(xLength,1)];
            allPpValues = [allPpValues; zeros(xLength,1)];
            allAlphaValues = [allAlphaValues; zeros(xLength,1)];
        end
        nValuesStored = nValuesStored + 1;
        allTbValues(nValuesStored) = temperatureBrake;
        allXvalues(nValuesStored) = x;
        allVelocitiesValues(nValuesStored) = v;
        allGearValues(nValuesStored) = gear;
        allPpValues(nValuesStored) = pressurePedal;
        allAlphaValues(nValuesStored) = alpha;
        
        %update truckCondition
        [x,v,temperatureBrake,deltaTb] = UpdateTruckCondition(temperatureBrake,x,v,gear,...
            pressurePedal,deltaTb,alpha,timestep);

        alpha = GetSlopeAngle(x, iSlope, iDataSet);  

        %update loop-conditions
        condition1 = x < slopeLength;
        condition2 = alpha  < alphaMax;
        condition3 = alpha  > alphaMin;
        condition4 = v < vMax;
        condition5 = v > vMin;
        condition6 = temperatureBrake > temperatureAmbient;
        condition7 = temperatureBrake < temperatureMax;
        conditions = condition1 && condition2 && condition3 && condition4;
        conditions = conditions && condition5 && condition6 && condition7;
    end
    %TODO got many fitness = 0, check if it's an error
    fitness = x * sum(allVelocitiesValues)/nValuesStored;

    %add values to struct
    SlopeDataSimulated.allTbValues = allTbValues;
    SlopeDataSimulated.allXvalues = allXvalues;
    SlopeDataSimulated.allAlphaValues = allAlphaValues;
    SlopeDataSimulated.allVelocitiesValues = allVelocitiesValues;
    SlopeDataSimulated.allGearValues = allGearValues;
    SlopeDataSimulated.allPpValues = allPpValues;
    SlopeDataSimulated.nValuesStored = nValuesStored;
end
