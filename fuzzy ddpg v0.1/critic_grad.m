function [dQdSigma, dQdMu, dQdK] = critic_grad(State,Action,Qsigma,Qmu,Qoutput)


A1 = GetMF(State(1,1),Qsigma(1,1),Qmu(1,1)) ;
A2 = GetMF(State(1,1),Qsigma(2,1),Qmu(2,1)) ;
A3 = GetMF(State(1,1),Qsigma(3,1),Qmu(3,1)) ;
B1 = GetMF(State(2,1),Qsigma(4,1),Qmu(4,1)) ;
B2 = GetMF(State(2,1),Qsigma(5,1),Qmu(5,1)) ;
B3 = GetMF(State(2,1),Qsigma(6,1),Qmu(6,1)) ;
C1 = GetMF(Action,Qsigma(7,1),Qmu(7,1));
C2 = GetMF(Action,Qsigma(8,1),Qmu(8,1));
C3 = GetMF(Action,Qsigma(9,1),Qmu(9,1));

Z(1,1) = A1 * B1 * C1 ;
Z(2,1) = A1 * B1 * C2 ;
Z(3,1) = A1 * B1 * C3 ;
Z(4,1) = A1 * B2 * C1;
Z(5,1) = A1 * B2 * C2;
Z(6,1) = A1 * B2 * C3;
Z(7,1) = A1 * B3 * C1;
Z(8,1) = A1 * B3 * C2;
Z(9,1) = A1 * B3 * C3;
Z(10,1) = A2 * B1 * C1 ;
Z(11,1) = A2 * B1 * C2 ;
Z(12,1) = A2 * B1 * C3 ;
Z(13,1) = A2 * B2 * C1;
Z(14,1) = A2 * B2 * C2;
Z(15,1) = A2 * B2 * C3;
Z(16,1) = A2 * B3 * C1;
Z(17,1) = A2 * B3 * C2;
Z(18,1) = A2 * B3 * C3;
Z(19,1) = A3 * B1 * C1 ;
Z(20,1) = A3 * B1 * C2 ;
Z(21,1) = A3 * B1 * C3 ;
Z(22,1) = A3 * B2 * C1;
Z(23,1) = A3 * B2 * C2;
Z(24,1) = A3 * B2 * C3;
Z(25,1) = A3 * B3 * C1;
Z(26,1) = A3 * B3 * C2;
Z(27,1) = A3 * B3 * C3;

a = Qoutput'*Z ;
b = sum(Z) ;
c = a/b ;

dQdK = Z/b ;

dQdSigma(1,1)   = ((Qoutput(1:9,1)-c)/b)'*Z(1:9,1)*2*(State(1,1)-Qmu(1,1))^2/(Qsigma(1,1))^3 ;
dQdSigma(2,1)   = ((Qoutput(10:18,1)-c)/b)'*Z(10:18,1)*2*(State(1,1)-Qmu(2,1))^2/(Qsigma(2,1))^3 ;
dQdSigma(3,1)   = ((Qoutput(19:27,1)-c)/b)'*Z(19:27,1)*2*(State(1,1)-Qmu(3,1))^2/(Qsigma(3,1))^3 ;
dQdSigma(4,1)   = ((Qoutput([1:3,10:12,19:21],1)-c)/b)'*Z([1:3,10:12,19:21],1)*2*(State(2,1)-Qmu(4,1))^2/(Qsigma(4,1))^3 ;
dQdSigma(5,1)   = ((Qoutput([4:6,13:15,22:24],1)-c)/b)'*Z([4:6,13:15,22:24],1)*2*(State(2,1)-Qmu(5,1))^2/(Qsigma(5,1))^3 ;
dQdSigma(6,1)   = ((Qoutput([7:9,16:18,25:27],1)-c)/b)'*Z([7:9,16:18,25:27],1)*2*(State(2,1)-Qmu(6,1))^2/(Qsigma(6,1))^3 ;
dQdSigma(7,1)   = ((Qoutput(1:3:27,1)-c)/b)'*Z(1:3:27,1)*2*(Action-Qmu(7,1))^2/(Qsigma(7,1))^3 ;
dQdSigma(8,1)   = ((Qoutput(2:3:27,1)-c)/b)'*Z(2:3:27,1)*2*(Action-Qmu(8,1))^2/(Qsigma(8,1))^3 ;
dQdSigma(9,1)   = ((Qoutput(3:3:27,1)-c)/b)'*Z(3:3:27,1)*2*(Action-Qmu(9,1))^2/(Qsigma(9,1))^3 ;

dQdMu   (1,1)   = ((Qoutput(1:9,1)-c)/b)'*Z(1:9,1)*2*(State(1,1)-Qmu(1,1))/(Qsigma(1,1))^2 ;
dQdMu   (2,1)   = ((Qoutput(10:18,1)-c)/b)'*Z(10:18,1)*2*(State(1,1)-Qmu(2,1))/(Qsigma(2,1))^2 ;
dQdMu   (3,1)   = ((Qoutput(19:27,1)-c)/b)'*Z(19:27,1)*2*(State(1,1)-Qmu(3,1))/(Qsigma(3,1))^2 ;
dQdMu   (4,1)   = ((Qoutput([1:3,10:12,19:21],1)-c)/b)'*Z([1:3,10:12,19:21],1)*2*(State(2,1)-Qmu(4,1))/(Qsigma(4,1))^2 ;
dQdMu   (5,1)   = ((Qoutput([4:6,13:15,22:24],1)-c)/b)'*Z([4:6,13:15,22:24],1)*2*(State(2,1)-Qmu(5,1))/(Qsigma(5,1))^2 ;
dQdMu   (6,1)   = ((Qoutput([7:9,16:18,25:27],1)-c)/b)'*Z([7:9,16:18,25:27],1)*2*(State(2,1)-Qmu(6,1))/(Qsigma(6,1))^2 ;
dQdMu   (7,1)   = ((Qoutput(1:3:27,1)-c)/b)'*Z(1:3:27,1)*2*(Action-Qmu(7,1))/(Qsigma(7,1))^2 ;
dQdMu   (8,1)   = ((Qoutput(2:3:27,1)-c)/b)'*Z(2:3:27,1)*2*(Action-Qmu(8,1))/(Qsigma(8,1))^2 ;
dQdMu   (9,1)   = ((Qoutput(3:3:27,1)-c)/b)'*Z(3:3:27,1)*2*(Action-Qmu(9,1))/(Qsigma(9,1))^2 ;
if isnan(dQdK)
disp('error')
end
if isnan(dQdSigma)
disp('error')

end
if isnan(dQdMu)
disp('error')

end
