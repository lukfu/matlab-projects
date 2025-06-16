function [W1,W2,TH1,TH2] = UpdateWeightsAndTheta(eta,weight1,weight2,theta1,theta2,I,V,O,T)
    %error2 = (T - O) * g'(B), g'(B) = 1 - tanh(B)^2, tanh(B) = O
    %tanh(b) = V
    error2 = (T-O).*(1-O.^2);
    error1 = error2'*weight2(:,1)*(1-V.^2);

    W2 = weight2 + eta*error2*transpose(V);
    TH2 = theta2 - eta*error2;

    W1 = weight1 + eta*error1*transpose(I);
    TH1 = theta1 - eta*error1;
    
end