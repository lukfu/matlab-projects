


function [W1,W2,T1,T2] = UpdateWeightsAndTheta(eta,weight1,weight2,theta1,theta2,I,V,O,T)
    
    error2 = (T-O).*(O-O.^2);  %g'(B)= 
    error1 = zeros(length(V),1);

    for i = 1:length(V)
        error1(i) = error2'*weight2(:,i)*(V(i)-V(i).^2);        
    end
 
    W2 = weight2 + eta*error2*transpose(V);
    T2 = theta2-eta*error2;
    
    W1 = weight1 + eta*error1*transpose(I);
    T1 = theta1-eta*error1;    
end
















