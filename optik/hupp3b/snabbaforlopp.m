clc, clf
x = linspace(1,20,39);
%y = [1.73,1.22,0.62,0.33,0.88,1.38,1.76,1.97,1.94,1.76,1.44,0.99,0.5,0.48,1.04,1.39,1.71,1.85,1.84,1.63,1.31,0.92,0.44,0.57,1.06,1.47,1.75,1.84,1.76,1.54,1.21,0.8,0.43,0.65,1.12,1.52,1.71,1.77,1.68];
y = [1.36, 1.75, 2.02, 2.08, 1.89, 1.53, 1.06, 0.51, 0.43, 0.99, 1.46, 1.76, 1.88, 1.85, 1.68, 1.36, 0.90, 0.44, 0.56, 1.06, 1.46, 1.75, 1.85, 1.79, 1.56, 1.21, 0.80, 0.42, 0.68, 1.14, 1.52, 1.72, 1.77, 1.68, 1.45, 1.13, 0.72, 0.48, 0.80];
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
xp = linspace(min(x),max(x),200);

figure(1)
plot(x,y,'xr-',  xp,fit(s,xp), 'k')
grid