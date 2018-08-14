function [grad_Sigma,grad_Mu,grad_K] = gradients(batch,batch_size,actorvars,criticvars)
sigma = actorvars.Sigma ;
mu = actorvars.Mu ;
output = actorvars.Output;
% grad = [0 , 0 , 0];
grad_Sigma = zeros(6,1);
grad_Mu = zeros(6,1);
grad_K = zeros(9,1);
for i = 1: batch_size
    action = actor([batch(i,1);batch(i,2);batch(i,3)],actorvars);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute dQda
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dQda = Qgrad([batch(i,1);batch(i,2)], action, criticvars);
%     dQda2 = Qgrad2([batch(i,1);batch(i,2)], action, criticvars);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % compute dadphi
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [dUdSigma, dUdMu, dUdK] = u_grad([batch(i,1);batch(i,2)],sigma, mu , output);
%     [dUdSigma2, dUdMu2, dUdK2] = u_grad2([batch(i,1);batch(i,2)],sigma, mu , output);
%     grad = grad + dQda * [dUdK,dUdSigma,dUdMu];
    grad_Sigma = grad_Sigma + dQda * dUdSigma;
    grad_Mu    = grad_Mu + dQda * dUdMu;
    grad_K     = grad_K + dQda * dUdK;
    
end
    
   