% Simulation of Complex systems Project Parrot
% Arthur von Kaenel
% Matlab, 23rd of November 2022

%% Header
clc
clear 
close all hidden

%% Parameters
m = 30;                             % Size of the physical interaction map
N = m^2;                            % number of Agents
deltaQualInfluence = 0;           % Amount of quality change based on neighbours
influenceProbability = 0;         % Probability of quality change based on neighbours
deltaQualSpontaneous = 0;         % Amount of spontaneous quality change
spontaneousProbability = 0;     % Probability of Sponaneus quality change
fitInProbability = 1;             % Probability of belief change based on neighbours
totalTime = 1000;

%% Initialization
% mxm matrix of agents with qi qualities and a belief
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
subplot(1,2,1)
dispB = imagesc(displayB);
axis image

subplot(1,2,2)
dispQ = image(displayQ);
axis image
titleText = sgtitle('time = 0');

for time = 1:totalTime
    disp(time)
    newAgents = agents;
    for i = 1:m
        for j = 1:m
            neighbours = FindMoorNeighbours(m,[i,j]);
            groupBelief = ComputeGroupBelief(agents,neighbours,[i,j]);
            if(rand<fitInProbability)
                newAgents(i,j).belief = groupBelief;
            end
        end
    end
    
    agents = newAgents;

    for i = 1:m
        for j = 1:m
            neighbours = FindMoorNeighbours(m,[i,j]);
            newAgents(i,j) = UpdateQualities(agents,neighbours,[i,j],deltaQualInfluence,...
                                        influenceProbability, deltaQualSpontaneous,...
                                        spontaneousProbability);
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
    dispB.CData = displayB;
    dispQ.CData = displayQ;
    titleText.String = ['time = ' num2str(time)];
    drawnow
    pause
end
%% Functions

% This functioninitializes the agent matrix. The qualities take a real
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

% This functioninitializes the agent matrix. The qualities are seperated
% into two halves that have similar values, while beliefs are either 1 or 0
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


% This function finds the moore neighbours with periodic boundaries
% centered on position of a size mxm matrix
% Inputs    m       Size of the agent matrix
% Outputs   agents  Initialized agent matrix
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


% This function finds the equalivalent group belief around the agent in
% position. More similar agents have a higher persuation quality,
% calculated by the norm of the difference vector of all qualities.
% Inputs    agents          matrix of agents
%           neighbours      indices of moore neighbours
%           position        center agent
% Outputs   groupBelief     weighted group belief
function groupBelief = ComputeGroupBelief(agents,neighbours,position)
    groupBelief = 0;
    currentAgent = agents(position(1),position(2));

    for i = 1:8
        neighbourAgent = agents(neighbours(i,1),neighbours(i,2));
        dQ1 = currentAgent.q1 - neighbourAgent.q1;
        dQ2 = currentAgent.q2 - neighbourAgent.q2;
        dQ3 = currentAgent.q3 - neighbourAgent.q3;
        weight = (sqrt(dQ1^2 + dQ2^2 + dQ3^2) )/sqrt(3);

        if(rand>weight)
            addedBelief = agents(neighbours(i,1),neighbours(i,2)).belief;
        else
            addedBelief = agents(position(1),position(2)).belief;
        end

        groupBelief = groupBelief + addedBelief;
    end
    groupBelief = groupBelief/8;
    if(groupBelief == 0.5)
        groupBelief = currentAgent.belief;
    else
        groupBelief = round(groupBelief);
    end
end


% This function finds the equalivalent group belief around the agent in
% position. More similar agents have a higher persuation quality,
% calculated by the norm of the difference vector of all qualities.
% Inputs    agents          matrix of agents
%           neighbours      indices of moore neighbours
%           position        center agent
% Outputs   groupBelief     weighted group belief
function newAgent = UpdateQualities(agents,neighbours,position,deltaQualInfluence,...
                                    influenceProbability, deltaQualSpontaneous,...
                                    spontaneousProbability)
    q1Avg = 0;
    q2Avg = 0;
    q3Avg = 0;
    nAdded = 0;
    centerAgent = agents(position(1),position(2));
    newAgent = centerAgent;
    for i = 1:8
        neighbourAgent = agents(neighbours(i,1),neighbours(i,2));
        if(centerAgent.belief==neighbourAgent.belief)
            q1Avg = q1Avg + neighbourAgent.q1;
            q2Avg = q2Avg + neighbourAgent.q2;
            q3Avg = q3Avg + neighbourAgent.q3;
            nAdded = nAdded + 1;
        end
    end
    if(nAdded==0)
        return
    end
    dQ1 = q1Avg/nAdded - centerAgent.q1;
    dQ2 = q2Avg/nAdded - centerAgent.q2;
    dQ3 = q3Avg/nAdded - centerAgent.q3;
    
    r = rand(1,2);
    if(r(1)<influenceProbability)
        newAgent.q1 = centerAgent.q1 + deltaQualInfluence*dQ1;
        newAgent.q2 = centerAgent.q2 + deltaQualInfluence*dQ2;
        newAgent.q3 = centerAgent.q3 + deltaQualInfluence*dQ3;
    end

    if(r(2)<spontaneousProbability)
        rSpont = 2*rand(1,3)-1;
        newAgent.q1 = (rSpont(1)*deltaQualSpontaneous + 1)*newAgent.q1;
        if(newAgent.q1<0)
            newAgent.q1 = 0;
        elseif(newAgent.q1>1)
            newAgent.q1 = 1;
        end

        newAgent.q2 = (rSpont(2)*deltaQualSpontaneous + 1)*newAgent.q2;
        if(newAgent.q2<0)
            newAgent.q2 = 0;
        elseif(newAgent.q2>1)
            newAgent.q2 = 1;
        end

        newAgent.q3 = (rSpont(3)*deltaQualSpontaneous + 1)*newAgent.q3;
        if(newAgent.q3<0)
            newAgent.q3 = 0;
        elseif(newAgent.q3>1)
            newAgent.q3 = 1;
        end
    end
end
