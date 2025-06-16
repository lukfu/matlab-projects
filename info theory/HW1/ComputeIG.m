function [informationGain, attributeLocationCollection, ...
    conditionalEntropy] = ComputeIG(attributeColumn, attributes, ...
    targetColumn, targetAttributes, targetEntropy)

    nRows = size(targetColumn,1);
    conditionalEntropy = 0;
    nAttributes = length(attributes);
    attributeLocationCollection = {};

    for k = 1:nAttributes
        attribute = attributes{1,k};
        attributeLocations = ismember(attributeColumn,attribute);
        targetPartition = targetColumn(attributeLocations,1);
        attributeLocationCollection{1,k} = attributeLocations;
        targetPartitionEntropy = ComputeEntropy(targetPartition,...
            targetAttributes);
        proportion = size(targetPartition,1)/nRows;
        conditionalEntropy = conditionalEntropy + ...
            proportion * targetPartitionEntropy;
    end

    informationGain = targetEntropy - conditionalEntropy;
end
