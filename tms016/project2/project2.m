% initialize
clear; clc
folder_path %add all needed functions
perm = load('permeability.mat');
sz = size(perm.Y); %image size
K = 2; %classes

%data
for sigma = 9:1:14
    data = perm.Y;
    data2 = perm.Y + normrnd(0,sigma,sz); %with noise variance sigma

    %k-mean
    Istack = reshape(data,[numel(data),1]);
    Istack2 = reshape(data2,[numel(data2),1]);
    [cl_Kmeans , p_kmean ] = normmix_kmeans(Istack, K);
    [cl_Kmeans2 , p_kmean2 ] = normmix_kmeans(Istack2, K);
    img1 = reshape(cl_Kmeans, sz)-1; 
    img2 = reshape(cl_Kmeans2, sz)-1;

    % gaussian mixture model
    params_GMM = normmix_sgd(Istack, K);
    params_GMM2 = normmix_sgd(Istack2, K);
    [cl_GMM, p_GMM] = normmix_classify(Istack, params_GMM);
    [cl_GMM2, p_GMM2] = normmix_classify(Istack2, params_GMM2);
    img3 = reshape(cl_GMM, sz)-1;
    img4 = reshape(cl_GMM2, sz)-1;
    
    % mixture#2
    img5 = getMixture(data, K);
    img6 = getMixture(data2, K);
    
    %make sure image color are the same at corner
    color = (data(1,1) > 0)*1; 
    img1 = abs(color-abs(img1(1,1)-img1 ));
    img2 = abs(color-abs(img2(1,1)-img2 ));
    img3 = abs(color-abs(img3(1,1)-img3 ));
    img4 = abs(color-abs(img4(1,1)-img4 ));
    img5 = abs(color-abs(img5(1,1)-img5 ));
    img6 = abs(color-abs(img6(1,1)-img6 )); 
    
    hfig = figure;

    %original images
    subplot(4,2,1);imshow(data);title('without noise')
    subplot(4,2,2);imshow(data2);title('with noise: ' + string(sigma) )
    
    %k-means 
    subplot(4,2,3);imshow(img1)
    subplot(4,2,4);imshow(img2)
    
    %gaussian mixture
    subplot(4,2,5);imshow(img3)
    subplot(4,2,6);imshow(img4)
    
    %other mixture
    subplot(4,2,7);imshow(img5)
    subplot(4,2,8);imshow(img6)
    
    print(hfig, '-djpeg', 'sigma'+string(sigma))
end
close all
beep


function image = getMixture(img,K,N)
    if nargin <=2
        N = [0 1 0;1 0 1;0 1 0]; %Neighborhood structure
    end
    
    %mixture function
    opts = struct('plot',0,'N',N,'common_beta',1);
    [~,~,~,cl,~]=mrf_sgd(img,K,opts);

    image = cl-1;
end