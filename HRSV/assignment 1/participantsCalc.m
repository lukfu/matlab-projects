clear
clc

load('sw_2022_group_1A');
load('sw_2022_group_1B');
load('sw_2022_group_2A');
load('sw_2022_group_2B');

% p-value
p = 0.05;

sw22.grp1A.nParticipants = size(sw_2022_group_1A, 2);

% mean values of question 1234 (question 123 needs to be scaled down by 3.1, aka column 123)
% group 1A mean q1234
sw22.grp1A.q1234 = cat(3, sw_2022_group_1A(:).Questions_1234);
sw22.grp1A.q1234mean = mean(sw22.grp1A.q1234, 3);


% group 1B mean q1234
sw22.grp1B.q1234 = cat(3, sw_2022_group_1B(:).Questions_1234);
sw22.grp1B.q1234mean = mean(sw22.grp1B.q1234, 3);

% group 2A mean q1234
sw22.grp2A.q1234 = cat(3, sw_2022_group_2A(:).Questions_1234);
sw22.grp2A.q1234mean = mean(sw22.grp2A.q1234, 3);
sw22.grp2A.q1234max = max(sw22.grp2A.q1234);

% group 2B mean q1234
sw22.grp2B.q1234 = cat(3, sw_2022_group_2B(:).Questions_1234);
sw22.grp2B.q1234mean = mean(sw22.grp2B.q1234, 3);

% group 1A + 2A mean q1234
sw22.grp1A2A.q1234 = cat(3, sw22.grp1A.q1234, sw22.grp2A.q1234);
sw22.grp1A2A.q1234mean = mean(sw22.grp1A2A.q1234, 3);

% group 1B + 2B mean q1234
sw22.grp1B2B.q1234 = cat(3, sw22.grp1B.q1234, sw22.grp2B.q1234);
sw22.grp1B2B.q1234mean = mean(sw22.grp1B2B.q1234, 3);

% group 1A + 1B + 2A + 2B mean q1234
sw22.grp1A1B2A2B.q1234 = cat(3, sw22.grp1A.q1234, sw22.grp2A.q1234, sw22.grp1B.q1234, sw22.grp2B.q1234);
sw22.grp1A1B2A2B.q1234mean = mean(sw22.grp1A1B2A2B.q1234, 3);

% grp1A1B2A2B q123
sw22.grp1A1B2A2B.q123 = cat(2, sw22.grp1A1B2A2B.q1234(:,1,:), sw22.grp1A1B2A2B.q1234(:,2,:), sw22.grp1A1B2A2B.q1234(:,3,:));
sw22.grp1A1B2A2B.q123mean = mean(sw22.grp1A1B2A2B.q123, 3);
% SEM
sw22.grp1A1B2A2B.SEM = std(sw22.grp1A1B2A2B.q123,0,3)./sqrt(length(sw22.grp1A1B2A2B.q123));
% T-score
sw22.grp1A1B2A2B.ts = tinv(1 - p/2, length(sw22.grp1A1B2A2B.q123) - 1);
% confidence interval
sw22.grp1A1B2A2B.confidenceInt = [mean(sw22.grp1A1B2A2B.q123) - sw22.grp1A1B2A2B.ts .* sw22.grp1A1B2A2B.SEM, mean(sw22.grp1A1B2A2B.q123) + sw22.grp1A1B2A2B.ts .* sw22.grp1A1B2A2B.SEM] ;
% error is (confidence interval - mean value) (PROBLEM 2)
% errorbar plotting
%err = sw22.grp1A1B2A2B.confidenceInt - sw22.grp1A1B2A2B.q123mean;
%errorbar()

%PROBLEM 4
% grp1A q4
sw22.grp1A.q4 = cat(2, sw22.grp1A.q1234(:,4,:), sw22.grp1A.q1234(:,5,:), sw22.grp1A.q1234(:,6,:), sw22.grp1A.q1234(:,7,:), sw22.grp1A.q1234(:,8,:), sw22.grp1A.q1234(:,9,:), sw22.grp1A.q1234(:,10,:), sw22.grp1A.q1234(:,11,:));
sw22.grp1A.q4mean = mean(sw22.grp1A.q4);
% SEM
sw22.grp1A.q4SEM = std(sw22.grp1A.q4,0,3)./sqrt(length(sw22.grp1A.q4));
% T-score
sw22.grp1A.q4ts = tinv(1 - p/2, length(sw22.grp1A.q4) - 1);
% confidence interval
sw22.grp1A.q4confidenceInt = [mean(sw22.grp1A.q4) - sw22.grp1A.q4ts .* sw22.grp1A.q4SEM, mean(sw22.grp1A.q4) + sw22.grp1A.q4ts .* sw22.grp1A.q4SEM] ;


%PROBLEM 5
%grp1A 
sw22.grp1A.p = cat(2, sw22.grp1A.q4(:,1,:));
sw22.grp1A.ch = cat(2, sw22.grp1A.q4(:,2,:));
sw22.grp1A.v = cat(2, sw22.grp1A.q4(:,3,:));
sw22.grp1A.u = cat(2, sw22.grp1A.q4(:,4,:));
sw22.grp1A.ca = cat(2, sw22.grp1A.q4(:,5,:));
sw22.grp1A.a = cat(2, sw22.grp1A.q4(:,6,:));
sw22.grp1A.e = cat(2, sw22.grp1A.q4(:,7,:));
sw22.grp1A.m = cat(2, sw22.grp1A.q4(:,8,:));


