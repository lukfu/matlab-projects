function entropy = ComputeEntropy(inputCellArray,attributes)

    nAttributes = length(attributes);
    countVector = zeros(1,nAttributes);
    inputCellRows = size(inputCellArray,1);

    if nAttributes == 1
        entropy = 0;
        return
    end

    for i = 1:inputCellRows
        s = inputCellArray{i};
        countVector = countVector + strcmp(s,attributes);
    end
    probabilityVector = countVector/inputCellRows;
    entropy = 0;
    for i = 1:nAttributes
        if probabilityVector(i) ~= 0
            entropy = entropy - probabilityVector(i) * log2(probabilityVector(i));
        else
            entropy = 0;
        end
    end
end