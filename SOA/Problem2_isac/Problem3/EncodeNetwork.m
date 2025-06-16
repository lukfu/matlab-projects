function chromosome = EncodeNetwork(wIH, wHO, wMax)
    wIH = (wIH+wMax) / (2*wMax);
    wHO = (wHO+wMax) / (2*wMax);
    iChromosome = 1; 
    chromosome = size(wIH,1)*size(wIH,2) + size(wHO,1)*size(wHO,2);
    for iRow = 1:size(wIH,1)
        for iColumn = 1:size(wIH,2)
            chromosome(iChromosome) = wIH(iRow,iColumn);
            iChromosome =  iChromosome +1; 
        end
    end
    
    for iRow = 1:size(wHO,1)
        for iColumn = 1:size(wHO,2)
            chromosome(iChromosome) = wHO(iRow,iColumn);
            iChromosome =  iChromosome +1; 
        end
    end
end