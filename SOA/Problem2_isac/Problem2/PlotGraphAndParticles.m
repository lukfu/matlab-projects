
function PlotGraphAndParticles(particlePositions)
    clf
    f = @(x,y) (x.^2+y-11).^2+(x+y.^2-7).^2;
    a=0.01;
    g=@(x,y) log(a+f(x,y));
    x = linspace(-5,5)';
    y = linspace(-5,5)';
    [X,Y] = meshgrid(x,y);
    Z = g(X,Y);
    contour(x,y,Z,80)
    hold on
    if nargin == 1
        plot(particlePositions(:,1),particlePositions(:,2),'.r', 'MarkerSize',24);
    end
    [xMin,xMax,~,~,~,~,~,~,~] = InitializePSOVariables();
    axis([xMin,xMax,xMin,xMax])
    pause(0.05);
end


