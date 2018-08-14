function [criticvars, critic_Q,s_Qsigma,r_Qsigma , s_QMu,r_QMu , s_Qoutput,r_Qoutput,Q] = UpdateQ(y,criticvars,batch_size,batch,tt,s_Qsigma,r_Qsigma,s_QMu,r_QMu , s_Qoutput,r_Qoutput,lc_q)

Qsigma = criticvars.Sigma;
Qmu    = criticvars.Mu;
Qoutput= criticvars.Output;

% critic_grad = [];
for i = 1: batch_size
    Q(i) = critic([batch(i,1);batch(i,2)],batch(i,3),criticvars);
    [dQdSigma_temp, dQdMu_temp, dQdK_temp]  = critic_grad([batch(i,1);batch(i,2)],batch(i,3),Qsigma,Qmu,Qoutput);
% [dQdSigma_temp2, dQdMu_temp2, dQdK_temp2]  = critic_grad2([batch(i,1);batch(i,2)],batch(i,3),Qsigma,Qmu,Qoutput);
    dQdSigma(:,i) = dQdSigma_temp;
    dQdMu(:,i) = dQdMu_temp;
    dQdK(:,i) = dQdK_temp;
%     critic_grad = critic_grad + 
end


gradient_Qsigma = -2 /batch_size * ((y - Q) * dQdSigma')' ;
gradient_QMu = -2 /batch_size * ((y - Q) * dQdMu')' ;
gradient_Qoutput = -2 /batch_size * ((y - Q) * dQdK')' ;
[update_Qsigma,s_Qsigma,r_Qsigma] = adam(gradient_Qsigma,0.001,s_Qsigma,r_Qsigma,tt);
[update_QMu,s_QMu,r_QMu] = adam(gradient_QMu,0.001,s_QMu,r_QMu,tt);
[update_Qoutput,s_Qoutput,r_Qoutput] = adam(gradient_Qoutput,0.001,+s_Qoutput,r_Qoutput,tt);
% 
% update_Qsigma  =  lc_q * 2 /batch_size * ( (y - Q) * dQdSigma' )'     ;
% update_QMu     =  lc_q * 2 /batch_size * ( (y - Q) * dQdMu' )'     ;
% update_Qoutput =  lc_q * 2 /batch_size * ( (y - Q) * dQdK' )'     ;

% gradient_critic = (y-Q) * [dQdSigma';dQdMu';dQdK'];
% update_critic = adam(gradient_critic,s,r,steps);
% [Qsigma,Qmu,Qoutput] = [Qsigma,Qmu,Qoutput] +  update_critic;
criticvars.Sigma = Qsigma + update_Qsigma ;
criticvars.Mu    = Qmu + update_QMu  ;
criticvars.Output = Qoutput + update_Qoutput;
if isnan(criticvars.Sigma )
disp('error')
end
critic_Q = critic([batch(i,1);batch(i,2)],batch(i,3),criticvars);