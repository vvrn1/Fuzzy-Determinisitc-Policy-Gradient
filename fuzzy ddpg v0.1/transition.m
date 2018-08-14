function [State, Reward, Terminal, NextState, NextSp, NextSe] = transition(State, Up ,Se, Sp, T)
% This function excutes the action , a, into the pursuit-evasion model "environment".

% State ... is the state of the system (e and ed).
% Action ... is the control action (gama_p) applied to the pursuer.
% Sp ... is the position and orientation vector of the pursuer (xp,yp,theta_p).
% Se ... is the position and orientation vector of the evader  (xe,ye,theta_e).
% T ... is the sampling time.
% NextState ... is the next state of the system.
% NextSp ... is the next position and orientation vector of the pursuer.
% NextSe ... is the next position and orientation vector of the evader (xp,yp,theta_p).

[ Vp , Upmax , L1 , Ve , Uemax , L2 ] = PEParameters ;

Dep = Se(1:2)-Sp(1:2) ; % the distance vector between the two robots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next States of the Evader
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ue            = normalizeAngle(atan2(Dep(2),Dep(1))-Se(3)) ;    % the steering angle of the evader (eq. 3)
if Ue > Uemax , Ue = Uemax ; elseif Ue < -Uemax , Ue = -Uemax ; end
NextSe(3,1)   = normalizeAngle(Se(3,1) + T*Ve*tan(Ue)/L2) ;       % the orientation of the evader (eq. 1)
Sedot         = [Ve*cos(Se(3,1));Ve*sin(Se(3,1));Ve*tan(Ue)/L2] ; % the dynamics of the evader (eq. 1)
NextSe(1:2,1) = Se(1:2,1) + Sedot(1:2,1)*T ;                      % the position of the evader (eq. 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Next States of the Pursuer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Up > Upmax , Up = Upmax ; elseif Up < -Upmax , Up = -Upmax ; end
NextSp(3,1)   = normalizeAngle(Sp(3,1) + T*Vp*tan(Up)/L1) ;                % the orientation of the pursuer (eq. 1)
Spdot         = [Vp*cos(NextSp(3,1));Vp*sin(NextSp(3,1));Vp*tan(Up)/L1 ] ; % the dynamics of the pursuer (eq. 1)
NextSp(1:2,1) = Sp(1:2,1) + T*Spdot(1:2,1) ;                               % the position of the pursuer (eq. 1)

NextState(1,1) = normalizeAngle(atan2(Dep(2),Dep(1))-Sp(3)) ;   % the next error (eq. 13)
NextState(2,1) = (NextState(1,1) - State(1,1) )/T ; % the derivative of the error 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get Reward
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rr =1.0;
if NextState(1,1) >  rr , NextState(1,1) =  rr ; end
if NextState(1,1) < -rr , NextState(1,1) = -rr ; end
if NextState(2,1) >  rr , NextState(2,1) =  rr ; end
if NextState(2,1) < -rr , NextState(2,1) = -rr ; end

% observe the reward
[Reward,Terminal]       = GetReward(NextSp,NextSe,Sp,Se,T) ;
% Action = Up;