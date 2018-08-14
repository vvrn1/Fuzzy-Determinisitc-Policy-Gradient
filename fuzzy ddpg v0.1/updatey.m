function y = updatey(batch,actorTargetvars, criticTargetvars,Gamma)
% batch(1): states(1)

% batch(2): states(2)

% batch(3): action

% batch(4): actionoutput

% batch(5): reward

% batch(6): terminal

% batch(7): newstates(1)

% batch(8): newstates(2)

% action_target = actor([batch(:,6),batch(:,7)],actorTargetvars);
% critic_target = critic([batch(:,6);batch(:,7)],action_target(:),criticTargetvars);
for k = 1: length(batch)
    %     State = [batch(k,6);batch(k,7)];
    action_target(k) = actor([batch(k,7);batch(k,8)],actorTargetvars);
    critic_target(k) = critic([batch(k,7);batch(k,8)],action_target(k),criticTargetvars);
    if batch(k,6) == 1
        y(k) = batch(k,5);
    else
        y(k) = batch(k,5) + Gamma * critic_target(k);
    end
end