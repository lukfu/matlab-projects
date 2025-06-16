clear
clc

load('HRSV_Home_assignment_2022_part_3.mat')

% 95% confidence interval p-value
p = 0.05;

part_1a_loudnessRatio = experiment_1a_data.loudness_ratio;
part_1b_loudnessRatio = experiment_1b_data.loudness_ratio;
save('exp_1a_rel_loud', 'part_1a_loudnessRatio');
save('exp_1b_rel_loud', 'part_1b_loudnessRatio');

% for relative loudness, if louder sound is 1, divide loudness ratio by 100
% if louder sound is 2, divide 100 by loudness ratio

% estimated loudness ratio average over the 9 sounds
HA3.part_1a.loudnessRatio_mean = mean(experiment_1a_data.loudness_ratio, 1);
HA3.part_1b.loudnessRatio_mean = mean(experiment_1b_data.loudness_ratio, 1);

% confidence interval calculation
% standard error
HA3.part_1a.SEM = std(experiment_1a_data.loudness_ratio,0,1) ./ sqrt(length(experiment_1a_data.loudness_ratio));
% T-score
HA3.part_1a.ts = tinv(1-p/2, length(length(experiment_1a_data.loudness_ratio)));
% confidence interval
HA3.part_1a.CI = [HA3.part_1a.loudnessRatio_mean - HA3.part_1a.ts .* HA3.part_1a.SEM; HA3.part_1a.loudnessRatio_mean + HA3.part_1a.ts .* HA3.part_1a.SEM];

% 1b CI
% standard error
HA3.part_1b.SEM = std(experiment_1b_data.loudness_ratio,0,1) ./ sqrt(length(experiment_1b_data.loudness_ratio));
% T-score
HA3.part_1b.ts = tinv(1-p/2, length(length(experiment_1b_data.loudness_ratio)));
% confidence interval
HA3.part_1b.CI = [HA3.part_1b.loudnessRatio_mean - HA3.part_1b.ts .* HA3.part_1b.SEM; HA3.part_1b.loudnessRatio_mean + HA3.part_1b.ts .* HA3.part_1b.SEM];

% geometric mean and CI
HA3.part_1a.loudnessRatio_geoMean = geomean(experiment_1a_data.loudness_ratio, 1);
HA3.part_1b.loudnessRatio_geoMean = geomean(experiment_1b_data.loudness_ratio, 1);
% natural log
HA3.part_1a.loudnessRatio_natLog = log(experiment_1a_data.loudness_ratio);
HA3.part_1b.loudnessRatio_natLog = log(experiment_1b_data.loudness_ratio);
% standard error
HA3.part_1a.geoSEM = std(HA3.part_1a.loudnessRatio_natLog,0,1) ./ sqrt(length(HA3.part_1a.loudnessRatio_natLog));
HA3.part_1b.geoSEM = std(HA3.part_1b.loudnessRatio_natLog,0,1) ./ sqrt(length(HA3.part_1b.loudnessRatio_natLog));
% T-score
HA3.part_1a.geots = tinv(1-p/2, length(length(HA3.part_1a.loudnessRatio_natLog)));
HA3.part_1b.geots = tinv(1-p/2, length(length(HA3.part_1b.loudnessRatio_natLog)));
% confidence interval
HA3.part_1a.geoCI = [exp(HA3.part_1a.loudnessRatio_geoMean - HA3.part_1a.geots .* HA3.part_1a.geoSEM); exp(HA3.part_1a.loudnessRatio_geoMean + HA3.part_1a.geots .* HA3.part_1a.geoSEM)];
HA3.part_1b.geoCI = [exp(HA3.part_1b.loudnessRatio_geoMean - HA3.part_1b.geots .* HA3.part_1b.geoSEM); exp(HA3.part_1b.loudnessRatio_geoMean + HA3.part_1b.geots .* HA3.part_1b.geoSEM)];

part_1a_loudStat = cat(1, HA3.part_1a.loudnessRatio_mean, HA3.part_1a.CI, HA3.part_1a.loudnessRatio_geoMean, HA3.part_1a.geoCI);
part_1b_loudStat = cat(1, HA3.part_1b.loudnessRatio_mean, HA3.part_1b.CI, HA3.part_1b.loudnessRatio_geoMean, HA3.part_1b.geoCI);
%save('exp_1a_rel_loud_stat', 'part_1a_loudStat');
%save('exp_1b_rel_loud_stat', 'part_1b_loudStat');

% errorbar 1a
x_1a = [1 2 3 4 5 6 7 8 9];
y_1a = part_1a_loudStat(1,:);
neg_1a = part_1a_loudStat(1,:) - part_1a_loudStat(2,:);
pos_1a = part_1a_loudStat(3,:) - part_1a_loudStat(1,:);
%errorbar(x_1a,y_1a,neg_1a,pos_1a)

% errorbar 1a, geo
x_1a_geo = [1 2 3 4 5 6 7 8 9];
y_1a_geo = part_1a_loudStat(4,:);
neg_1a_geo = part_1a_loudStat(4,:) - part_1a_loudStat(5,:);
pos_1a_geo = part_1a_loudStat(6,:) - part_1a_loudStat(4,:);
%errorbar(x_1a_geo,y_1a_geo,neg_1a_geo,pos_1a_geo)

% errorbar 1b
x_1b = [1 2 3 4 5 6 7 8 9];
y_1b = part_1a_loudStat(1,:);
neg_1b = part_1b_loudStat(1,:) - part_1b_loudStat(2,:);
pos_1b = part_1b_loudStat(3,:) - part_1b_loudStat(1,:);
%errorbar(x_1b,y_1b,neg_1b,pos_1b)

% errorbar 1b, geo
x_1b_geo = [1 2 3 4 5 6 7 8 9];
y_1b_geo = part_1b_loudStat(4,:);
neg_1b_geo = part_1b_loudStat(4,:) - part_1b_loudStat(5,:);
pos_1b_geo = part_1b_loudStat(6,:) - part_1b_loudStat(4,:);
%errorbar(x_1b_geo,y_1b_geo,neg_1b_geo,pos_1b_geo)

%t-test
hh = ttest2(experiment_1a_data.loudness_ratio,experiment_1a_data.loudness_ratio,'dim',1);



% EXPERIMENT 2 AND 3
% convert all 5x5 matrices from AB to 01, add them all up, then average it
% over all participants to get participant result, preference matrix and
% overall preference

HA3.part_2.pcData = experiment_2_data.pc_data;

for i = 1:20
    HA3.part_2.pcData01 = strcmpi(HA3.part_2.pcData(i), A);
end

HA3.part_2.pcData(1);


