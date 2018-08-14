function best_policy = evaluate(current_policy, best_policy)
n_games = 10;
win  = 0;
lose = 0;
draw = 0;
for i = 1:n_games
    
    [ Vp , Upmax , L1 , Ve , Uemax , L2 ] = PEParameters() ;
    Sp_ini  = [0;0;0];             % the initial position and orientation vector of the pursuer (x,y,theta)
    ISe_ini = [(2*randint-1)*ceil(4*rand+3);(2*randint-1)*ceil(4*rand+3)] ;  % the initial position of the evader  (x,y)
    % ISe = [7;5] ;  % the initial position of the evader  (x,y)
    Se_ini  = [ISe_ini;0];
    
    I = 500 ; %the iteration numbers
    T = 0.1 ; % the sampling time
    e = 0.0;
    rr= 1.0 ;
    Sp = Sp_ini;
    Se = Se_ini;
    for i=0:1:I
        % the distance vector between the two robots
        Dep=Se(1:2)-Sp(1:2) ;
        % the catching condition
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Next States of the Evader
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Ue      = normalizeAngle(atan2(Dep(2),Dep(1))-Se(3));
        if Ue > Uemax , Ue = Uemax ; elseif Ue < -Uemax , Ue = -Uemax ; end
        NextSe(3,1)   = normalizeAngle(Se(3) + T*Ve*tan(Ue)/L2) ;
        Sedot   = [Ve*cos(NextSe(3));Ve*sin(NextSe(3));Ve*tan(Ue)/L2] ;
        NextSe(1:2,1) = Se(1:2) + Sedot(1:2)*T ;
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
        
        Up = actor(State,current_policy);
        if Up > Upmax , Up = Upmax ; elseif Up < -Upmax , Up = -Upmax ; end
        NextSp(3,1)   = normalizeAngle(Sp(3) + T*Vp*tan(Up)/L1) ;
        Spdot   = [Vp*cos(NextSp(3));Vp*sin(NextSp(3));Vp*tan(Up)/L1] ;
        NextSp(1:2,1) = Sp(1:2) + Spdot(1:2)*T ;
        
        %         Spp(:,i+1) = Sp(1:2,1) ; See(:,i+1) = Se(1:2,1) ;
        [~,Terminal]       = GetReward(NextSp,NextSe,Sp,Se,T) ;
        
        if Terminal
            break
        end
        Se = NextSe;
        Sp = NextSp;
    end
    Tc1=i*T ;
    %%
    I = 500 ; %the iteration numbers
    T = 0.1 ; % the sampling time
    e = 0.0;
    rr= 1.0 ;
    Sp = Sp_ini;
    Se = Se_ini;
    for i=0:1:I
        % the distance vector between the two robots
        Dep=Se(1:2)-Sp(1:2) ;
        % the catching condition
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Next States of the Evader
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Ue      = normalizeAngle(atan2(Dep(2),Dep(1))-Se(3));
        if Ue > Uemax , Ue = Uemax ; elseif Ue < -Uemax , Ue = -Uemax ; end
        NextSe(3,1)   = normalizeAngle(Se(3) + T*Ve*tan(Ue)/L2) ;
        Sedot   = [Ve*cos(NextSe(3));Ve*sin(NextSe(3));Ve*tan(Ue)/L2] ;
        NextSe(1:2,1) = Se(1:2) + Sedot(1:2)*T ;
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
        
        Up = actor(State,best_policy);
        if Up > Upmax , Up = Upmax ; elseif Up < -Upmax , Up = -Upmax ; end
        NextSp(3,1)   = normalizeAngle(Sp(3) + T*Vp*tan(Up)/L1) ;
        Spdot   = [Vp*cos(NextSp(3));Vp*sin(NextSp(3));Vp*tan(Up)/L1] ;
        NextSp(1:2,1) = Sp(1:2) + Spdot(1:2)*T ;
        
        %         Spp(:,i+1) = Sp(1:2,1) ; See(:,i+1) = Se(1:2,1) ;
        [~,Terminal]       = GetReward(NextSp,NextSe,Sp,Se,T) ;
        
        if Terminal
            break
        end
        Se = NextSe;
        Sp = NextSp;
    end
    Tc2=i*T ;
    %%
    if Tc1 < Tc2
        win = win+1;
    elseif Tc1 > Tc2
        lose = lose +1;
    else
        draw = draw +1;
    end
    
end
if win> lose + 0.5*draw
    best_policy = current_policy;
end