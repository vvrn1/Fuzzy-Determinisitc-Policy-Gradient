%% critic output
function Qoutput = critic(State,Action,criticvars)
sigma = criticvars.Sigma;
mu = criticvars.Mu;
K = criticvars.Output;
Qoutput = GetCritic(State,Action,sigma,mu,K);