%% define a critic FIS
function criticvars = createCritic()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
criticvars.Range = 1.0 * [-1.0;1.0;-1.0;1.0;-1.0;1.0;-0.5;0.5];
criticvars.Sigma = 0.4 * ones(9,1);
criticvars.Mu    = 1.0 * [-1.0;0.0;1.0;-1.0;0.0;1.0;-1.0;0.0;1.0];
criticvars.Output = 0.0*zeros(27,1);
CreateFis(criticvars.Range,criticvars.Sigma,criticvars.Mu,criticvars.Output ,'criticFIS') ;