function [ u ] = GetCritic ( State , Action, sigma , mu , K )


MuA1 = GetMF(State(1,1),sigma(1,1),mu(1,1)) ;
MuA2 = GetMF(State(1,1),sigma(2,1),mu(2,1)) ;
MuA3 = GetMF(State(1,1),sigma(3,1),mu(3,1)) ;
MuB1 = GetMF(State(2,1),sigma(4,1),mu(4,1)) ;
MuB2 = GetMF(State(2,1),sigma(5,1),mu(5,1)) ;
MuB3 = GetMF(State(2,1),sigma(6,1),mu(6,1)) ;
MuC1 = GetMF(Action,sigma(7,1),mu(7,1));
MuC2 = GetMF(Action,sigma(8,1),mu(8,1));
MuC3 = GetMF(Action,sigma(9,1),mu(9,1));

Omega(1,1) = MuA1 * MuB1 * MuC1 ;
Omega(2,1) = MuA1 * MuB1 * MuC2 ;
Omega(3,1) = MuA1 * MuB1 * MuC3 ;
Omega(4,1) = MuA1 * MuB2 * MuC1;
Omega(5,1) = MuA1 * MuB2 * MuC2;
Omega(6,1) = MuA1 * MuB2 * MuC3;
Omega(7,1) = MuA1 * MuB3 * MuC1;
Omega(8,1) = MuA1 * MuB3 * MuC2;
Omega(9,1) = MuA1 * MuB3 * MuC3;
Omega(10,1) = MuA2 * MuB1 * MuC1 ;
Omega(11,1) = MuA2 * MuB1 * MuC2 ;
Omega(12,1) = MuA2 * MuB1 * MuC3 ;
Omega(13,1) = MuA2 * MuB2 * MuC1;
Omega(14,1) = MuA2 * MuB2 * MuC2;
Omega(15,1) = MuA2 * MuB2 * MuC3;
Omega(16,1) = MuA2 * MuB3 * MuC1;
Omega(17,1) = MuA2 * MuB3 * MuC2;
Omega(18,1) = MuA2 * MuB3 * MuC3;
Omega(19,1) = MuA3 * MuB1 * MuC1 ;
Omega(20,1) = MuA3 * MuB1 * MuC2 ;
Omega(21,1) = MuA3 * MuB1 * MuC3 ;
Omega(22,1) = MuA3 * MuB2 * MuC1;
Omega(23,1) = MuA3 * MuB2 * MuC2;
Omega(24,1) = MuA3 * MuB2 * MuC3;
Omega(25,1) = MuA3 * MuB3 * MuC1;
Omega(26,1) = MuA3 * MuB3 * MuC2;
Omega(27,1) = MuA3 * MuB3 * MuC3;

S        = sum(Omega) ;
OmegaBar = Omega/S    ;
u = OmegaBar'*K ;