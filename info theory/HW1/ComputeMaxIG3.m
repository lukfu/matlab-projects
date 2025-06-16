function [informationGain, bestPartition, partitionMap, ...
    conditionalEntropy] = ComputeMaxIG3(attributesColumn, attributes,...
    targetColumn, targetAttributes, originalEntropy)

    informationGain = 0;
    for mPartition = 1:4
        pair = {};
        if mPartition == 1
            pair{1,1} = attributes{1,1};
            pair{1,2} = attributes{1,2};
            attributeSplit{1,1} = pair;
            attributeSplit{1,2} = attributes{1,3};
        elseif mPartition == 2
            pair{1,1} = attributes{1,2};
            pair{1,2} = attributes{1,3};
            attributeSplit{1,1} = pair;
            attributeSplit{1,2} = attributes{1,1};
        elseif mPartition == 3
            pair{1,1} = attributes{1,3};
            pair{1,2} = attributes{1,1};
            attributeSplit{1,1} = pair;
            attributeSplit{1,2} = attributes{1,2};
        elseif mPartition == 4
            attributeSplit = attributes;
        end
    end
        [newIG, tempLocations, conditionalEntropy] = ComputeIG(attributesColumn, ...
            attributeSplit, targetColumn, targetAttributes, originalEntropy);

        if informationGain < newIG
            informationGain = newIG;
            bestPartition = attributeSplit;
            partitionMap = tempLocations;
        end
end