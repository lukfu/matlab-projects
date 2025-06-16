plot(VarName1,VarName2)

clf

rangemin1 = 3520;
rangemax1 = 3620;
[peak1,fit1,fitrange1] = fitpeak(rangemin1,rangemax1,VarName1,VarName2);

rangemin2 = 3700;
rangemax2 = 3800;
[peak2,fit2,fitrange2] = fitpeak(rangemin2,rangemax2,VarName1,VarName2);

e1=0.8648e03;
e2=0.9933e03;

polyAns = polyfit([peak1 peak2],[e1 e2],1);

ch = VarName1;
e = polyAns(1) * ch + polyAns(2);

%figure;semilogy(e,VarName2)
%plot(e,VarName2)