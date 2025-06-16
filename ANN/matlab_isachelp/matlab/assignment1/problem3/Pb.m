%stochastic update probability
function pB = Pb(bi,noise_beta)
    pB=1/(1+exp(-2*noise_beta*bi));
end