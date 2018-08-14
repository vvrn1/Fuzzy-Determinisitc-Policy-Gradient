function dQda =  Qgrad2(State, Action,criticvars)
ee = 0.001;
Q1 = critic(State,Action-ee,criticvars);
Q2 = critic(State,Action+ee,criticvars);
dQda = (Q2-Q1)/(2*ee);