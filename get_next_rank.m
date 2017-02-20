function rank=get_next_rank(rank,rew,trial_type,behavior_mod)
%This function will simulate a subject's choice when playing the Social
%Dominance Paradigm,
%Input args
%rank = current rank
%rew  = win or loss for current trial
%trial_type  = 'free' , 'above(_forced)', 'below(_forced)', 'max_forced'
%Optional ARGs
%behavior_mod = if you want to be narsisstic or not

if nargin <= 3
    behavior_mod = 'null';
end

%Determine choices in nwhich subj could choose from
if strcmp('free',trial_type)
    choices = [-2,-1,1,2];
elseif strcmp('above',trial_type)
    choices = [1,2];
elseif strcmp('above_forced',trial_type)
    choices = 2;
elseif strcmp('below',trial_type)
    choices = [-1,-2];
elseif strcmp('below_forced',trial_type)
    choices = -2;
elseif strcmp('max_forced',trial_type)
    choices = [-2,2];
end

%Update opp. rank
rank_modifier  = get_choice(choices,behavior_mod);
opponent_rank = rank - rank_modifier;

%Restrict the min value
% if opponent_rank > 30
%     opponent_rank = 30;
% end

%N.B. We may want to track rank_mod in future, if so remember that if subj
%is at rank 28 then choice '30' should be coded as "-2"

%If appliciable update subj rank
if (rew==1 && rank > opponent_rank) || (rew==0 && rank < opponent_rank)
    rank = opponent_rank;
else 
    rank = rank;
end

function oppenent_rank=get_choice(choices,b_mod)

if strcmp(b_mod,'highest')
    %Alwasy pick the highest option
    oppenent_rank=max(choices);
elseif strcmp(b_mod,'lowest')
    %Always pick the lowest option
    oppenent_rank=min(choices);
else
    %Uniformly grab subject choice from available choices
    oppenent_rank=randsample(choices,1);
end