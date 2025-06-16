%% ===============load data =======================
clear;clc

%get access to all matlab functions as well as data titan/rosetta
folder_path


%this_img = imread('rosetta.jpg'); this_img = double(rgb2gray(this_img))/255;
this_img = imread('titan.jpg'); this_img = double(this_img)/255;


img_data = struct(); 
n_img = numel(this_img);
x_img = reshape(this_img, [n_img, 1] );
img_size = size(this_img);

img_data.x_img = x_img;
img_data.n_img = n_img;
img_data.size = size(this_img);
%% get sigma and variogram
%takes a while to run
info = spatial_info(0.5, img_data);
sigma = get_variogram(n_img,info,1);

%% how kappa in Q changes
clf;clc
p_c = 0.5;
kappa_val = linspace(0,10,100);
saved_diff = zeros(length(kappa_val),1);
for iKappa = 1:length(kappa_val) 
    kappa = kappa_val(iKappa)
    info = spatial_info(p_c,img_data);
    krig = krig_own(kappa, sigma, img_data, info);
    
    %get difference in pixel values (missing pixels)
    x_img3 = x_img;
    x_img3(info.ind_p) = max(krig,0); 
    saved_diff(iKappa,1) = sum(abs(x_img-x_img3))/length(info.ind_p);
end

plot(kappa_val, saved_diff)
xlabel('kappa')
ylabel('average pixel difference ')

%% how p_c changes
clf;clc
kappa=0;
pc_val = linspace(0.1,0.999,1000);
saved_diff = zeros(length(pc_val),1);
for iP =1:length(pc_val)
    p_c = pc_val(iP);
    info = spatial_info(p_c, img_data);
    krig = krig_own(kappa,sigma, img_data, info);
    
    x_img3 = x_img;
    x_img3(info.ind_p) = max(krig,0); 
    saved_diff(iP,1) = sum(abs(img_data.x_img-x_img3))/length(info.ind_p);
end
plot(pc_val, saved_diff)
xlabel('p_c')
ylabel('average pixel difference ')

%% Choose a specific kappa, p_c
kappa = 0;
p_c = 0.90; 
info = spatial_info(p_c, img_data);
krig = krig_own(kappa,sigma, img_data, info);

%% PLOT images for specific kappa, p_c

x_img1 = x_img;
x_img2 = x_img;
x_img3 = x_img;

x_img2(info.ind_p)=0;
x_img3(info.ind_p) = krig; 
x_img4 = abs(x_img-x_img3);

h = tiledlayout(2,4, 'TileSpacing', 'none', 'Padding', 'tight');
nexttile
imshow(reshape(x_img1,img_size));
colormap('gray'); title('original')

nexttile; imshow(reshape(x_img2,img_size));
colormap('gray'); title('corrupted')

nexttile; imshow(reshape(x_img3,img_size));
colormap('gray'); title('reconstructed')

nexttile; imshow(reshape(x_img4,img_size));
colormap('gray'); title('difference')

%% functions

function sigma = get_variogram(n_img, info, shouldPlot)
%plot variogram and get pars.sigma
    shouldPlot = 1;
    if nargin <=2
        shouldPlot = 0;
    end

    residual = info.x_limit_o - (info.B_o*info.LSE);

    % empirical_variogram
    out = emp_variogram(info.loc_limit_o,residual,floor(length(residual)/100));
    
    % estimated parameters
    pars = cov_ls_est(residual,'matern',out);
    sigma = pars.sigma;
    
    if shouldPlot == 1
        hold on
        h = linspace(1,sqrt(2*n_img),floor(sqrt(n_img)));
        sv2 = matern_variogram(h,pars.sigma,pars.kappa,pars.nu,pars.sigma_e);
        plot(h,sv2,'b')
        plot(out.h,out.variogram,'r.')
    end
end

