function [ u ] = GetAction ( State , sigma , mu , K )

MuA1 = GetMF(State(1,1),sigma(1,1),mu(1,1)) ;
MuA2 = GetMF(State(1,1),sigma(2,1),mu(2,1)) ;
MuA3 = GetMF(State(1,1),sigma(3,1),mu(3,1)) ;
MuB1 = GetMF(State(2,1),sigma(4,1),mu(4,1)) ;
MuB2 = GetMF(State(2,1),sigma(5,1),mu(5,1)) ;
MuB3 = GetMF(State(2,1),sigma(6,1),mu(6,1)) ;

Omega(1,1) = MuA1 * MuB1 ;
Omega(2,1) = MuA1 * MuB2 ;
Omega(3,1) = MuA1 * MuB3 ;
Omega(4,1) = MuA2 * MuB1 ;
Omega(5,1) = MuA2 * MuB2 ;
Omega(6,1) = MuA2 * MuB3 ;
Omega(7,1) = MuA3 * MuB1 ;
Omega(8,1) = MuA3 * MuB2 ;
Omega(9,1) = MuA3 * MuB3 ;

S        = sum(Omega) ;
OmegaBar = Omega/S    ;
u = 0.5*tanh(OmegaBar'*K) ;