function [posterior,out,b] = defeatVBA(id,data,graphics,save_results)

%% fits defeat task rl model to defeat task subject data using VBA toolbox
% example call:
% [posterior,out]=defeatVBA(id, multinomial,multisession, saveresults, graphics)
% id:           6-digit subject id from subject database
% multinomial:  if 1 fits p_chosen from the softmax; continuous RT (multinomial=0) works less well
% multisession: treats runs/conditions as separate, helps fit (do not allow X0 to vary though)
% fixed_params_across_runs -- self-explanatoryr
% n_steps:      number of time bins
%%
close all

%% Where to look for data
%Quick username check, and path setting

[~, me] = system('whoami');
me = strtrim(me);
if save_results
    file_path = 'vba_output';
else
    error('something went wrong with the vba output dir!')
end

%Turn graphics on or off
if ~graphics
    options.DisplayWin = 0;
    options.GnFigs = 0;
end
%% set up dim defaults

n_phi = 1; %Number of observation params (Bias)
f_name = @f_defeat_Qlearn; %Evolution function
g_name = @g_defeat_softmax; %Observation function
n_t = 32; %Total number of trials
% n_runs = 3; %3 blocks total
n_hidden_states = 1; %Track value for rank

%% Load in the subject's data
%u is a 1 row vector with rank decision as an action (high, or low)
%b.id = id;
u(1,:) = subjects_actions; %Chosen action [1 2 3]
u = [zeros(size(u,1),1) u(:,1:end-1)]; %Shift the u!

y = zeros(3, n_t);
for i = 1:n_t
    try
        y(subjects_actions(i), i) = 1;
    catch
        y(:,i) = nan;
    end
end

%% set up models within evolution/observation Fx
% options.inF.b = b;
% options.inG.b = b;

%% skip first trial
options.skipf = zeros(1,n_t);
options.skipf(1) = 1;

options.binomial = 1;


%% defined number of hidden states and parameters
dim = struct('n',n_hidden_states,'n_theta',n_theta,'n_phi',n_phi, 'n_t', n_t);

%% priors
priors.muPhi = zeros(dim.n_phi,1);
priors.muTheta = zeros(dim.n_theta,1);
priors.muX0 = zeros(n_hidden_states,1);
priors.SigmaTheta = 1e1*eye(dim.n_theta);
%priors.SigmaPhi = diag([1,1,1]);
priors.SigmaPhi = 1e1*eye(dim.n_phi);
priors.SigmaX0 = 0*eye(dim.n);
priors.a_alpha = Inf;
priors.b_alpha = 0;
priors.a_sigma = 1;     % Jeffrey's prior
priors.b_sigma = 1;     % Jeffrey's prior

options.priors = priors;
%options.inG.priors = priors; %copy priors into inG for parameter transformation (e.g., Gaussian -> uniform)

%% Last bit of option declarations
options.TolFun = 1e-6;
options.GnTolFun = 1e-6;
options.verbose=1;

%Censor any bad trials
options.isYout = repmat(censor,1,3)';
options.inF.Yout = options.isYout;

%% Run the vba model
[posterior,out] = VBA_NLStateSpaceModel(y,u,f_name,g_name,dim,options);

if save_results
    file_name = sprintf('id_%d_defeat_vba_output',id);
    file_str = [file_path filesep file_name];
    save(file_str,'posterior', 'out', 'b')
end