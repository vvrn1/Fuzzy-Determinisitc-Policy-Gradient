%% create a critic target FIS
function criticTarget = createCriticTarget(criticvars)
criticTarget = criticvars;
CreateFis(criticTarget.Range,criticTarget.Sigma,criticTarget.Mu,criticTarget.Output ,'criticTargetFIS') ;