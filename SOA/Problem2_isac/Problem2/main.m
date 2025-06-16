clc
clear

%initialize variables
[~,~,nVariable,~,~,~,~,~,~] = InitializePSOVariables();

nParticles = 100;
generations = 100;
shouldPlotAnimation = true;
nMinima = 4;
minimaPositions = zeros(nMinima,nVariable);


minimaFound = 0;
while minimaFound < nMinima
    aMinimumPosition = RunPSO(nParticles,generations,shouldPlotAnimation);
    
    %getMinimaPoints
    shouldAdd = true;
    for iMinima = 1:minimaFound+1
        tmp = minimaPositions(iMinima,:) - aMinimumPosition;
        if norm(tmp) <= 1
            shouldAdd = false;
        end
    end
    if shouldAdd
        minimaPositions(minimaFound+1,:) = aMinimumPosition;
        minimaFound = minimaFound + 1;
    end
    shouldPlotAnimation = false;
end

%plot and display result
PlotGraphAndParticles(minimaPositions);
for iMinima = 1:nMinima
    x = minimaPositions(iMinima,1);
    y = minimaPositions(iMinima,2);
    fXY = Evaluate(minimaPositions(iMinima,:));
    fprintf('x: %0.4f, y: %0.4f, f(x,y): %0.4f\n',x,y,fXY)
end
