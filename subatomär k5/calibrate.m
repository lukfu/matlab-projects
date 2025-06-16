%Caliberation
% E1 = 0.8648 MeV
% E2 = 0.9933 MeV
% E3 = 2.5842 MeV

ch = table2array(bi46(:,1));
ydata = table2array((bi46(:,2)));

%plot(ch,ydata)

rangemin1 = 2700;
rangemax1 = 2800;
[peak1,fit1,fitrange1] = fitpeak(rangemin1,rangemax1,ch,ydata);

rangemin2 = 5530;
rangemax2 = 5630;
[peak2,fit2,fitrange2] = fitpeak(rangemin2,rangemax2,ch,ydata);

rangemin3 = 5950;
rangemax3 = 6050;
[peak3,fit3,fitrange3] = fitpeak(rangemin3,rangemax3,ch,ydata);

e1=482;
e2=976;
e3=1048;

polyAns = polyfit([peak1 peak2 peak3],[e1 e2 e3],1);

e = polyAns(1) * ch + polyAns(2);

%figure;semilogy(e,VarName2)
plot(e,ydata)

%% 3.1
csData = table2array(cs117h(:,2));
bg = table2array(background97h);

%% 3.2
data = table2array(cs117h);
[kuriedata]=kurieplot(e,data,56);

range = 700:1100;

[slope,offset] = kuriefit(e,kuriedata,range);
display(slope)
display(offset)

Q = abs(offset/slope)
%alternativ Q1 för tidigare slope
%% 3.3
Z = 56;
log10f=log10f(Z,Q);
lambda=log(2)/(30 * 365.25 * 24 * 3600);
lambda1 = 0.9 * lambda;
lambda2 = 0.1 * lambda;
t1 = log(2) / lambda1
