close all

all_sim_rank = [];
for i = 1:100
    load(sprintf('dummy_data/subject_%d.mat',i))
    all_sim_rank = [all_sim_rank; u(2,:)];
end

figure(1)
surf(all_sim_rank)

figure(2)
plot(mean(all_sim_rank))

figure(3)
plot(var(all_sim_rank))