function []= nn_only(model)
    close all; clc; restoredefaultpath;    
    set_path(model);
    params = set_params();

    nnmove = str2func(sprintf('nnmove_08'));
    Ts = params.Ts;
    Tmax = 100;

    load('for_test/Ps_u1.mat');load('for_test/Ps_u2.mat');
    load('for_test/Ps_x1.mat');load('for_test/Ps_x2.mat');
    load('for_test/Ps_x3.mat');load('for_test/Ps_x4.mat');
    load('for_test/Ps_x5.mat');load('for_test/Ps_x6.mat');
    load('for_test/Ps_x7.mat');load('for_test/Ps_x8.mat');
    load('for_test/Ps_x9.mat');load('for_test/Ps_x10.mat');
%     load('for_test/mu1.mat');load('for_test/sigma1.mat');
%     load('for_test/mu2.mat');load('for_test/sigma2.mat');
%     load('for_test/mu3.mat');load('for_test/sigma3.mat');
%     load('for_test/mu4.mat');load('for_test/sigma4.mat');
%     load('for_test/mu5.mat');load('for_test/sigma5.mat');
%     load('for_test/mu6.mat');load('for_test/sigma6.mat');
%     load('for_test/mu7.mat');load('for_test/sigma7.mat');
%     load('for_test/mu8.mat');load('for_test/sigma8.mat');
%     load('for_test/mu9.mat');load('for_test/sigma9.mat');
%     load('for_test/mu10.mat');load('for_test/sigma10.mat');
%     load('for_test/mu_u1.mat');load('for_test/sigma_u1.mat');
%     load('for_test/mu_u2.mat');load('for_test/sigma_u2.mat');
    
    v0=90; %领航车车速（km/h）
%     K=[91.585189779107550,9.874927146586670e-13,-2.219443592755888e-12,0.315222647162757,0.516839607764499;1.392338947907128e-14,-0.379168720527037,3.160427343779269,2.247827995700038e-16,4.234107839174051e-17];
    K=[0 0;0 0;0 0;0 0;0 0];
%% 跟随车控制量计算（nn）
    for i=1:3
        t_sol = zeros(Tmax/Ts+1, 1);
        x_sol = zeros(Tmax/Ts+1, 10);
        u_sol = zeros(Tmax/Ts, 2);
        elapsed = zeros(Tmax/Ts+1, 1);
        i_sol = 1;
        t_sim = 0;
        if i==1
            x_sim = [-2,v0/3.6,-0.1,0,0,v0/3.6,0,0,v0/3.6/0.51,v0/3.6/0.51];
        end
        if i==2
            x_sim = [-4,v0/3.6,-0.2,0,0,v0/3.6,0,0,v0/3.6/0.51,v0/3.6/0.51];
        end
        if i==3
            x_sim = [-6,v0/3.6,-0.3,0,0,v0/3.6,0,0,v0/3.6/0.51,v0/3.6/0.51];
        end
        %e_x,vx_0,e_y,e_phi,Rho_Road,vx_1,vy_1,Yaw_Dot_1,AVz_L1,AVz_L2
        if i==1
            load('deserve\condition2\Rho_Road_0.mat');
        end
        if i==2
            load('deserve\condition2\Rho_Road_1.mat');
        end
        if i==3
            load('deserve\condition2\Rho_Road_2.mat');
        end
    
        while i_sol <= Tmax / Ts     
            t_sol(i_sol) = t_sim;
            x_sol(i_sol, :) = x_sim;
            x_sim(5)=Rho_Road_0(i_sol);
                
    %% mapminmax归一化
            x1=mapminmax('apply',x_sim(1),Ps_x1);x2=mapminmax('apply',x_sim(2),Ps_x2);
            x3=mapminmax('apply',x_sim(3),Ps_x3);x4=mapminmax('apply',x_sim(4),Ps_x4);
            x5=mapminmax('apply',x_sim(5),Ps_x5);x6=mapminmax('apply',x_sim(6),Ps_x6);
            x7=mapminmax('apply',x_sim(7),Ps_x7);x8=mapminmax('apply',x_sim(8),Ps_x8);
            x9=mapminmax('apply',x_sim(9),Ps_x9);x10=mapminmax('apply',x_sim(10),Ps_x10);
            x_norm=[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]; %归一化(mapminmax)
    
    %% zscore归一化
    %         x1=(x_sim(1)-mu1)/sigma1;x2=(x_sim(2)-mu2)/sigma2;
    %         x3=(x_sim(3)-mu3)/sigma3;x4=(x_sim(4)-mu4)/sigma4;
    %         x5=(x_sim(5)-mu5)/sigma5;x6=(x_sim(6)-mu6)/sigma6;
    %         x7=(x_sim(7)-mu7)/sigma7;x8=(x_sim(8)-mu8)/sigma8;
    %         x9=(x_sim(9)-mu9)/sigma9;x10=(x_sim(10)-mu10)/sigma10;
    %         x_norm=[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10]; %归一化(zscore)
    
    %% 标准化
    %         x_norm=[x_sim(1)/10,x_sim(2)/30,x_sim(3)/0.7,x_sim(4)/0.07,x_sim(5),...
    %             x_sim(6)/30,x_sim(7)/0.7,x_sim(8)/0.7,x_sim(9)/100,x_sim(10)/100]; %标准化
            tic; 
