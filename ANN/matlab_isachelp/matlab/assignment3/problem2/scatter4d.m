function scatter4d(numbers,net_encode,xTest,tTest,plotAll,ik,plotNumber)
    if nargin<=6
       plotNumber=-1; 
    end
    figure;
    xTest = xTest(:,ik:ik+1000);
    tTest = double(tTest(ik:ik+1000))-1;
    xCopy = xTest;
    tCopy = tTest;
    color=['r','g','b','c','m','y','#7E2F8E','#ffb300','#00ff80','k'];
    img = 1;
    for i=1:3
        for j=i+1:4
            xTest = xCopy;
            tTest = tCopy;
            subplot(2,3,img);
            hold on
            img = img+1;
            
            for iNum = 1:length(numbers)
               tmp = (tTest==numbers(iNum));
                input = xTest(:,tmp);
                output = net_encode.predict(input);
                x = output(i,:);
                y = output(j,:);
                scatter(x,y,[],color(iNum)); 
                xTest(:,tmp)=[];
                tTest(tmp)=[];
                
            end
            
            if plotAll
                output = net_encode.predict(xTest);
                x = output(1,:);
                y = output(2,:);
                scatter(x,y,[],'kx') 
            end
            plot([0,20],[0,20],'k')
            plot([0,20],[0,40],'k')
            xlabel('dim: '+string(i))
            ylabel('dim: '+string(j))
            axis equal;
        end
    end
    if plotNumber~=-1
      switch plotNumber
          case 1
              i=1;j=2;
          case 2
              i=1;j=3;
          case 3
              i=1;j=4;
          case 4
              i=2;j=3;
          case 5
              i=2;j=4;
          case 6
              i=3;j=4;
      end
       clf
       xTest = xCopy;
        tTest = tCopy;
        hold on
        for iNum = 1:length(numbers)
           tmp = (tTest==numbers(iNum));
            input = xTest(:,tmp);
            output = net_encode.predict(input);
            x = output(i,:);
            y = output(j,:);
            scatter(x,y,[],color(iNum)); 
            xTest(:,tmp)=[];
            tTest(tmp)=[];

        end
    end
    legend(string(numbers))
    axis equal;
end