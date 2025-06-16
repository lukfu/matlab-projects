function [wIH, wHO] = DecodeChromosome(chromosome, nIn, nHidden, nOut, wMax);

    wIH = zeros(nHidden,nIn+1);
    wHO = zeros(nOut,nHidden+1);
    chromosome = 2*wMax*chromosome-wMax;

    iChromosome = 1; 
    for iRow = 1:size(wIH,1)
        for iColumn = 1:size(wIH,2)
            wIH(iRow,iColumn) = chromosome(iChromosome);
            iChromosome =  iChromosome +1; 
        end
    end

    for iRow = 1:size(wHO,1)
        for iColumn = 1:size(wHO,2)
            wHO(iRow,iColumn) = chromosome(iChromosome);
            iChromosome =  iChromosome +1; 
        end
    end
end
