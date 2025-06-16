function polar=J_pol(alpha)
polar=J_proj(-1*alpha)*[1,0;0,0]*J_proj(alpha);