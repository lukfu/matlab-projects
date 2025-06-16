function [sigma,eta] = UpdateSigmaEta(sigma,eta,epoch)
    dSigma = 0.05;
    dEta = 0.01;
    sigma = sigma * exp(-dSigma * epoch);
    eta = eta * exp(-dEta * epoch);
end