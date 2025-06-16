
function plotTraining(input,output,target)
%plot the 1:a and 2:a vectors as coordinaters and third as color
pointsize = 10;
subplot(1,2,1)
scatter(input(1,:),input(2,:),pointsize, output);
subplot(1,2,2)
scatter(input(1,:),input(2,:),pointsize, target);

end

























