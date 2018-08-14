% This file give us the results of the GAs after tuning in stage 2 of phase 2 on the pursuit-evasion model
% This file contain a function called 'TSK' which computes the output of a FLC given its two inputs.
function [ Spp,See,Tc ] = pegFLC ( x , y , show )
warning off all ;

[ Vp , Upmax , L1 , Ve , Uemax , L2 ] = PEParameters() ;
Sp    = [0;0;0] ; % the initial position and orientation vector of the pursuer (x,y,theta)
ISe   = [x;y]   ; % You can choose a certain initial position for the evader
Se    = [ISe;0] ; % the initial position and orientation vector of the evader  (x,y,theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = 600 ; %the iteration numbers
T = 0.1 ; % the sampling time
e = 0.0 ; % the initial value of the error
rr= 1.0 ;
[sigma,mu,K] = GetFuzzyParameters('actor') ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=0:1:I
    % the distance vector between the two robots
    Dep=Se(1:2)-Sp(1:2) ;
    % the catching condition
    if sqrt(Dep'*Dep) < 0.1
        break;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Next States of the Evader
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Ue      = normalizeAngle(atan2(Dep(2),Dep(1))-Se(3));  
    if Ue > Uemax , Ue = Uemax ; elseif Ue < -Uemax , Ue = -Uemax ; end
    Se(3)   = normalizeAngle(Se(3) + T*Ve*tan(Ue)/L2) ;    
    Sedot   = [Ve*cos(Se(3));Ve*sin(Se(3));Ve*tan(Ue)/L2] ;
    Se(1:2) = Se(1:2) + Sedot(1:2)*T ;                      
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Next States of the Pursuer
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    E  = normalizeAngle(atan2(Dep(2),Dep(1))-Sp(3)) ;
    de = (E - e)/T ;                    
    State = [E;de] ;
    e  = E ;
    
    if State(1,1) >  rr , State(1,1) =  rr ; end
    if State(1,1) < -rr , State(1,1) = -rr ; end
    if State(2,1) >  rr , State(2,1) =  rr ; end
    if State(2,1) < -rr , State(2,1) = -rr ; end
    
    Up = GetAction(State,sigma,mu,K) ;
    if Up > Upmax , Up = Upmax ; elseif Up < -Upmax , Up = -Upmax ; end
    Sp(3)   = normalizeAngle(Sp(3) + T*Vp*tan(Up)/L1) ;     
    Spdot   = [Vp*cos(Sp(3));Vp*sin(Sp(3));Vp*tan(Up)/L1] ;
    Sp(1:2) = Sp(1:2) + Spdot(1:2)*T ;
    
    Spp(:,i+1) = Sp(1:2,1) ; See(:,i+1) = Se(1:2,1) ;
end
Tc=i*T ;
GetPlot(Spp,See,i,show) ;