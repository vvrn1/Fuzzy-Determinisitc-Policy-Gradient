%% Main Train Script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author:WangMaolin
% Date:2018.04
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
warning off ;
clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reinforcement Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Gamma = 0.9;
tau = 0.001;
MaxEpisode = 100;
MaxSteps = 600;
% lr_critic = 0.001;
% lr_actor = 0.0001;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Adam Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s_Qsigma = zeros(9,1);
r_Qsigma = zeros(9,1);
s_QMu = zeros(9,1);
r_QMu = zeros(9,1);
s_Qoutput = zeros(27,1);
r_Qoutput = zeros(27,1);
s_Usigma = zeros(6,1);
r_Usigma = zeros(6,1);
s_UMu = zeros(6,1);
r_UMu = zeros(6,1);
s_Uoutput = zeros(9,1);
r_Uoutput = zeros(9,1);
tt = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create action & action target FIS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
actorvars = createActor();
actorTargetvars = createActorTarget(actorvars);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create critic & critic target FIS 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
criticvars = createCritic();
criticTargetvars = createCriticTarget(criticvars);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize Replay Buffer 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ReplayBuffer = [];
best_policy = actorvars;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% episode Start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:MaxEpisode
     [actorvars,criticvars,actorTargetvars, criticTargetvars,ReplayBuffer,MeanReward,tt,s_Qsigma,r_Qsigma , s_QMu,r_QMu , s_Qoutput,r_Qoutput,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput,loss,TotalReward] = ...
    epsiode(i,MaxSteps,Gamma,tau,actorvars,criticvars,actorTargetvars, criticTargetvars,ReplayBuffer,tt,s_Qsigma,r_Qsigma , s_QMu,r_QMu , s_Qoutput,r_Qoutput,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput);
     MR(i,1) = MeanReward;
     TR(i,1) = TotalReward;
     Loss(i,1) = loss;
     best_policy = evaluate(actorvars, best_policy);
    if isequal(actorvars,best_policy)
        disp(['New Best Policy!!! in Episode  ',  num2str(i)]);
        CreateFis(best_policy.Range,best_policy.Sigma,best_policy.Mu,best_policy.Output,'actor') ;

    end


end