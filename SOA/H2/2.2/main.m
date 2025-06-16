clc; clear;

[~,~,~,nVariable,~,~,~,~,~] = InitializePSOVariables();

nParticles = 40;
nGenerations = 100;
plotAnimation = true;
nMinima = 4;
minimumPositions = zeros(nMinima,nVariable);

minimaFound = 0;
while minimaFound < nMinima
    aMinPosition = RunPSO(nParticles,nGenerations,plotAnimation);

    addMinima = true;
    for iMinima = 1:minimaFound+1
        diff = aMinPosition - minimumPositions(iMinima,:);
        if norm(diff) <= 1
            addMinima = false;
        end
    end
    if addMinima
        minimumPositions(minimaFound+1,:) = aMinPosition;
        minimaFound = minimaFound + 1;
    end
    plotAnimation = false;
end

PlotGraphAndParticles(minimumPositions)
for iMinima = 1:nMinima
    x = minimumPositions(iMinima,1);
    y = minimumPositions(iMinima,2);
    fXY = Evaluate(minimumPositions(iMinima,:));
    fprintf('x: %0.4f, y: %0.4f, f(x,y): %0.4f\n',x,y,fXY)
end