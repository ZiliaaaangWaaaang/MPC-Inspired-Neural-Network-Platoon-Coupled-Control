%% 该程序用于绘制仿真结果
clear
close all
set_path platoon
load('results\platoon\results_mpc\following_vehicle_1_mpc.mat')
load('results\platoon\results_mpc\following_vehicle_2_mpc.mat')
load('results\platoon\results_mpc\following_vehicle_3_mpc.mat')

load('results\platoon\results_nn\following_vehicle_1_nn.mat')
load('results\platoon\results_nn\following_vehicle_2_nn.mat')
load('results\platoon\results_nn\following_vehicle_3_nn.mat')

params = set_params();
Ts = params.Ts;
Tmax = 100;

for t1=size(mpc_1_elapsed,1):Tmax/Ts
    mpc_1_elapsed(t1)=0;
    mpc_1_x(t1,:)=0;
    mpc_1_u(t1,:)=0;
    mpc_1_t(t1)=mpc_1_t(t1-1)+Ts;

    mpc_2_elapsed(t1)=0;
    mpc_2_x(t1,:)=0;
    mpc_2_u(t1,:)=0;
    mpc_2_t(t1)=mpc_2_t(t1-1)+Ts;

    mpc_3_elapsed(t1)=0;
    mpc_3_x(t1,:)=0;
    mpc_3_u(t1,:)=0;
    mpc_3_t(t1)=mpc_3_t(t1-1)+Ts;
end

for t3=size(nn_1_elapsed,1):Tmax/Ts
    nn_1_elapsed(t3)=0;
    nn_1_x(t3,:)=0;
    nn_1_u(t3,:)=0;
    nn_1_t(t3)=nn_1_t(t3-1)+Ts;

    nn_2_elapsed(t3)=0;
    nn_2_x(t3,:)=0;
    nn_2_u(t3,:)=0;
    nn_2_t(t3)=nn_2_t(t3-1)+Ts;

    nn_3_elapsed(t3)=0;
    nn_3_x(t3,:)=0;
    nn_3_u(t3,:)=0;
    nn_3_t(t3)=nn_3_t(t3-1)+Ts;
end

%% 横纵耦合（x1-x2-x3）算法之间的对比
% figure
% tt=0:0.1:99.9;
% plot(tt,mpc_1_x(:,1),'LineWidth',2.0)
% hold on
% plot(tt,nn_1_x(:,1),'-.','LineWidth',2.0)
% % yline(0, 'k--', 'LineWidth', 2.0)
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$e^x_{1-2}(m)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% legend('MPC','NN-MPC', 'Interpreter', 'latex','location','northeast','FontWeight', 'bold')
% 
% figure
% plot(tt,mpc_1_x(:,2),'LineWidth',2.0)
% hold on
% plot(tt,nn_1_x(:,2),'-.','LineWidth',2.0)
% % yline(0, 'k--', 'LineWidth', 2.0)
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$e^v_{1-2}(m/s)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% legend('MPC','NN-MPC', 'Interpreter', 'latex','location','northeast','FontWeight', 'bold')
% 
% %% 仅纵向（u1）算法之间的对比
% figure
% plot(mpc_1_u(:,1),'LineWidth',2.0)
% hold on
% plot(nn_1_u(:,1),'-.','LineWidth',2.0)
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$a_{des,2}(m/s^2)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')

%% 车辆编队(1辆领航车，1辆跟随车)
tt=0:0.1:99.9;
%% 计算时间对比
% figure
% plot(tt,mpc_3_elapsed*100,'-.','LineWidth',1,'Color',[0 0.4470 0.7410])
% hold on
% plot(tt,nn_3_elapsed*1e3,'LineWidth',1.5,'Color',[0.8500 0.3250 0.0980])
% grid on
% ylim([0 200])
% % zp = BaseZoom();
% % zp.plot;
% % ylim([0 2]);
% xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('\fontname{宋体}计算时间\fontname{Times new roman}(ms)', 'FontSize', 12)
% legend('NMPC','CDNN', 'Interpreter', 'latex','location','northeast','FontWeight', 'bold')

