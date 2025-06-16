function [wIn,wReservoir] = InitializeNetwork(nInput,nReservoir)
variance1 = sqrt(0.002);
variance2 = 2/nReservoir;
wIn = normrnd(0,variance1,nReservoir,nInput);
wReservoir = normrnd(0,variance2,nReservoir,nReservoir);
end