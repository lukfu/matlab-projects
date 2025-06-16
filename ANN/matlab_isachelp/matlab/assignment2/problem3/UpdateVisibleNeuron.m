
function v = UpdateVisibleNeuron(weight,h,thetaVisible)
      tmp = transpose(transpose(h)*weight);
      probUpdateV = ProbabilityFunction(tmp-thetaVisible);
      v = ones(length(probUpdateV),1);
      negative1IndexesV = ( rand(length(probUpdateV),1) > probUpdateV);
      v(negative1IndexesV)=-1;
end








