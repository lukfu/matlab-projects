clear; close all; clc

% Set default plot properties - this works for most plots, sometimes you
% still have to adjust some parameters manually. Once you run this you have
% to restart matlab if you want to go back to your default plot look
set(0, 'DefaultLineLineWidth', 1.5);
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')
set(0, 'DefaultAxesFontSize',15)

% create some data
a = rand(10,1);
b = rand(10,1);
xVec = 1:10;


% create a figure, this way we can save and position it automatically
fig1 = figure('Name', 'Plot1', 'Position', [117   677   516   358]);
% do two errorbars and shift them a bit so that we can see each bar
errorbar(xVec-0.1, a, ones(10,1), -ones(10,1), 'LineWidth', 1.5);
hold on
errorbar(xVec+0.1, b, ones(10,1), -ones(10,1), 'LineWidth', 1.5);
xlabel('x')
ylabel('y')
xticks(xVec)
xlim([min(xVec) - 0.5, max(xVec) + 0.5 ])
legend('A', 'B', 'Location', 'best')
grid on
grid minor


% get(gcf, 'Position') - you can use this line to figure out the position
% of a figure after you adjusted it manually

% Save the figure as vectorized eps file - if you want to change the path
% where matlab saves the figure you can replace 'plot1.eps' by something
% like 'users/leon/HRSV3/figures/plot1.eps'
exportgraphics(fig1,'plot1.eps','ContentType', 'vector')


%% save/load all data in a loop

for dataIdx = 1 : 3
    save(['a' num2str(dataIdx)], 'a')
    %pause(1)
    data.(['a' num2str(dataIdx)]) = load(['a' num2str(dataIdx) '.mat']);
    disp(dataIdx)
end

% you can also create a string vector that contains different file and variable names and
% use the loop index to loop through those
myFileNames = ["data1", "someOtherData", "dataFinalFinal"];
myVariableNames = ["a", "b", "xVec"];
for dataIdx = 1 : length(myFileNames)
    save(myFileNames(dataIdx), myVariableNames(dataIdx))

end

