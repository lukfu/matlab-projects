
function h = UpdateHiddenNeuron(weight,v,thetaHidden)
      probUpdateH = ProbabilityFunction(weight*v-thetaHidden);
      h = ones(length(probUpdateH),1); 
      negative1IndexesH = ( rand(length(probUpdateH),1) > probUpdateH);
      h(negative1IndexesH)=-1;
end