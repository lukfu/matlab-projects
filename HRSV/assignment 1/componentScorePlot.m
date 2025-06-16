%% HRSV HA1 Discussion Question 4 - Component Score
% leon.mueller@chalmers.se

%% Create some data to plot
% Here, the Pleasantness and Evenfulness were saved in the variables Pplot and
% Eplot. As you are only supposed to make this plot for the combination of all
% groups, P and E are each of the size (1 combined group result x 8 locations).

% Here we just create some random data to plot, replace this with your own
% calculated data!
Pplot = rand(1,8) - 0.5;
Eplot = rand(1,8) - 0.5;


%% Plotting Variables
% you can change those in order to customize the look of the plot
lw = 1.5;       % Linewidth
lw_axes = 1.5;  % Linewidth of the axes
ms = 9;         % Marker size
fonts = 17;     % Font size
locationLabels = {'1. Central Station','2. Tr\"{a}dg\r{a}rdsf\"{o}reningen', ...
    '3. Stora Teatern','4. Stora Nygatan','5. Kungsportsplatsen', ...
    '6. Domkyrkan','7. Brunnsparken','8. Nordstan'};




%% Plot Component Score
figure('Name', '2021 Discussion Question 4 - Component Score','Position', [10 10 774 483]) 
plot(Pplot(1),Eplot(1),'ko','linewidth',lw,'Markersize',ms)
hold on
plot(Pplot(2),Eplot(2),'^','linewidth',lw,'Markersize',ms) 
plot(Pplot(3),Eplot(3),'x','linewidth',lw,'Markersize',ms) 
plot(Pplot(4),Eplot(4),'s','linewidth',lw,'Markersize',ms) 
plot(Pplot(5),Eplot(5),'d','linewidth',lw,'Markersize',ms) 
plot(Pplot(6),Eplot(6),'p','linewidth',lw,'Markersize',ms) 
plot(Pplot(7),Eplot(7),'h','linewidth',lw,'Markersize',ms) 
plot(Pplot(8),Eplot(8),'*','linewidth',lw,'Markersize',ms)
axis ([-1 1 -1 1]) 
set(gca,'fontsize',fonts, 'LineWidth', lw_axes, 'TickLabelInterpreter','latex')
grid minor
patch([-1 0 0 -1], [0 0 1 1],'b') 
hold on
patch([-1 0 0 -1], [-1 -1 0 0],'r') 
patch([0 1.0 1.0 0], [0 0 1 1],'g') 
patch([1 0 0 1], [-1 -1 0 0],'y') 
alpha(0.05)
hold on
x1=line([-0.75,0.75],[-0.75,0.75]);
x1.LineStyle = '--';
x1.Color = 'k';
hold on
x2=line([-0.75,0.75],[0.75,-0.75]);
x2.LineStyle = '--';
x2.Color = 'k';
text(-0.95,0.9,'Chaotic','fontsize',fonts,'Interpreter','latex') 
text(0,0.9,'Eventful','fontsize',fonts,'Interpreter','latex') 
text(0.7,0.9,'Exciting','fontsize',fonts,'Interpreter','latex') 
text(0.7,0.05,'Pleasant','fontsize',fonts,'Interpreter','latex') 
text(0.7,-0.9,'Calm','fontsize',fonts,'Interpreter','latex') 
text(0,-0.9,'Uneventful','fontsize',fonts,'Interpreter','latex') 
text(-0.95,-0.9,'Monotoneus','fontsize',fonts,'Interpreter','latex') 
text(-0.95,0.05,'Unpleasant','fontsize',fonts,'Interpreter','latex')
legend (locationLabels,'Location','EastOutside','box','off', 'Interpreter','latex','fontsize',fonts) 

% clear plotting variables
clear lw lw_axes ms xlabels locationLabels fonts x1 x2