%sign(x) with if==0 --> =1
function sgn = Sgn(x)
    sgn = sign(x);
    if sgn == 0 
        sgn = 1;
    end
end