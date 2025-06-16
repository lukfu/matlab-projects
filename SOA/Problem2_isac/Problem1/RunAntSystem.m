%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Ant system (AS) for TSP.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
clf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cityLocation = LoadCityLocations();
numberOfCities = length(cityLocation);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numberOfAnts = 100;  %% Changes allowed
alpha = 1.0;        %% Changes allowed
beta = 3.0;         %% Changes allowed
rho = 0.4;          %% Changes allowed
tau0 = 0.1;         %% Changes allowed

targetPathLength = 103; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

range = [0 20 0 20];
tspFigure = InitializeTspPlot(cityLocation, range);
connection = InitializeConnections(cityLocation);
pheromoneLevel = InitializePheromoneLevels(numberOfCities, tau0);
visibility = GetVisibility(cityLocation);                         

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minimumPathLength = inf;

iIteration = 0;
pathCollection = zeros(numberOfAnts, numberOfCities);
pathLengthCollection = zeros(numberOfAnts,1);

while (minimumPathLength > targetPathLength)
 iIteration = iIteration + 1;

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Generate paths:
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 for k = 1:numberOfAnts
  path = GeneratePath(pheromoneLevel, visibility, alpha, beta);  
  pathLength = GetPathLength(path,cityLocation);                  
  if (pathLength < minimumPathLength)
    minimumPathLength = pathLength;
    fprintf('Iteration %d, ant %d: path length = %.5f\n',iIteration,k,minimumPathLength);
    PlotPath(connection,cityLocation,path);
    %-----OWN CODE select minimum path-----------
    minimumPath = path;
  end
  pathCollection(k,:) = path;  
  pathLengthCollection(k) = pathLength; 
 end

 %%%%%%%%%%%%%%%%%%%%%%%%%%
 % Update pheromone levels
 %%%%%%%%%%%%%%%%%%%%%%%%%%

 deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection); 
 pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho);         

end

%update best path if got shorter path
BestResultFound

if minimumPathLength < GetPathLength(path,cityLocation)
    fileID = fopen('BestResultFound.m','wt+');
        path = string(minimumPath);
        stringSum = "path = ["+string(path(1));
        for i=2 : length(path)
            stringSum = stringSum +','+ path(i);
        end
        stringSum = stringSum +'];';
        
        fwrite(fileID,stringSum);
     fclose(fileID);
end






