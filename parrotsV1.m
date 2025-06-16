% Simulation of Complex systems Project Parrot
% Arthur von Kaenel
% Matlab, 23rd of November 2022

%% Header
clc
clear 
close all hidden

%% Parameters
m = 100;        % Size of the physical interaction map
N = m^2;        % number of Agents
totalTime = 100;

%% Initialization
%mxm matrix of agents with qi qualities and a belief
agents = InitzializeAgents(m);
%agents = InitzializeAgentsHalves(m);
digitalConnections = zeros(N);

%% Main
displayB = zeros(m);
displayQ = zeros(m,m,3);
for i = 1:m
    for j = 1:m
        displayB(i,j) = agents(i,j).belief;
        displayQ(i,j,1) = agents(i,j).q1;
        displayQ(i,j,2) = agents(i,j).q2;
        displayQ(i,j,3) = agents(i,j).q3;
    end
end
figure(1);
imagesc(displayB)
axis image
title('time = 0')

figure(2);
imagesc(displayQ)
axis image
title('time = 0')
%waitforbuttonpress
pause(1)

for time = 1:totalTime
    newAgents = agents;
    for i = 1:m
        for j = 1:m
            neighbours = FindMoorNeighbours(m,[i,j]);
            groupBelief = ComputeGroupBelief(agents,neighbours,[i,j]);
            newAgents(i,j).belief = groupBelief;
        end
    end
    
    agents = newAgents;
    
    for i = 1:m
        for j = 1:m
            displayB(i,j) = agents(i,j).belief;
            displayQ(i,j,1) = agents(i,j).q1;
            displayQ(i,j,2) = agents(i,j).q2;
            displayQ(i,j,3) = agents(i,j).q3;
        end
    end
    figure(1)
    imagesc(displayB)
    title(['time = ' num2str(time)])
    axis image
    %waitforbuttonpress
    %pause(0.05)
end
%% Functions

% This function initializes the agent matrix. The qualities take a real
% random value between 0 and 1 and a boolean belief of 0 or 1.
% Inputs    m       Size of the agent matrix
% Outputs   agents  Initialized agent matrix
function agents = InitzializeAgents(m)
    agents = repmat(struct('q1',0,'q2',0,'q3',0,'belief',0),m,m); 
    for i = 1:m
        for j = 1:m
            r = rand(1,3);
            beliefValue = floor(2*rand);
            agents(i,j).q1 = r(1);
            agents(i,j).q2 = r(2);
            agents(i,j).q3 = r(3);
            agents(i,j).belief = beliefValue;
        end
    end
end

% This function initializes the agent matrix. The qualities take a real
% random value between 0 and 1 and a boolean belief of 0 or 1.
% Inputs    m       Size of the agent matrix
% Outputs   agents  Initialized agent matrix
function agents = InitzializeAgentsHalves(m)
    agents = repmat(struct('q1',0,'q2',0,'q3',0,'belief',0),m,m); 
    for i = 1:m
        for j = 1:m
            if(i<m/2)
                r = 0.25*rand(1,3) + 0.125;
                beliefValue = floor(2*rand);
                agents(i,j).q1 = r(1);
                agents(i,j).q2 = r(2);
                agents(i,j).q3 = r(3);
                agents(i,j).belief = beliefValue;
            else
                r = 0.25*rand(1,3)+0.625;
                beliefValue = floor(2*rand);
                agents(i,j).q1 = r(1);
                agents(i,j).q2 = r(2);
                agents(i,j).q3 = r(3);
                agents(i,j).belief = beliefValue;
            end
        end
    end
end



function indices = FindMoorNeighbours(m,position)
    indices = zeros(9,2);

    left = [1 4 7];
    bottom = [7 8 9];
    right = [3 6 9];
    top = [1 2 3];
    smallSides = [top; left]';
    bigSides = [bottom; right]';
    
    for j = 1:3
        for k = 1:3
            correction = [j-2 k-2];
            indices((j-1)*3+k,:) = position + correction;
        end
    end
    for i = 1:2
        switch position(i)
            case 1
                indices(smallSides(:,i),i) = m;
            case m
                indices(bigSides(:,i),i) = 1;
        end
    end
    indices(5,:) = [];
    %indices = sub2ind([m m],indices(:,1),indices(:,2));
end


function groupBelief = ComputeGroupBelief(agents,neighbours,position)
    groupBelief = 0;

    for i = 1:8
        dQ1 = agents(position(1),position(2)).q1 - agents(neighbours(i,1),neighbours(i,2)).q1;
        dQ2 = agents(position(1),position(2)).q2 - agents(neighbours(i,1),neighbours(i,2)).q2;
        dQ3 = agents(position(1),position(2)).q3 - agents(neighbours(i,1),neighbours(i,2)).q3;
        weight = (sqrt(dQ1^2 + dQ2^2 + dQ3^2) )/sqrt(3);

        if(rand>weight)
            addedBelief = agents(neighbours(i,1),neighbours(i,2)).belief;
        else
            addedBelief = agents(position(1),position(2)).belief;
        end

        groupBelief = groupBelief + addedBelief;
    end
    groupBelief = round(groupBelief/8);
end
