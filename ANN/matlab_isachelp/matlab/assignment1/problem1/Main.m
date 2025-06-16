%main code
p = [12,24,48,70,100,120];
N = 120;
trial = 10^5;

p_error = [];
for i = 1:length(p)
    p_error = [p_error; Perror(p(i),N,trial)];
end
disp(round(p_error,4))









