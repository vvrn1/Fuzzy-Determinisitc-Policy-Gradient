function [dUdSigma, dUdMu, dUdK] = u_grad(State,sigma, mu , output)

A1 = GetMF(State(1,1),sigma(1,1),mu(1,1)) ;
A2 = GetMF(State(1,1),sigma(2,1),mu(2,1)) ;
A3 = GetMF(State(1,1),sigma(3,1),mu(3,1)) ;
B1 = GetMF(State(2,1),sigma(4,1),mu(4,1)) ;
B2 = GetMF(State(2,1),sigma(5,1),mu(5,1)) ;
B3 = GetMF(State(2,1),sigma(6,1),mu(6,1)) ;

Z(1,1) = A1 * B1 ;
Z(2,1) = A1 * B2 ;
Z(3,1) = A1 * B3 ;
Z(4,1) = A2 * B1 ;
Z(5,1) = A2 * B2 ;
Z(6,1) = A2 * B3 ;
Z(7,1) = A3 * B1 ;
Z(8,1) = A3 * B2 ;
Z(9,1) = A3 * B3 ;

a = output'*Z ;
b = sum(Z) ;
c = a/b ;

dUdK = Z/b ;

dUdSigma(1,1)   = ((output(1:3,1)-c)/b)'*Z(1:3,1)*2*(State(1,1)-mu(1,1))^2/(sigma(1,1))^3 ;
dUdSigma(2,1)   = ((output(4:6,1)-c)/b)'*Z(4:6,1)*2*(State(1,1)-mu(2,1))^2/(sigma(2,1))^3 ;
dUdSigma(3,1)   = ((output(7:9,1)-c)/b)'*Z(7:9,1)*2*(State(1,1)-mu(3,1))^2/(sigma(3,1))^3 ;
dUdSigma(4,1)   = ((output(1:3:9,1)-c)/b)'*Z(1:3:9,1)*2*(State(2,1)-mu(4,1))^2/(sigma(4,1))^3 ;
dUdSigma(5,1)   = ((output(2:3:9,1)-c)/b)'*Z(2:3:9,1)*2*(State(2,1)-mu(5,1))^2/(sigma(5,1))^3 ;
dUdSigma(6,1)   = ((output(3:3:9,1)-c)/b)'*Z(3:3:9,1)*2*(State(2,1)-mu(6,1))^2/(sigma(6,1))^3 ;

dUdMu   (1,1)   = ((output(1:3,1)-c)/b)'*Z(1:3,1)*2*(State(1,1)-mu(1,1))/(sigma(1,1))^2 ;
dUdMu   (2,1)   = ((output(4:6,1)-c)/b)'*Z(4:6,1)*2*(State(1,1)-mu(2,1))/(sigma(2,1))^2 ;
dUdMu   (3,1)   = ((output(7:9,1)-c)/b)'*Z(7:9,1)*2*(State(1,1)-mu(3,1))/(sigma(3,1))^2 ;
dUdMu   (4,1)   = ((output(1:3:9,1)-c)/b)'*Z(1:3:9,1)*2*(State(2,1)-mu(4,1))/(sigma(4,1))^2 ;
dUdMu   (5,1)   = ((output(2:3:9,1)-c)/b)'*Z(2:3:9,1)*2*(State(2,1)-mu(5,1))/(sigma(5,1))^2 ;
dUdMu   (6,1)   = ((output(3:3:9,1)-c)/b)'*Z(3:3:9,1)*2*(State(2,1)-mu(6,1))/(sigma(6,1))^2 ;

dUdK = 0.5* dUdK * sech(c)^2;
dUdSigma = 0.5* dUdSigma * sech(c)^2;
dUdMu = 0.5* dUdMu * sech(c)^2;