figure
plot(tt,nn_1_elapsed*1e3,'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
plot(tt,nn_2_elapsed*1e3,'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
hold on
plot(tt,nn_3_elapsed*1e3,'--','LineWidth',2.0,'Color',[0.4660 0.6740 0.1880])
% zp = BaseZoom();
% zp.plot;
% ylim([0 2]);
xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('\fontname{宋体}计算时间\fontname{Times new roman}(ms)', 'FontSize', 12)
legend('\fontname{宋体}跟随车\fontname{Times new roman}1','\fontname{宋体}跟随车\fontname{Times new roman}2','\fontname{宋体}跟随车\fontname{Times new roman}3','location','northeast')

%% 前车加速度信息
% figure
% plot(tt,nn_1_x(:,1),'LineWidth',2.0,'Color',[0 0.39216 0])
% hold on
% plot(tt,nn_2_x(:,1),'LineWidth',2.0,'Color',[0.8549 0.64706 0.12549])
% hold on
% plot(tt,nn_3_x(:,1),'LineWidth',2.0,'Color',[0.2549 0.41176 0.88235])
% yline(0, 'k--', 'LineWidth', 2.0)
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$e^x(m)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% legend('1-2','2-3','3-4','location','northeast')

% figure
% plot(tt,nn_1_x(:,2),'LineWidth',2.0,'Color',[0 0.39216 0])
% hold on
% plot(tt,nn_2_x(:,2),'LineWidth',2.0,'Color',[0.8549 0.64706 0.12549])
% hold on
% plot(tt,nn_3_x(:,2),'LineWidth',2.0,'Color',[0.2549 0.41176 0.88235])
% yline(0, 'k--', 'LineWidth', 2.0)
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$e_v(m/s)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% 
% load('D:\ZiliangWang\mpc_qrnet_longitudinal\a_des_df.mat'); % 真实驾驶数据
% a1_des=a_des_df(1:1000);

% for t=1:100
%     a1_des(t) = 0;
% end
% for t=100:200
%     a1_des(t)=-1/3;
% end
% for t=200:350
%     a1_des(t)=0;
% end
% for t=350:375
%     a1_des(t)=-1/9;
% end
% for t=375:400
%     a1_des(t)=1/9;
% end
% for t=400:1000
%     a1_des(t)=0;
% end
phi_des=zeros(1,Tmax/Ts);
a1_des=zeros(1,Tmax/Ts);

v1=zeros(1,Tmax/Ts);
v2=zeros(1,Tmax/Ts);
v3=zeros(1,Tmax/Ts);
v4=zeros(1,Tmax/Ts);
v0=80;
v1(1)=v0/3.6;
v2(1)=v0/3.6;
v3(1)=v0/3.6;
v4(1)=v0/3.6;

s4(1)=0;
s3(1)=s4(1)+nn_3_x(1,1)+16+v1(1);
s2(1)=s3(1)+nn_2_x(1,1)+16+v1(1);
s1(1)=s2(1)+nn_1_x(1,1)+16+v1(1);

for t=2:Tmax/Ts
    v1(t)=80/3.6;
    v2(t)=nn_1_x(t,6);
    v3(t)=nn_2_x(t,6);
    v4(t)=nn_3_x(t,6);

    s1(t)=s1(t-1)+v1(t-1)*0.1;
    s2(t)=s1(t)-nn_1_x(t,1)-(16+v1(t));
    s3(t)=s2(t)-nn_2_x(t,1)-(16+v1(t));
    s4(t)=s3(t)-nn_3_x(t,1)-(16+v1(t)); %在此处改车间距策略
end

% figure
% plot(tt,a1_des,'LineWidth',2.0,'Color',[0 0.39216 0])
% hold on
% plot(tt,nn_1_x(:,3),'LineWidth',2.0,'Color',[0.8549 0.64706 0.12549])
% hold on
% plot(tt,nn_2_x(:,3),'LineWidth',2.0,'Color',[0.2549 0.41176 0.88235])
% hold on
% plot(tt,nn_3_x(:,3),'LineWidth',2.0, 'Color', [1 0 0])
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$a(m/s^2)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% legend('leading vehicle 1','following vehicle 2','following vehicle 3','following vehicle 4','Interpreter', 'latex','location','northeast','FontWeight', 'bold')
% 
% figure
% plot(tt,v1*3.6,'LineWidth',2.0,'Color',[0 0.39216 0])
% hold on
% plot(tt,v2*3.6,'LineWidth',2.0,'Color',[0.8549 0.64706 0.12549])
% hold on
% plot(tt,v3*3.6,'LineWidth',2.0,'Color',[0.2549 0.41176 0.88235])
% hold on
% plot(tt,v4*3.6,'LineWidth',2.0, 'Color', [1 0 0])
% xlabel('time(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% ylabel('$v(km/h)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% legend('leading vehicle 1','following vehicle 2','following vehicle 3','following vehicle 4','Interpreter', 'latex','location','southeast','FontWeight', 'bold')

figure
plot(tt,s1,'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
plot(tt,s2,'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
hold on
plot(tt,s3,'--','LineWidth',2.0,'Color',[0.4660 0.6740 0.1880])
hold on
plot(tt,s4,':','LineWidth',2.0, 'Color', [0.6350 0.0780 0.1840])
grid on
xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$s(m)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
legend('\fontname{宋体}领航车','\fontname{宋体}跟随车\fontname{Times new roman}1','\fontname{宋体}跟随车\fontname{Times new roman}2','\fontname{宋体}跟随车\fontname{Times new roman}3','location','southeast')

figure
plot(tt,nn_1_x(:,1),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
plot(tt,nn_2_x(:,1),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
hold on
plot(tt,nn_3_x(:,1),'--','LineWidth',2.0,'Color',[0.4660 0.6740 0.1880])
grid on
ylim([-6 6])
xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$e_x(m)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
legend('\fontname{宋体}领航车-\fontname{宋体}跟随车\fontname{Times new roman}1','\fontname{宋体}跟随车\fontname{Times new roman}1-\fontname{宋体}跟随车\fontname{Times new roman}2','\fontname{宋体}跟随车\fontname{Times new roman}2-\fontname{宋体}跟随车\fontname{Times new roman}3','location','southeast')

figure
plot(tt,nn_1_x(:,2)-nn_1_x(:,6),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
plot(tt,nn_2_x(:,2)-nn_2_x(:,6),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
hold on
plot(tt,nn_3_x(:,2)-nn_3_x(:,6),'--','LineWidth',2.0,'Color',[0.4660 0.6740 0.1880])
grid on
ylim([-3.5 3.5])
xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$e_v(m/s)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
legend('\fontname{宋体}领航车-\fontname{宋体}跟随车\fontname{Times new roman}1','\fontname{宋体}跟随车\fontname{Times new roman}1-\fontname{宋体}跟随车\fontname{Times new roman}2','\fontname{宋体}跟随车\fontname{Times new roman}2-\fontname{宋体}跟随车\fontname{Times new roman}3','location','southeast')

figure
plot(tt,nn_1_x(:,3),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
plot(tt,nn_2_x(:,3),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
hold on
plot(tt,nn_3_x(:,3),'--','LineWidth',2.0,'Color',[0.4660 0.6740 0.1880])
grid on
ylim([-0.3 0.35])
xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$e_y(m)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
legend('\fontname{宋体}领航车-\fontname{宋体}跟随车\fontname{Times new roman}1','\fontname{宋体}跟随车\fontname{Times new roman}1-\fontname{宋体}跟随车\fontname{Times new roman}2','\fontname{宋体}跟随车\fontname{Times new roman}2-\fontname{宋体}跟随车\fontname{Times new roman}3','location','northeast')


figure
plot(tt,nn_1_x(:,4),'LineWidth',2.0,'Color',[0 0.4470 0.7410])
hold on
plot(tt,nn_2_x(:,4),'-.','LineWidth',2.0,'Color',[0.8500 0.3250 0.0980])
hold on
plot(tt,nn_3_x(:,4),'--','LineWidth',2.0,'Color',[0.4660 0.6740 0.1880])
grid on
ylim([-0.04 0.055])
xlabel('t(s)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$e_{\psi}(deg)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
legend('\fontname{宋体}领航车-\fontname{宋体}跟随车\fontname{Times new roman}1','\fontname{宋体}跟随车\fontname{Times new roman}1-\fontname{宋体}跟随车\fontname{Times new roman}2','\fontname{宋体}跟随车\fontname{Times new roman}2-\fontname{宋体}跟随车\fontname{Times new roman}3','location','northeast')
