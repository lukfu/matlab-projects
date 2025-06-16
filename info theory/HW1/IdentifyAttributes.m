function attributesCollection = IdentifyAttributes(table,nRows,nColumns)

    attributesCollection = {};
    for j = 1:nColumns
        attributes = table{1,j};
        for i = 2:nRows
            s = table{i,j};
            isNewString = abs(sum(strcmp(s,attributes)) - 1);
            if isNewString
                attributes{end+1} = s{:};
            end
        end
        attributesCollection{1,j} = attributes;
    end
end