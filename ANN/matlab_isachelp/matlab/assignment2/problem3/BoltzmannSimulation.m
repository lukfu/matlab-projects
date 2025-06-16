
function [vt0,vti] = BoltzmannSimulation(weight,thetaVisible,thetaHidden,InputPattern,k)
   vt0 = InputPattern;
   vti = vt0;
   for i=1:k 
        hti = UpdateHiddenNeuron(weight,vti,thetaHidden);
        vti = UpdateVisibleNeuron(weight,hti,thetaVisible);
   end
end