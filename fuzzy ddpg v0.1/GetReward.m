function [ r , f ] = GetReward( NextSp , NextSe , Sp , Se , T )
% This function calculate the reward.

% r      ... the reward value.
% f      ... true if the goal is reached, otherwise it is false.
% NextSp ... the next position of the pursuer.
% NextSe ... the next position of the evader.
% Sp     ... the current position of the pursuer.
% Se     ... the current position of the evader.
% T      ... the sampling time.

% Compute the current distance between the pursuer and the evader (eq. 18)
D     = sqrt((Sp(1:2)-Se(1:2))'*(Sp(1:2)-Se(1:2))) ;
% Compute the next distance between the pursuer and the evader (eq. 18)
NextD = sqrt((NextSp(1:2)-NextSe(1:2))'*(NextSp(1:2)-NextSe(1:2))) ;
% calculate the differences between the two distances (eq. 19)
DeltaD = D - NextD ;
% Calculate the maximum value of that difference (eq. 20)
DeltaDmax = 3*T ;
% calculate the reward (eq. 21)
r = DeltaD/ DeltaDmax ; 
f = 0 ;
% the condition for reaching the goal
if ( D < 0.10 )
    f = 1  ;
end