%% 本程序用于车辆动力学模型验证
clear
close all
%% case1（直道）
load('case1_trucksim\delta.mat')
tt=0:0.1:20;
figure(1)
plot(tt,delta(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}前轮转角\fontname{Times new roman}(rad)', 'FontSize', 12)

load('case1_trucksim\vx.mat');
figure(2)
plot(tt,vx(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
load('case1_5DoF\vx.mat')
plot(tt,vx(1:201),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}纵向速度\fontname{Times new roman}(m/s)', 'FontSize', 12)
legend('\fontname{Times new roman}Trucksim','\fontname{Times new roman}5DoF\fontname{宋体}动力学模型','location','southeast', 'FontSize', 10)


load('case1_trucksim\vy.mat');
figure(3)
plot(tt,vy(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
load('case1_5DoF\vy.mat')
plot(tt,vy(1:201),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
ylim([-0.7 0.7])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}横向速度\fontname{Times new roman}(m/s)', 'FontSize', 12)
legend('\fontname{Times new roman}Trucksim','\fontname{Times new roman}5DoF\fontname{宋体}动力学模型','location','northeast', 'FontSize', 10)

load('case1_trucksim\Yaw_Dot.mat');
figure(4)
plot(tt,Yaw_Dot(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
load('case1_5DoF\Yaw_Dot.mat')
plot(tt,Yaw_Dot_1(1:201),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
ylim([-0.7 0.7])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}横摆角速度\fontname{Times new roman}(rad/s)', 'FontSize', 12)
legend('\fontname{Times new roman}Trucksim','\fontname{Times new roman}5DoF\fontname{宋体}动力学模型','location','northeast', 'FontSize', 10)

%% case2（正弦）
load('case2_trucksim\delta.mat')
tt=0:0.1:20;
figure(5)
plot(tt,delta(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
ylim([-0.08 0.08])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}前轮转角\fontname{Times new roman}(rad)', 'FontSize', 12)

load('case2_trucksim\vx.mat');
figure(6)
plot(tt,vx(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
load('case2_5DoF\vx.mat');load('case2_5DoF\ans.mat');
plot(tt,ans,'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}纵向速度\fontname{Times new roman}(m/s)', 'FontSize', 12)
legend('\fontname{Times new roman}Trucksim','\fontname{Times new roman}5DoF\fontname{宋体}动力学模型','location','southeast', 'FontSize', 10)

load('case2_trucksim\vy.mat');
figure(7)
plot(tt,vy(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
load('case2_5DoF\vy.mat')
plot(tt,vy(1:201),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
ylim([-1.3 1.3])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}横向速度\fontname{Times new roman}(m/s)', 'FontSize', 12)
legend('\fontname{Times new roman}Trucksim','\fontname{Times new roman}5DoF\fontname{宋体}动力学模型','location','northeast', 'FontSize', 10)

load('case2_trucksim\Yaw_Dot.mat');
figure(8)
plot(tt,Yaw_Dot(1:201),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
load('case2_5DoF\Yaw_Dot.mat')
plot(tt,Yaw_Dot_1(1:201),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
ylim([-0.3 0.3])
xlabel('\fontname{宋体}时间\fontname{Times new roman}(s)', 'FontSize', 12)
ylabel('\fontname{宋体}横摆角速度\fontname{Times new roman}(rad/s)', 'FontSize', 12)
legend('\fontname{Times new roman}Trucksim','\fontname{Times new roman}5DoF\fontname{宋体}动力学模型','location','northeast', 'FontSize', 10)