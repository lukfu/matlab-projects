
%visualizes pattern
function p = PlotPattern(x,widthPx)
    xMatrix = zeros(length(x)/widthPx,widthPx);
    for i = 1:length(x)/widthPx
        xMatrix(i,:) = x(i*widthPx-(widthPx-1):i*widthPx);
    end
    imagesc(-xMatrix)
    colormap(gray)
end