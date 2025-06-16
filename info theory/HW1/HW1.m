clear; clc;

branchPath = {};
table = readtable('id3_data-1.csv');
iteration = 0;
informationGainSum = 0;

tableSize = size(table);
nRows = tableSize(1);
nColumns = tableSize(2);
% target column is the last one, work from home/office
targetColumn = table(:,end);
partitionMapCellArray = {};

attributesCollection = IdentifyAttributes(table,nRows,nColumns);
targetAttributes = attributesCollection(:,end);

originalEntropy = ComputeEntropy(table{:,end},attributesCollection{:,end});
targetEntropy = originalEntropy

% Producing a branch that divides the table according to the ID3 algorithm.
while targetEntropy > 0
    iteration = iteration + 1;
    fprintf('current iteration: %1.0f',iteration)

    % Finding the partition with highest information gain.
    informationGainVector = zeros(1,nColumns-1);
    for j = 1:nColumns-1
        nAttributes = length(attributesCollection{:,j});
        attributeColumn = table{:,j};
        attributes = attributesCollection{:,j};
        if nAttributes == 2
            [informationGain, partitionMapCellArray{1,j},...
                conditionalEntropy] = ComputeIG(attributeColumn,...
                attributes, targetColumn, targetAttributes, targetEntropy);
            informationGainVector(j) = informationGain;
        elseif nAttributes == 3
            % for body temp and crowd at office that have more than 2
            % 4 possible partitions for 3 attributes.
            % Finding and choosing the one with most IG.
            [informationGain, ~, partitionMapCellArray{1,j}, ... 
                conditionalEntropy] = ComputeMaxIG3(attributeColumn,...
                attributes, targetColumn, targetAttributes, targetEntropy);
            informationGainVector(j) = informationGain;
        end
    end

    % Determining the best partitioning.
    [maxInformationGain, index] = max(informationGainVector);
    maxInformationGain
    minConditionalEntropy = targetEntropy - maxInformationGain
    % Picking a subset from the optimal
    % partitioning for the next iteration.

    chosenAttribute = attributesCollection{index}
    branchPath{1,iteration} = chosenAttribute{1};
    chosenPartitionMap = partitionMapCellArray{index};
    % new table
    table = table(chosenPartitionMap{1},:)
    informationGainSum = informationGainSum + maxInformationGain;

    % Computing H(S|A).
    targetEntropy = ComputeEntropy...
        (table{:,end}, attributesCollection{:,end})

    % same steps are taken here as before, but for the new subset table
    tableSize = size(table);
    nRows = tableSize(1);
    nColumns = tableSize(2);
    targetColumn = table{:,end};
    partitionMapCellArray = {};
    % Finding the names of the attributes again.
    attributesCollection = IdentifyAttributes(table,nRows,nColumns);
    targetAttributes = attributesCollection{:,end};
end
