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


muValues = [1 10 30 60 100 1000 2000]';
eta = 0.00001;
xStart =  [1,2];
gradientTolerance = 1E-6;


X1Values = zeros(size(muValues,1),1);
X2Values = zeros(size(muValues,1),1);
for i = 1:size(muValues,1)
    mu = muValues(i);
    x = RunGradientDescent(xStart,mu,eta,gradientTolerance);
    X1Values(i) = x(1);
    X2Values(i) = x(2);
end
functionValues = (X1Values-1).^2 + 2*(X2Values-2).^2;
constraintFunctionValues = (X1Values.^2 + X2Values.^2) - 1;

clc
%result printed
PrintableVector = zeros(size(muValues,1)*5,1);
PrintableVector(1:5:end-4) = muValues;
PrintableVector(2:5:end-3) = X1Values;
PrintableVector(3:5:end-2) = X2Values;
PrintableVector(4:5:end-1) = functionValues;
PrintableVector(5:5:end) = constraintFunctionValues;
fprintf('%12s %12s %12s %12s %12s \n','mu','x_1','x_2','f(x,mu)','g(x)');
fprintf('%12.4f %12.4f %12.4f %12.4f %12.4f\n',PrintableVector);

%figures
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

title('convergence of f(x*,mu)')
xlabel('mu');
ylabel('f(x*,mu)')
axis([minXaxis,maxXaxis,minYaxis,maxYaxis])
legend('f(x*,mu)','asymptotic line','Location','east')




