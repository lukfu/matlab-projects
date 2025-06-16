function PlotGraphAndParticles(particlePositions)
    clf
    f = @(x,y) (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
    a = 0.01;
    g = @(x,y) log(a + f(x,y));
    x = linspace(-5,5,1000)';
    y = linspace(-5,5,1000)';
    [X,Y] = meshgrid(x,y);
    Z = g(X,Y);
    contourf(X,Y,Z,50)
    hold on
    if nargin == 1
        x1 = particlePositions(:,1);
        x2 = particlePositions(:,2);
        plot(x1,x2,'.r','Markersize',20)
    end
    [xmin,xmax,~,~,~,~,~,~,~] = InitializePSOVariables();
    axis([xmin,xmax,xmin,xmax])
    pause(0.05)
end