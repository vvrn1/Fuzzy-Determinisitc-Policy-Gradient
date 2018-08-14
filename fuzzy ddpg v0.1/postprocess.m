function []=postprocess(Loss,MR,TR,Spp,See,actorvars)
close all
fig1 = figure;
set(fig1,'units','centimeters','position',[1 1 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
plot(1:1:length(MR),Loss,'linewidth',1)
xlabel('Episode')
ylabel('Loss')
saveas(fig1, 'Loss', 'fig')

fig2 = figure;
set(fig2,'units','centimeters','position',[1 1 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
plot(1:1:length(MR),MR,'linewidth',1)
xlabel('Episode')
ylabel('Mean Reward')
saveas(fig2, 'MR', 'fig')

fig3 = figure;
set(fig3,'units','centimeters','position',[1 1 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
plot(1:1:length(MR),TR,'linewidth',1)
xlabel('Episode')
ylabel('Total Reward')
saveas(fig3, 'TR', 'fig')

fig4 = figure;
set(fig4,'units','centimeters','position',[5 5 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
plot(Spp(1,:),Spp(2,:),'--r','linewidth',2)
hold on
plot(See(1,:),See(2,:),'-b','linewidth',2)
xlabel('x (m)')
ylabel('y (m)')
legend('Pursuer','Evader')
saveas(fig4, 'Path', 'fig')


a = readfis('actor');
fig5 = figure;
set(fig5,'units','centimeters','position',[5 5 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
% x = -1:0.000001:1;
% plot(x,exp(-((x-best_policy.Mu(4))./best_policy.Sigma(4)).^2))
% hold on
% plot(x,exp(-((x-best_policy.Mu(5))./best_policy.Sigma(5)).^2))
% hold on
% plot(x,exp(-((x-best_policy.Mu(6))./best_policy.Sigma(6)).^2))
% hold on
plotmf(a,'input',2)
xlabel('$\dot{\delta_p} $ (rad/s)','Interpreter','latex')
ylabel('Membership Function')
% legend('Pursuer','Evader')
saveas(fig5, 'input2', 'fig')
fig6 = figure;
set(fig6,'units','centimeters','position',[5 5 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
% x = -1:0.0001:1;
% plot(x,exp(-((x-actorvars.Mu(1))./actorvars.Sigma(1)).^2))
% hold on
% plot(x,exp(-((x-actorvars.Mu(2))./actorvars.Sigma(2)).^2))
% hold on
% plot(x,exp(-((x-actorvars.Mu(2))./actorvars.Sigma(3)).^2))
% hold on
plotmf(a,'input',1)
xlabel('${\delta_p} $ (rad)','Interpreter','latex')
ylabel('Membership Function')
saveas(fig6, 'input1', 'fig')
% legend('Pursuer','Evader')
fig7 = figure;
set(fig7,'units','centimeters','position',[5 5 7.2 4.8]);
set(gca,'fontname','Times New Roman','fontsize',10.5)
a = readfis('actor');
[x,y,z] = gensurf(a);
surf(x,y,0.5*tanh(z))
shading interp
xlabel('${\delta_p} $ (rad)','Interpreter','latex')
ylabel('$\dot{\delta_p} $ (rad/s)','Interpreter','latex')
zlabel('$u_p $ (rad/s)','Interpreter','latex')
saveas(fig7, 'surface', 'fig')