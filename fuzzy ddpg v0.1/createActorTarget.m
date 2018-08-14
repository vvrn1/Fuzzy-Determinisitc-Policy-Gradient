%% create an actor target FIS
function actorTarget = createActorTarget(actorvars)
actorTarget = actorvars;
CreateFis(actorTarget.Range,actorTarget.Sigma,actorTarget.Mu,actorTarget.Output ,'actorTargetFIS') ;