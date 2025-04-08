function params = set_params()
    %% System params
    params.ode = @platoon_ode;
    params.pla = @platoon;
    params.fsv = @platoon_fsv;
    %params.cost = @platoon_cost;
    %params.jac = @platoon_jac;
    %% Simulation params
    params.Ts = 0.1;
    params.Tmax = 50; % 决定NN_data数目/决定仿真步数
    params.tolerance = 1e-3; % 决定训练是否停止
    params.limit = 25; % 判断是否发散
    params.x0 = [0;80/3.6;80/3.6;80/(3.6*0.51);80/(3.6*0.51)]; % 横纵耦合
    %% MPC params
    params.Hp = 5; % 预测时域
    params.Hc = 5; % 控制时域
    params.Nx = 4;
    params.Nu = 2;
    params.Ny = 3;
    params.x_eq = [20; 0; 0; 20.04/0.51; 20.04/0.51]; % 状态量平衡点
    fp = @(u) platoon_fsv(params.x_eq, u); % u为自变量
    %u_guess = zeros(params.Nu, 1);
    params.u_guess=[390.28; 0];
    params.u_eq = fsolve(fp, params.u_guess, optimset('Display', 'off', 'Algorithm', 'levenberg-marquardt'));
    %params.u_eq=[12050; 0];
    %params.u_eq = [390.28; 0];
    %[A, B] = params.jac(params.x_eq, params.u_eq);
    %params.A = A;
    %params.B = B;
    params.Q = [30 30 30];
    params.R = [1 1];
    params.xmin = [10, -0.7, -0.7, 10/0.51, 10/0.51]; % 滑移率为0（理想情况）
    params.xmax = [30, 0.7, 0.7, 30.6/0.51, 30.6/0.51]; % 滑移率为2%（最大情况）
    params.ymin = [-10, -0.7, -0.7];
    params.ymax = [10, 0.7, 0.7]; %输出量约束
    params.umin = [-20000, -0.7];
    params.umax = [20000, 0.7]; %控制量约束
%     params.xmin = params.xmin - params.x_eq';
%     params.xmax = params.xmax - params.x_eq';
%     params.umin = params.umin - params.u_eq';
%     params.umax = params.umax - params.u_eq';
    %% NN params
    params.nnrange = [8, 20/3.6, 0.7, 20/3.6]; % e_x,e_y,vx_1
    params.nnarch = [20, 10, 20]; % 隐含层及各层神经元个数
    params.maxepoch = 50; % 最大数据轨迹数
    params.ls = 2000; % 单次训练数据数目
end
