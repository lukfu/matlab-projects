
function [fitness] = EvaluateIndividual(wIH, wHO, timestep, iDataSet)

    %initiate constants
    [temperatureMax,~,~,~,temperatureAmbient,...
    ~,vMax,vMin,alphaMax,alphaMin,slopeLength] = InitiateTruckSlopeVariables();
    
    activationFunction = @(x) 1./(1+exp(-2*x));

    biasIH = wIH(:,end);
    wIH = wIH(:,1:end-1);
    biasHO = wHO(:,end);
    wHO = wHO(:,1:end-1);

    if iDataSet == 1
        nSlopes = 10;
    elseif iDataSet == 2
        nSlopes = 5;
    else
        nSlopes = 5;
    end
    
    %simluate truck going down slope
    fitness = zeros(nSlopes,1);
    for iSlope = 1:nSlopes
        conditions = true;
        [temperatureBrake,x,v,gear,deltaTb] = InitiateTruckStartCondition(temperatureAmbient);
        alpha = GetSlopeAngle(x, iSlope, iDataSet);
        sumOfVelocity = 0;
        nValuesStored = 0;
        gearTimeKeeper = 0;
        while conditions
            velocityInput = v/vMax;
            alphaInput = alpha/alphaMax;
            breakTemperatureInput = temperatureBrake/temperatureMax;

            %run Network and get new OutPut
            input = [velocityInput; alphaInput; breakTemperatureInput];
            hiddenNeuron = activationFunction(wIH*input+biasIH);
            output = activationFunction(wHO*hiddenNeuron+biasHO);
            pressurePedal = output(1);
           
            if gearTimeKeeper >= 2
                deltaGear = round(2*output(2)-1);
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
            
            nValuesStored = nValuesStored + 1;
            sumOfVelocity = sumOfVelocity + v; 
            
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
        fitness(iSlope) = (sumOfVelocity/nValuesStored)*x;
    end
    fitness = mean(fitness);
end
