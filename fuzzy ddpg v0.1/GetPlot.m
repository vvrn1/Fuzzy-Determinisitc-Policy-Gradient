function GetPlot(Sp,Se,I,show)
if show == 1
    plot(Se(1,:),Se(2,:),'ok','linewidth',1) ;
    hold on
    plot(Sp(1,:),Sp(2,:),'*k','linewidth',1) ;
elseif show == 2
    for i = 1 : I
        plot(Se(1,i),Se(2,i),'.r','linewidth',1) ;
        hold on
        plot(Sp(1,i),Sp(2,i),'*b','linewidth',1) ;
        hold on
        
        m=getframe ;
    end
end