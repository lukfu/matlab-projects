function retarder=J_ret(alpha,phi)
retarder=J_proj(-1*alpha)*[exp(1i*phi),0;0,1]*J_proj(alpha);