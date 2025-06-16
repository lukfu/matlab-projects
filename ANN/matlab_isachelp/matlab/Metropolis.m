
T=10^5;
x = zeros(T,1);
x(1) = 3;%aribtrary point
for i =2:T
  current_x = x(i-1);  %doesn't need to be gaussian, as long as g(x|y)=g(y|x) 
  proposed_x = current_x + (rand*2-1);%propose new x
  A = Target(proposed_x)/Target(current_x) ;
  if (rand < A )
    x(i) = proposed_x;    %accept
   else 
    x(i) = current_x ;  %reject
  end
end
hist(x)

%target =e^(-x)
function xval = Target(x)
  if (x<0 || x>pi)
    xval=0;
  else
     xval=sin(x); 
  end
end
