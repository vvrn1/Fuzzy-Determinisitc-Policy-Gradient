function [ nAngle ] = normalizeAngle( Angle )

% This function normalizes an angle in the interval [-pi, pi]

% Angle  ... An angle (this may be any value)
% nAngle ... An angle in the interval [-pi,pi]

nAngle = mod(Angle,2*pi) ;

if (nAngle > pi)
    nAngle = nAngle - 2*pi ;
end