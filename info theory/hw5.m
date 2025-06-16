clc;clear;
[pa,pb] = p_ab(0.2,100000);
data_table = readtable('pop_series.csv');
data = table2array(data_table);
[pa_data,pb_data] = p_ab_csv(data);

function mapValue = LogisticMap(x)
    r = 4;
    mapValue = r * x * (1-x);
end

function [pa,pb] = p_ab(x0,iterations)
    a_count = 0;
    b_count = 0;
    x = x0;

    for i = 1:iterations
        if x <= 0.5
            a_count = a_count + 1;
        else
            b_count = b_count + 1;
        end
        x = LogisticMap(x);
    end
    total = a_count + b_count;
    pa = a_count/total;
    pb = b_count/total;
end

function [pa,pb] = p_ab_csv(data)
    A_upper = 0.6004; A_lower = 0.324;
    B_upper = 0.9; B_lower = 0.7884864;
    a_count = 0;
    b_count = 0;
    data_length = length(data);

    for i = 1:data_length
        x = data(i);
        if x <= A_upper && x >= A_lower
            a_count = a_count + 1;
        end
        if x <= B_upper && x > B_lower
            b_count = b_count + 1;
        end
    end
    total = a_count + b_count;
    pa = a_count/total;
    pb = b_count/total;
end