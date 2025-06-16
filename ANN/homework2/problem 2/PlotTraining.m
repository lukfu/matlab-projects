function PlotTraining(input,output,target)
    pointSize = 10;
    subplot(1,2,1)
    scatter(input(1,:),input(2,:),pointSize, output);
    subplot(1,2,2)
    scatter(input(1,:),input(2,:),pointSize, target);
    sgtitle('Output vs target')
end