function info = spatial_info(p_c,img_data)
    %get spatial info about image/missing pixels
    img_size = img_data.size;
    n_img = img_data.n_img;
    x_img = img_data.x_img;
    
    info = struct();
    r = rand(n_img,1) < p_c;

    ind_o = getIndeces(not(r));
    ind_p = getIndeces(r); 
    loc_o = index2loc(ind_o,img_size);
    loc_p = index2loc(ind_p,img_size);
    x_o = x_img(ind_o);
    x_p = x_img(ind_p); 
    limit_o = min(1E4,length(x_o));
    ind_limit_o = ind_o(randperm(limit_o));
    loc_limit_o = index2loc(ind_limit_o,img_size);
    x_limit_o = x_img(ind_limit_o);
    D_limit_o = squareform(pdist(loc_limit_o));
    
    B_o = [ones(size(ind_limit_o)), loc_limit_o]; %Covariates of limited observed pixels ( intercept, x-coordinate, y-coordinate)
    LSE = (B_o'*B_o) \ B_o' * x_limit_o; %LSE estimates (ols)
    
    %add to struct (python dictionary)
    info.B_o = B_o;
    info.LSE = LSE;
    info.limit_o = limit_o;
    info.ind_o = ind_o;
    info.ind_p = ind_p;
    info.loc_o = loc_o;
    info.loc_p = loc_p;
    info.x_o = x_o;
    info.x_p = x_p;
    info.limit_o = limit_o;
    info.ind_limit_o = ind_limit_o;   
    info.x_limit_o =  x_limit_o;
    info.loc_limit_o = loc_limit_o;
    info.D_limit_o = D_limit_o;
end

function krig = krig_own(kappa, sigma, img_data, info)
    % function predict missing pixels
    ind_o = info.ind_o;
    ind_p = info.ind_p;
    ind_limit_o = info.ind_limit_o;
    x_limit_o = info.x_limit_o;
    x_o = info.x_o;

    B_o = [ones(size(ind_limit_o)), info.loc_limit_o]; %Covariates of observed pixels ( intercept, x-coordinate, y-coordinate)
    LSE = (B_o'*B_o) \ B_o' * x_limit_o; %LSE estimates

    B_o = [ones(size(ind_o)), info.loc_o]; %Covariates of observed pixels ( intercept, x-coordinate, y-coordinate)
    B_p = [ones(size(ind_p)), info.loc_p ]; %covariates of points to be predicted
    mu_p = B_p*LSE;
    mu_o = B_o*LSE;

    %Precision matrix
    Q1 = getQ(kappa,img_data.size,sigma); 

    %Precision matrices
    Qop = Q1(ind_o, ind_p);
    Qp = Q1(ind_p, ind_p);

    krig = mu_p - Qp \ (Qop'*(x_o-mu_o)); %GMRF
end


function index = getIndeces(index)
    %input boolean vector: [0,1,0,0,1,1]
    %output index:         [2,5,6]    
    index = index .* cumsum(ones(size(index)));
    index = nonzeros(index);
end

function val = index2loc(index, dim)
    %input_1 index of 1d array  
    %input_2 dimension of 2d array
    %output index in 2d array
    %example: index:4, dimension: [5,3]--> output:[2,1]
    dy = dim(2);
    y = matlab_mod(index, dy);
    x = floor(index/dy+0.99999);
    val = [x,y];
end

function val = matlab_mod(x,y)
    %when using modulus with arrays (matlab arrays start at 1)
    val = 1 + mod(x-1,y);
end

function Q = getQ(kappa,dim,sigma)
    %get Q from stencil
    v1 =  kappa^4 *  [0 0 0 0 0
                      0 0 0 0 0
                      0 0 1 0 0
                      0 0 0 0 0
                      0 0 0 0 0];
                  
    v2 = 2*kappa^2 * [0 0 0 0 0
                      0 0 -1 0 0
                      0 -1 4 -1 0
                      0 0 -1 0 0
                      0 0 0 0 0];
                  
    v3 =             [0 0 1 0 0
                      0 2 -8 2 0
                      1 -8 20 -8 1
                      0 2 -8 2 0
                      0 0 1 0 0];
    stencil = v1+v2+v3;
    Q = stencil2prec(dim,stencil);
    Q = (2*pi/sigma) * Q;
end

