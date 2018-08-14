function [actorvars,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput] = updateActor(actorvars,criticvars,batch,batch_size,tt,s_Usigma,r_Usigma,s_UMu,r_UMu,s_Uoutput,r_Uoutput,lc_u)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mini-batch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[grad_USigma,grad_UMu,grad_UK] = gradients(batch,batch_size,actorvars,criticvars);
% actorvars.Sigma = actorvars.Sigma + lr_actor * grad_Sigma/batch_size;%%%%%%%%%%%% (+ or - ?????????)
% actorvars.Mu = actorvars.Mu + lr_actor * grad_Mu/batch_size;
% actorvars.Output = actorvars.Output + lr_actor * grad_K/batch_size;
gradient_Usigma = grad_USigma /batch_size;
gradient_UMu = grad_UMu /batch_size ;
gradient_Uoutput = grad_UK /batch_size ;
[update_Usigma,s_Usigma,r_Usigma] = adam(gradient_Usigma,0.001,s_Usigma,r_Usigma,tt);
[update_UMu,s_UMu,r_UMu] = adam(gradient_UMu,0.001,s_UMu,r_UMu,tt);
[update_Uoutput,s_Uoutput,r_Uoutput] = adam(gradient_Uoutput,0.001,s_Uoutput,r_Uoutput,tt);
% update_Usigma  =  -lc_u * gradient_Usigma     ;
% update_UMu     =  -lc_u * gradient_UMu     ;
% update_Uoutput =  -lc_u * gradient_Uoutput     ;

% critic_Q = critic([batch(i,1);batch(i,2)],batch(i,3),criticvars);
actorvars.Sigma = actorvars.Sigma - update_Usigma;%%%%%%%%%%%% (+ or - ?????????)
actorvars.Mu = actorvars.Mu - update_UMu;
actorvars.Output = actorvars.Output - update_Uoutput;
actorvars.Sigma(actorvars.Sigma < 0.1) =0.1;
actorvars.Mu(actorvars.Mu < -1) =-1;

actorvars.Mu(actorvars.Mu > 1) =1;
if isinf(actorvars.Sigma )
disp('error')
end 