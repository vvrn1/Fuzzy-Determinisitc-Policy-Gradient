%% define a actor FIS
function actorvars = createActor()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
actorvars.Range = 1.0 * [-1.0;1.0;-1.0;1.0;-1.0;1.0];
actorvars.Sigma = 0.4 * ones(6,1);
actorvars.Mu    = 1.0 * [-1.0;0.0;1.0;-1.0;0.0;1.0];
actorvars.Output = 1.0*[-1.0;-0.5;0.0;-0.5;0.0;0.5;0.0;0.5;1.0] ;
CreateFis(actorvars.Range,actorvars.Sigma,actorvars.Mu,actorvars.Output ,'actorFIS') ;