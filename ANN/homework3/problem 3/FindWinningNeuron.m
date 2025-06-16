function [i0,j0] = FindWinningNeuron(pattern,weights)
    % weights = 40x40x4, pattern = 1x1x4, outputdim = 2
    distance = zeros(40,40);
    for i = 1:size(weights,1)
        for j = 1:size(weights,2)
            distance(i,j) = sqrt(sum((weights(i,j,:) - pattern).^2));
        end
    end
    minDistance = min(min(distance));
    [i0,j0] = find(distance==minDistance);
end