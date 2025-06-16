
function RunTest(iSlope)
    if nargin <1
        iSlope = 1;
    end
    iDataSet = 3;
    timestep = 0.01;
    
    [~,constantsFFNN] = InitializeGAAndFFNNConstants();
    nIn = constantsFFNN.nIn;
    nHidden = constantsFFNN.nHidden;
    nOut = constantsFFNN.nOut;
    wMax = constantsFFNN.wMax;
    
    
    BestChromosome;

    %run simulation
    [wIH, wHO] = DecodeChromosome(bestChromosome, nIn, nHidden, nOut, wMax);
    [maxFitness,slopeInformation] = SimulateTruckAtSlope(wIH,...
        wHO, timestep, iSlope, iDataSet);
    
    sprintf('max fitness for testRun: %0.4f',maxFitness)
    nValuesStored = slopeInformation.nValuesStored;
    tBData = slopeInformation.allTbValues(1:nValuesStored);
    xData = slopeInformation.allXvalues(1:nValuesStored);
    alphaData = slopeInformation.allAlphaValues(1:nValuesStored);
    vData = slopeInformation.allVelocitiesValues(1:nValuesStored);
    gearData = slopeInformation.allGearValues(1:nValuesStored);
    pressurePedalData = slopeInformation.allPpValues(1:nValuesStored);

    %plot everything
    f = figure;
    movegui(f,[200 100]);
    f.WindowState = 'maximized';
    hold on
    
    subplot(3,2,1)
    plot(xData,tBData,'b');
    xlabel('x');ylabel('Tb')
    
    subplot(3,2,2)
    plot(xData,alphaData,'b');
    xlabel('x');ylabel(texlabel('alpha'),'FontSize',15,...
       'FontWeight','bold')
    
    subplot(3,2,3)
    plot(xData,vData,'b');
    xlabel('x');ylabel('velocity')
   
    subplot(3,2,4)
    plot(xData,gearData,'b');
    xlabel('x');ylabel('Gear')
    
    subplot(3,2,5.5)
    plot(xData,pressurePedalData,'b');
    xlabel('x');ylabel('Pp')
end