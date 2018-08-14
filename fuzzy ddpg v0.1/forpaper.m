for i = 1: 1000
    Train;
    [ Spp,See,Tc ]  = pegFLC(-6,7,2);
    Tc
    if Tc<10.5
        str = ['result' num2str(1)];
        mkdir(str);
        cd(str)
        postprocess(Loss,MR,TR,Spp,See,actorvars);
        close all
        cd ..
    end
end

    