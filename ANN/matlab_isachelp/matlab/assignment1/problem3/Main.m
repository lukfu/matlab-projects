%Main code
N = 200;
p = 45;
T = 2*10^5;
noise_beta = 2;

%for loop to average m1 to be implemented
mAverage = 0;
averageTrial = 100;
for i = 1:averageTrial
    mAverage = mAverage + GetOrderParameter(N,p,T,noise_beta);
end
round(mAverage/averageTrial,3)










