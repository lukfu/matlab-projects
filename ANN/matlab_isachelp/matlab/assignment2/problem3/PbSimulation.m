
function Pb = PbSimulation(weight,thetaVisible,thetaHidden,patterns)
   patternLength = size(patterns,2);
   N1 = 1000;
   N2 = 1000;
   Pb=zeros(patternLength,1); 
   for iAveraging = 1:N1
        patternChosen = randi(patternLength);     
        vti = patterns(:,patternChosen); 
        for i=1:N2
            hti = UpdateHiddenNeuron(weight,vti,thetaHidden);
            vti = UpdateVisibleNeuron(weight,hti,thetaVisible);
            for iPattern = 1:patternLength
                if(vti == patterns(:,iPattern))
                    Pb(iPattern) = Pb(iPattern)+1;
                end
            end
        end
   end
   Pb = Pb/(N1*N2);
end