function PlotScatter(numbers,net_encode,xTest,tTest,plotAll,ik)
    xTest = xTest(:,ik:ik+1000);
    tTest = double(tTest(ik:ik+1000))-1;
    color=['r','g','b','c','m','y','#7E2F8E','#ffb300','#00ff80','k'];
    hold on
    
    for iNum = 1:length(numbers)
        tmp = (tTest==numbers(iNum));
        input = xTest(:,tmp);
        output = net_encode.predict(input);
        x = output(1,:);
        y = output(2,:);
        scatter(x,y,[],color(iNum)) 
        xTest(:,tmp)=[];
        tTest(tmp)=[];
    end
    
    legend(string(numbers));
    if plotAll
        output = net_encode.predict(xTest);
        x = output(1,:);
        y = output(2,:);
        scatter(x,y,[],'k.') 
        legend([string(numbers),'Other number']);
    end
    
    axis equal;
end