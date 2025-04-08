function [] = mpc_only(model)
    close all; clc; restoredefaultpath;    
    set_path(model);
    params = set_params();

    Ts = params.Ts;
    Tmax = 100;

    Nc=3;
    u0_1=zeros(2,Nc); %控制时域=3

    Q=100000*[70 0 0 0;    
        0  50 0 0;
        0  0 50 0;
        0  0 0 10];
    
    R1=[0.05   0;
        0      50000000];
    R2=diag([0,0]); 
    PreLook = 5;

    % 约束
    a=[];
    b=[];
    Aeq=[];
    beq=[];
    lb=ones(1,Nc).*[-1e4;-0.1*pi];
    ub=ones(1,Nc).*[1e4;0.1*pi];

    v0=80; %领航车车速（km/h）

    %% 跟随车控制量计算（mpc）
    for i=1:3 % 分别代表第1~3辆跟随车
        t_sol = zeros(Tmax/Ts+1, 1);
        x_sol = zeros(Tmax/Ts+1, 10);
        u_sol = zeros(Tmax/Ts, 2);
        elapsed = zeros(Tmax/Ts+1, 1);
        i_sol = 1;
        t_sim = 0;
        if i==1
            x_sim = [2,v0/3.6,0.1,0,0,v0/3.6,0,0,v0/3.6/0.51,v0/3.6/0.51];
        end
        if i==2
            x_sim = [4,v0/3.6,0.2,0,0,v0/3.6,0,0,v0/3.6/0.51,v0/3.6/0.51];
        end
        if i==3
            x_sim = [6,v0/3.6,0.3,0,0,v0/3.6,0,0,v0/3.6/0.51,v0/3.6/0.51];
        end
        x0=x_sim;
        %e_x,vx_0,e_y,e_phi,Rho_Road,vx_1,vy_1,Yaw_Dot_1,AVz_L1,AVz_L2
        if i==1
            load('deserve\condition1\Rho_Road_0.mat');
        end
        if i==2
            load('deserve\condition1\Rho_Road_1.mat');
        end
        if i==3
            load('deserve\condition1\Rho_Road_2.mat');
        end
    
        while i_sol < Tmax / Ts
            i_sol
            t_sol(i_sol) = t_sim;
            x_sol(i_sol, :) = x_sim;
            x_sim(5)=Rho_Road_0(i_sol);
            
            options = optimset('LargeScale','on','MaxFunEvals',60000,'TolFun',1e-2,'Algorithm','active-set');
            parameter_input={x0,Q,R1,R2,PreLook};
            
            tic;
            u_new = fmincon(@F_Cost_1,u0_1,a,b,Aeq,beq,lb,ub,@F_Nonlinear,options,parameter_input); % fmincon求解
            elapsed(i_sol) = toc;

            u0_1=[u_new(:,2:end),u_new(:,end)];
            u_sol(i_sol, :) = u_new(:,1);


            dxdt=params.ode(i_sol,x_sim,u_new(:,1)); % 输入当前时刻状态量,dxdt表示下一时刻状态量
            x_sim = dxdt; % 将下一时刻状态量赋给x_sim
            x0=dxdt;
            i_sol=i_sol+1;
            t_sim = t_sim+Ts;
        end
        success = i_sol > Tmax / Ts - params.Hp && norm(x_sim, 2) <= params.tolerance;
        if success
            disp(['mpc_',num2str(i), ' succeed.']);
        else
            disp(['mpc_',num2str(i), ' finished.']);
        end
        
        %% 变量存储
        % 为每个变量创建结构体
        data_struct = struct();
        data_struct.(['mpc_', num2str(i), '_t']) = t_sol(1:i_sol-1, :);
        data_struct.(['mpc_', num2str(i), '_x']) = x_sol(1:i_sol-1, :);
        data_struct.(['mpc_', num2str(i), '_u']) = u_sol(1:i_sol-2, :);
        data_struct.(['mpc_', num2str(i), '_elapsed']) = elapsed(1:i_sol-1, :);
    
        % 保存数据到单独的 MAT 文件中，指定变量名前缀
        save(sprintf('results/%s/results_mpc/following_vehicle_%d_mpc.mat', model, i), ...
             '-struct', 'data_struct');
    end
end
