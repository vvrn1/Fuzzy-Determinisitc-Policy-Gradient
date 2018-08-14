function CreateFis ( ranges , sigma , mu , parameters , FileName )
% This function calculate the fuzzy output given all the parameters of the
% inputs and the output variables.
sigma = sigma/sqrt(2);
a = newfis(FileName,'sugeno','prod','probor','prod','sum','wtaver') ;
a.input(1).name='e';
a.input(1).range=[ranges(1) ranges(2)];
a.input(1).mf(1).name='N';
a.input(1).mf(1).type='gaussmf';
a.input(1).mf(1).params=[sigma(1) mu(1)];
a.input(1).mf(2).name='Z';
a.input(1).mf(2).type='gaussmf';
a.input(1).mf(2).params=[sigma(2) mu(2)];
a.input(1).mf(3).name='P';
a.input(1).mf(3).type='gaussmf';
a.input(1).mf(3).params=[sigma(3) mu(3)];
a.input(2).name='de';
a.input(2).range=[ranges(3) ranges(4)];
a.input(2).mf(1).name='N';
a.input(2).mf(1).type='gaussmf';
a.input(2).mf(1).params=[sigma(4) mu(4)];
a.input(2).mf(2).name='Z';
a.input(2).mf(2).type='gaussmf';
a.input(2).mf(2).params=[sigma(5) mu(5)];
a.input(2).mf(3).name='P';
a.input(2).mf(3).type='gaussmf';
a.input(2).mf(3).params=[sigma(6) mu(6)];
a.output(1).name='u';
a.output(1).range=[ranges(5) ranges(6)];
a.output(1).mf(1).name='u1';
a.output(1).mf(1).type='constant';
a.output(1).mf(1).params= parameters(1);
a.output(1).mf(2).name='u2';
a.output(1).mf(2).type='constant';
a.output(1).mf(2).params= parameters(2);
a.output(1).mf(3).name='u3';
a.output(1).mf(3).type='constant';
a.output(1).mf(3).params= parameters(3);
a.output(1).mf(4).name='u4';
a.output(1).mf(4).type='constant';
a.output(1).mf(4).params= parameters(4);
a.output(1).mf(5).name='u5';
a.output(1).mf(5).type='constant';
a.output(1).mf(5).params= parameters(5);
a.output(1).mf(6).name='u6';
a.output(1).mf(6).type='constant';
a.output(1).mf(6).params= parameters(6);
a.output(1).mf(7).name='u7';
a.output(1).mf(7).type='constant';
a.output(1).mf(7).params= parameters(7);
a.output(1).mf(8).name='u8';
a.output(1).mf(8).type='constant';
a.output(1).mf(8).params= parameters(8);
a.output(1).mf(9).name='u9';
a.output(1).mf(9).type='constant';
a.output(1).mf(9).params= parameters(9);
k = 1 ;
for i = 1 : 3
    for j = 1 : 3
        a.rule(k).antecedent=[i j];
        a.rule(k).consequent= k;
        a.rule(k).weight=1;
        a.rule(k).connection=1;
        k = k + 1 ;
    end
end
writefis(a,FileName) ;