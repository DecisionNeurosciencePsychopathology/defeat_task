function create_dummy_defeat_data

number_of_subjs = 100;
load('design_master.mat')
n_trials = 32;
u = 1:32;
starting_rank=10;
for i = 1:number_of_subjs
    for j = 1:n_trials
        trial_type = design_master{1,j};
        rew=design_master{2,j};
        if j==1
            u(2,1) = get_next_rank(starting_rank,rew,trial_type,'null');
        else
            u(2,j) = get_next_rank(u(2,j-1),rew,trial_type,'null');
        end    
    end
    save(sprintf('dummy_data/subject_%d.mat',i),'u')
end
    
    
u(2,:)=[];
%Create always low subject
for j = 1:n_trials
    trial_type = design_master{1,j};
    rew=design_master{2,j};
    if j==1
        u(2,1) = get_next_rank(starting_rank,rew,trial_type,'lowest');
    else
        u(2,j) = get_next_rank(u(2,j-1),rew,trial_type,'lowest');
    end
end
save(sprintf('subject_always_low.mat'),'u')


u(2,:)=[];
%Create always low subject
for j = 1:n_trials
    trial_type = design_master{1,j};
    rew=design_master{2,j};
    if j==1
        u(2,1) = get_next_rank(starting_rank,rew,trial_type,'highest');
    else
        u(2,j) = get_next_rank(u(2,j-1),rew,trial_type,'highest');
    end
end
save(sprintf('subject_always_high.mat'),'u')