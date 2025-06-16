b_n = [0.1 1 10];
d_n = [0.2 2 5];
dt = 0.1; N = 20; I = 1;
time = dt;
time_b = [];
time_d = [];

S=N-I;
b = b_n(2);
d = d_n(2);
for i = 1:100
    t=0;
    tb = 0;
    td = 0;
    while (tb==0 || td==0)
        t=t+dt;
        r1 = rand();
        if tb==0 && r1 < b*dt
            time_b = [time_b time];
            time = 0.01;
            tb=t;
        end
        r2 = rand();
        if td==0 && r2 < d*dt
            time_d = [time_d time];
            time = 0.01;
            td=t;
        end
    end
    time = time + dt;
end

tb_mean = mean(time_b);
td_mean = mean(time_d);

subplot(1,2,1)
histogram(time_b)
subplot(1,2,2)
histogram(time_d)