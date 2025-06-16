%plot(VarName1,VarName2)

% E1 = 0.8648 MeV
% E2 = 0.9933 MeV
% E3 = 2.5842 MeV

clf

VarName1 = data(:,1);
VarName2 = data(:,2);

rangemin1 = 1250;
rangemax1 = 1300;
[peak1,fit1,fitrange1] = fitpeak(rangemin1,rangemax1,VarName1,VarName2);

rangemin2 = 1430;
rangemax2 = 1480;
[peak2,fit2,fitrange2] = fitpeak(rangemin2,rangemax2,VarName1,VarName2);

rangemin3 = 3680;
rangemax3 = 3730;
[peak3,fit3,fitrange3] = fitpeak(rangemin3,rangemax3,VarName1,VarName2);

e1=0.8648e03;
e2=0.9933e03;
e3=2.5842e03;

polyAns = polyfit([peak1 peak2 peak3],[e1 e2 e3],1);

ch = VarName1;
e = polyAns(1) * ch + polyAns(2);

%figure;semilogy(e,VarName2)
%plot(e,VarName2)