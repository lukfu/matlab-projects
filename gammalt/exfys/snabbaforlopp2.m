clc, clf
f = linspace(1,20,39);
x = [0, 1.18, 1.68, 3.24, 3.64, 3.92, 4.85, 5.38];
y = [2.05, 1.9, 1.75, 1.05, 0.85, 0.7, 0.2, 0.5];
yu = max(y);
yl = min(y);
yr = (yu-yl);                               % Range of ‘y’
yz = y-yu+(yr/2);
zx = x(yz .* circshift(yz,[0 1]) <= 0);     % Find zero-crossings
per = 2*mean(diff(zx));                     % Estimate period
ym = mean(y);                               % Estimate offset
fit = @(b,x)  b(1).*(sin(2*pi*x./b(2) + 2*pi/b(3))) + b(4);    % Function to fit
fcn = @(b) sum((fit(b,x) - y).^2);                              % Least-Squares cost function
s = fminsearch(fcn, [yr;  per;  -1;  ym])                       % Minimise Least-Squares
xp = linspace(min(x),max(x));
figure(1)
plot(x,y,'xr-',  xp,fit(s,xp), 'k')
grid