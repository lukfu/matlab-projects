%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Penalty method for minimizing
%
% (x1-1)^2 + 2(x2-2)^2, s.t.
%
% x1^2 + x2^2 - 1 <= 0.
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The values below are suggestions - you may experiment with
% other values of eta and other (increasing) sequences of the
% µ parameter (muValues).

clf
muValues = [1 10 50 100 500 1000 2000]';
eta = 0.00001;
xStart =  [1,2];
gradientTolerance = 1E-6;

x1Values = zeros(size(muValues,1),1);
x2Values = zeros(size(muValues,1),1);
for i = 1:size(muValues,1)
    mu = muValues(i);
    x = RunGradientDescent(xStart,mu,eta,gradientTolerance);
    x1Values(i) = x(1);
    x2Values(i) = x(2);
end
functionValues = (x1Values-1).^2 + 2*(x2Values-2).^2;
constraintFunctionValues = (x1Values.^2 + x2Values.^2) - 1;

%figures
grid on
hold on
plot(muValues,functionValues,'b')
AsymptoticLineYvalue = functionValues(end);
plot([muValues(1),muValues(end)],[AsymptoticLineYvalue,AsymptoticLineYvalue],'r')

%figure details
maxXDist = abs(muValues(end) - muValues(1));
maxYDist = abs(functionValues(end) - functionValues(1));
minXaxis = muValues(1) - 0.1*maxXDist;
maxXaxis = muValues(end) + 0.1*maxXDist;
minYaxis = functionValues(1) - 0.1*maxYDist;
maxYaxis = functionValues(end) + 0.1*maxYDist;

title('f(x*,mu) convergence')
xlabel('mu');
ylabel('f(x*,mu)')
axis([minXaxis,maxXaxis,minYaxis,maxYaxis])
legend('f(x*,mu)','asymptotic line','Location','east')

