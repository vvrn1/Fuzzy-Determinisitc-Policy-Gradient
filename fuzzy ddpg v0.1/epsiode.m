%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Every Epsiode
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [actorvars,criticvars,actorTargetvars, criticTargetvars,ReplayBuffer,MeanReward,tt,s_Qsigma,r_Qsigma , s_QMu,r_QMu , s_Qoutput,r_Qoutput,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput,loss,TotalReward] = ...
    epsiode(i,MaxSteps,Gamma,tau,actorvars,criticvars,actorTargetvars, criticTargetvars,ReplayBuffer,tt,s_Qsigma,r_Qsigma , s_QMu,r_QMu , s_Qoutput,r_Qoutput,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Epsiode Paarameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T         = 0.1 ;                              % Sampling time
steps       = 0  ;
% tt          = 1;
TotalReward = 0  ;
buffer_size = 10000;
batch_size = 32;
lc_q = 0.01-0.009*(i/50);
lc_u = 0.1* lc_q;
% s_Qsigma = zeros(9,1);
% r_Qsigma = zeros(9,1);
% s_QMu = zeros(9,1);
% r_QMu = zeros(9,1);
% s_Qoutput = zeros(27,1);
% r_Qoutput = zeros(27,1);
% s_Usigma = zeros(6,1);
% r_Usigma = zeros(6,1);
% s_UMu = zeros(6,1);
% r_UMu = zeros(6,1);
% s_Uoutput = zeros(9,1);
% r_Uoutput = zeros(9,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Random Process
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m         = 0.08 ;
Success   = 0.0 ;
epsilon   = 0.1/i;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initial observation state s1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sp  = [0;0;0];             % the initial position and orientation vector of the pursuer (x,y,theta)
ISe = [(2*randint-1)*ceil(4*rand+3);(2*randint-1)*ceil(4*rand+3)] ;  % the initial position of the evader  (x,y)
% ISe = [7;5] ;  % the initial position of the evader  (x,y)
Se  = [ISe;0] ; % the initial position and orientation vector of the evader  (x,y,theta)

State(1,1) = atan2(Se(2)-Sp(2),Se(1)-Sp(1)) ;  % the initial state vector (e,de)
State(2,1) = State(1,1)/T ;
rr = 1.0 ;
if State(1,1) >  rr , State(1,1) =  rr ; end
if State(1,1) < -rr , State(1,1) = -rr ; end
if State(2,1) >  rr , State(2,1) =  rr ; end
if State(2,1) < -rr , State(2,1) = -rr ; end
% if exist('fig1')
%     delete(fig1)
% end
% fig1 = figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Step Start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for steps = 1:MaxSteps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Select Action
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    Noise = sqrt(m)*randn*epsilon;
    FLCAction = actor(State,actorvars);
    ActionBar = FLCAction + Noise;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Execute Action and Observe reward rt and observe new state st+1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    [State, Reward, Terminal, NextState, NextSp, NextSe] = transition(State, ActionBar ,Se, Sp, T);
    TotalReward = TotalReward + Reward;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store transition (st,at,rt,st+1) in replay buffer R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    experience = [State(1), State(2), ActionBar, FLCAction, Reward, Terminal, NextState(1),NextState(2)];
    [ReplayBuffer,buffer_count] = updateReplayBuffer(experience,buffer_size,ReplayBuffer);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store transition (st,at,rt,st+1) in replay buffer R
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    if (buffer_count >= batch_size)
        buffer_index = randperm(buffer_count,batch_size);
        batch = ReplayBuffer(buffer_index,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Update Process 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        y = defineloss(batch,actorTargetvars, criticTargetvars,Gamma);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update critic (***********May Have Problems********)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%         criticvars = fmin_adam(@defineloss,criticvars);
        [criticvars, ~,s_Qsigma,r_Qsigma , s_QMu,r_QMu , s_Qoutput,r_Qoutput,Q] = ...
            UpdateQ(y,criticvars,batch_size,batch,tt,s_Qsigma,r_Qsigma,s_QMu,r_QMu , s_Qoutput,r_Qoutput,lc_q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update actor (***********May Have Problems********)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        [actorvars,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput] =  ...
            updateActor(actorvars,criticvars,batch,batch_size,tt,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput,lc_u);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update target (***********May Have Problems********)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        criticTargetvars.Sigma = tau * criticvars.Sigma + (1 - tau) *criticTargetvars.Sigma;
        criticTargetvars.Mu = tau * criticvars.Mu + (1 - tau) *criticTargetvars.Mu;
        criticTargetvars.Output = tau * criticvars.Output + (1 - tau) *criticTargetvars.Output;
        actorTargetvars.Sigma = tau * actorvars.Sigma + (1 - tau) *actorTargetvars.Sigma;
        actorTargetvars.Mu = tau * actorvars.Mu + (1 - tau) *actorTargetvars.Mu;
        actorTargetvars.Output = tau * actorvars.Output + (1 - tau) *actorTargetvars.Output;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% update state
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        tt = tt +1 ;


%         plot(Sp(1,1),Sp(2,1),'r.');drawnow
%         hold on
%         plot(Se(1,1),Se(2,1),'b*');drawnow
%         hold on
%        loss = sum((y - Q).^2)/batch_size;
% disp(['Episode:',num2str(i,'%03.f'),'    Step:',num2str(steps,'%03.f') '      Loss:  ',num2str(loss,'%3.3f')  '      Reward:  ',num2str(Reward,'%3.3f') ] ) ; 
    end
    Sp = NextSp;
    Se = NextSe;
    State = NextState;
    if Terminal
        break;
    end

end
% delete('fig1')
% CreateFis(criticvars.Range,criticvars.Sigma,criticvars.Mu,criticvars.Output,'critic') ;
MeanReward = TotalReward/steps;
loss = sum((y - Q).^2)/batch_size;
% CreateFis(actorvars.Range,actorvars.Sigma,actorvars.Mu,actorvars.Output,'actor') ;
disp(['Episode:',num2str(i,'%03.f'),'      Mean Reward:',num2str(TotalReward/steps,'%3.3f'),'     Loss',num2str(loss,'%1.4f'),' Done',num2str(Terminal,'%1.f'),'      Tc:',num2str(steps *T,'%2.2f')]) ;
% CreateFis(actorvars.Range,actorvars.Sigma,actorvars.Mu,actorvars.Output,'actor') ;
% disp(['Episode:',num2str(i,'%03.f'),'      Total Reward:',num2str(TotalReward,'%05.f'),'      Done',num2str(Terminal,'%05.f'),'      Tc:',num2str(steps *T,'%05.f')]) ;