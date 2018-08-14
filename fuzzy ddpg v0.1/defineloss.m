function y = defineloss(batch,actorTargetvars, criticTargetvars,Gamma)
y = updatey(batch,actorTargetvars, criticTargetvars,Gamma); 
% critic_Q = critic([batch(:,1);batch(:,2)],criticvars);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define loss 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% loss = 1/batch_size *sum((y - critic_Q)^2);