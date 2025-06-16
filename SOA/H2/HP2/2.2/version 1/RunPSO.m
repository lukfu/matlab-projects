function minima = RunPSO
N = 30; n = 2; % 2d, x,y -> x1,x2
xmin = -5; xmax = 5;
alpha = 1; deltaT = 1;
vmax = (xmax - xmin) / deltaT;
c1 = 2; c2 = 2;
w = 1.4; beta = 0.9997;
x = zeros(N,n);
v = zeros(N,n);
%initialize
for i = 1:N
    for j = 1:n
        r = rand;
        x(i,j) = xmin + r * (xmax - xmin);
    end
end
for i = 1:N
    for j = 1:n
        r = rand;
        v(i,j) = alpha/deltaT * (xmin + r * (xmax - xmin));
    end
end

%evaluate
particleBest = zeros(N,3);
for i = 1:N
    particleBest(i,3) = inf;
end
swarmBest = [0 0 inf];
funcVal = zeros(N,3);
nTrials = 5000;
for l = 1:nTrials
    for k = 1:N
        x1 = x(k,1);
        x2 = x(k,2);
        funcVal(k,1) = x1;
        funcVal(k,2) = x2;
        funcVal(k,3) = FunctionPSO(x1,x2);
    end
    %evaluate
    for m = 1:length(funcVal)
        if funcVal(m,3) < particleBest(m,3)
            particleBest(m,:) = funcVal(m,:);
        end
        if funcVal(m,3) < swarmBest(3)
            swarmBest = funcVal(m,:);
        end
    end

    %update
    for i = 1:N
        for j = 1:n
            q = rand;
            r = rand;
            v(i,j) = w * v(i,j) + c1 * q * ((particleBest(i,j) - x(i,j)) / deltaT) ...
                + c2 * r * ((swarmBest(j)) / deltaT);
            if abs(v(i,j)) > vmax
                v(i,j) = vmax;
            end
            x(i,j) = x(i,j) + v(i,j) * deltaT;
        end
    end
    w = w * beta;
end
minima = swarmBest;
end