%             x_sqrt=sqrt(x_sim(1)^2+(x_sim(2)-x_sim(6))^2+x_sim(3)^2+x_sim(4)^2);
%             if x_sqrt>0.1
                u = nnmove(x_norm');
                u1=mapminmax('reverse',u(1),Ps_u1);u2=mapminmax('reverse',u(2),Ps_u2);
                u = [u1,u2]; %反归一化
%             else
%                 u = -[x_sim(6),x_sim(7),x_sim(8),x_sim(9),x_sim(10)]*K;
%             end
            elapsed(i_sol) = toc;

            %-------------验模用---------------
%             u=[1000,0.05*sin(pi*i_sol/10)];
            %---------------------------------
        
            u_sol(i_sol, :) = u;
    
            dxdt=params.ode(i_sol,x_sim,u); % 输入当前时刻状态量,dxdt表示下一时刻状态量
            x_sim = dxdt; % 将下一时刻状态量赋给x_sim
            i_sol=i_sol+1;
                
    %         if norm(x_sim, 2) > params.limit
    %             fprintf('System diverged. Abort at %.2f.\n', norm(x_sim, 2));
    %             break
    %         end
            t_sim = t_sim+Ts;
        end
        success = i_sol > Tmax / Ts - params.Hp && norm(x_sim, 2) <= params.tolerance;
        if success
            disp(['nn_',num2str(i), ' succeed.']);
        else
            disp(['nn_',num2str(i), ' finished.']);
        end
        
        %% 变量存储
        % 为每个变量创建结构体
        data_struct = struct();
        data_struct.(['nn_', num2str(i), '_t']) = t_sol(1:i_sol-1, :);
        data_struct.(['nn_', num2str(i), '_x']) = x_sol(1:i_sol-1, :);
        data_struct.(['nn_', num2str(i), '_u']) = u_sol(1:i_sol-2, :);
        data_struct.(['nn_', num2str(i), '_elapsed']) = elapsed(1:i_sol-1, :);
    
        % 保存数据到单独的 MAT 文件中，指定变量名前缀
        save(sprintf('results/%s/results_nn/following_vehicle_%d_nn.mat', model, i), ...
             '-struct', 'data_struct');
    end
end

%sqrt(nn_1_x(1000,1)^2+(nn_1_x(1000,2)-nn_1_x(1000,6))^2+nn_1_x(1000,3)^2+nn_1_x(1000,4)^2)