%PLEASANTNESS (PROBLEM 6)
%P = (sqrt(2) * (p - a) + (ca - ch) + (v - m)) / (4 + sqrt(8));
sw22.grp1A.P = (sqrt(2) * (sw22.grp1A.p - sw22.grp1A.a) + (sw22.grp1A.ca - sw22.grp1A.ch) + (sw22.grp1A.v - sw22.grp1A.m)) / (4 + sqrt(8));
sw22.grp1A.Pmean = mean(sw22.grp1A.P);

%EVENTFULNESS (PROBLEM 7)
%E = (sqrt(2) * (e - u) - (ca - ch) + (v - m)) / (4 + sqrt(8))
sw22.grp1A.E = (sqrt(2) * (sw22.grp1A.e - sw22.grp1A.u) - (sw22.grp1A.ca - sw22.grp1A.ch) + (sw22.grp1A.v - sw22.grp1A.m)) / (4 + sqrt(8));
sw22.grp1A.Emean = mean(sw22.grp1A.E);

% all group interviews
sw22. grp1A1B2A2B.interviews = cat(2, sw_2022_group_1A(:).interview, sw_2022_group_1B(:).interview, sw_2022_group_2A(:).interview, sw_2022_group_2B(:).interview);


% group 1A average age calculation
sw22.grp1A.interviews = cat(2, sw_2022_group_1A(:).interview);

sw22.grp1A.part1Age = sw_2022_group_1A(1).interview{3};
sw22.grp1A.part2Age = sw_2022_group_1A(2).interview{3};
sw22.grp1A.part3Age = sw_2022_group_1A(3).interview{3};
sw22.grp1A.part4Age = sw_2022_group_1A(4).interview{3};
sw22.grp1A.part5Age = sw_2022_group_1A(5).interview{3};

sw22.grp1A.partAllAge = cat(3,sw22.grp1A.part1Age,sw22.grp1A.part2Age,sw22.grp1A.part3Age,sw22.grp1A.part4Age,sw22.grp1A.part5Age);
sw22.grp1A.avgAge = mean(sw22.grp1A.partAllAge);

% group 1B average age calculation
sw22.grp1B.interviews = cat(2, sw_2022_group_1B(:).interview);

sw22.grp1B.part1Age = sw_2022_group_1B(1).interview{3};
sw22.grp1B.part2Age = sw_2022_group_1B(2).interview{3};
sw22.grp1B.part3Age = sw_2022_group_1B(3).interview{3};
sw22.grp1B.part4Age = sw_2022_group_1B(4).interview{3};
sw22.grp1B.part5Age = sw_2022_group_1B(5).interview{3};

sw22.grp1B.partAllAge = cat(3,sw22.grp1B.part1Age,sw22.grp1B.part2Age,sw22.grp1B.part3Age,sw22.grp1B.part4Age,sw22.grp1B.part5Age);
sw22.grp1B.avgAge = mean(sw22.grp1B.partAllAge);

% group 2A average age calculation
sw22.grp2A.interviews = cat(2, sw_2022_group_2A(:).interview);

sw22.grp2A.part1Age = sw_2022_group_2A(1).interview{3};
sw22.grp2A.part2Age = sw_2022_group_2A(2).interview{3};
sw22.grp2A.part3Age = sw_2022_group_2A(3).interview{3};
sw22.grp2A.part4Age = sw_2022_group_2A(4).interview{3};

sw22.grp2A.partAllAge = cat(3,sw22.grp2A.part1Age,sw22.grp2A.part2Age,sw22.grp2A.part3Age,sw22.grp2A.part4Age);
sw22.grp2A.avgAge = mean(sw22.grp2A.partAllAge);

% group 2A average age calculation
sw22.grp2A.interviews = cat(2, sw_2022_group_2A(:).interview);

sw22.grp2A.part1Age = sw_2022_group_2A(1).interview{3};
sw22.grp2A.part2Age = sw_2022_group_2A(2).interview{3};
sw22.grp2A.part3Age = sw_2022_group_2A(3).interview{3};
sw22.grp2A.part4Age = sw_2022_group_2A(4).interview{3};

sw22.grp2A.partAllAge = cat(3,sw22.grp2A.part1Age,sw22.grp2A.part2Age,sw22.grp2A.part3Age,sw22.grp2A.part4Age);
sw22.grp2A.avgAge = mean(sw22.grp2A.partAllAge);

% group 2A average age calculation
sw22.grp2B.interviews = cat(2, sw_2022_group_2B(:).interview);

sw22.grp2B.part1Age = sw_2022_group_2B(1).interview{3};
sw22.grp2B.part2Age = sw_2022_group_2B(2).interview{3};
sw22.grp2B.part3Age = sw_2022_group_2B(3).interview{3};
sw22.grp2B.part4Age = sw_2022_group_2B(4).interview{3};

sw22.grp2B.partAllAge = cat(3,sw22.grp2B.part1Age,sw22.grp2B.part2Age,sw22.grp2B.part3Age,sw22.grp2B.part4Age);
sw22.grp2B.avgAge = mean(sw22.grp2B.partAllAge);

% total average age
sw22.avgAgeOfGrps = cat(3,sw22.grp1A.avgAge,sw22.grp1B.avgAge,sw22.grp2A.avgAge,sw22.grp2B.avgAge);
sw22.avgAge = mean(sw22.avgAgeOfGrps);

%%

%age_vect_1A = [];
% make a vector of all ages
%sw_2022_group_1A(1).interview(3,1) = age_vect_1A(1,1);
%sw_2022_group_1A(2).interview(3,1) = age_vect_1A(1,2);
%sw_2022_group_1A(3).interview(3,1) = age_vect_1A(1,3);
%sw_2022_group_1A(4).interview(3,1) = age_vect_1A(1,4);
%sw_2022_group_1A(5).interview(3,1) = age_vect_1A(1,5);

age_avg_1A = mean();