
%% central limit theorem check
itteration_a=1000;
itteration_b=1000;
gaussian_dist=zeros(1,itteration_a);

for a=1:itteration_a
    dist_sum=0;
    for b=1:itteration_b
        if(rand(1)<0.5)
            dist_sum=dist_sum+1;
        else
            dist_sum=dist_sum-30;
        end
        %dist_sum=dist_sum+gamrnd(5,7);
    end
    gaussian_dist(a)=dist_sum;
end
histogram(gaussian_dist)

%% hopfield p=1 N=4


%% hopfield p=1 N=16


%% hopfield p=2 N=16
























