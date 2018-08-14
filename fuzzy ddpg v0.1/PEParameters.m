function [ Vp , Upmax , L1 , Ve , Uemax , L2 ] = PEParameters

Vp    = 2.0 ; % the velocity of the pursuer
Upmax = 0.5 ; % the maximum steering angle of the pursuer
L1    = 0.3 ; % the turning radius for the pursuer

Ve    = 1.0 ; % the velocity of the evader
Uemax = 1.0 ; % the maximum steering angle of the evader
L2    = 0.3 ; % the turning radius of the evader