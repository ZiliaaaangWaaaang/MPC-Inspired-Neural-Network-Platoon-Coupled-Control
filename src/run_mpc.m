function [t_sol, x_sol, u_sol, elapsed, success] = run_mpc(x0, params)

    Ts = params.Ts;
    
    Tmax = params.Tmax;
    t_sol = zeros(Tmax/Ts+1 - params.Hp, 1);
    x_sol = zeros(Tmax/Ts+1 - params.Hp, 10); %仅限存储
    u_sol = zeros(Tmax/Ts - params.Hp, 2);
    elapsed = zeros(Tmax/Ts+1 - params.Hp, 1);  % 计算时间
    i_sol = 1;
    t_sim = 0;
    x_sim = x0;

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
%     load('deserve\vx0.mat');load('deserve\Rho_Road_0.mat');

    while i_sol < Tmax / Ts - params.Hp
        i_sol
        t_sol(i_sol) = t_sim;
        x_sol(i_sol, :) = x_sim;
%         x_sim(2)=vx0(i_sol);x_sim(5)=Rho_Road_0(i_sol);
        
        tic;
        options = optimset('LargeScale','on','MaxFunEvals',60000,'TolFun',1e-2,'Algorithm','active-set');
        parameter_input={x0,Q,R1,R2,PreLook};

        u_new = fmincon(@F_Cost_1,u0_1,a,b,Aeq,beq,lb,ub,@F_Nonlinear,options,parameter_input); % fmincon求解

        u0_1=[u_new(:,2:end),u_new(:,end)];
        u_sol(i_sol, :) = u_new(:,1);

        elapsed(i_sol) = toc;

        dxdt=params.ode(i_sol,x_sim,u_new(:,1));
        t_sim = t_sim + Ts;
        x_sim = dxdt;
        x0=dxdt;
        i_sol = i_sol + 1;
        
%         if norm(x_sim, 2) > params.limit
%             fprintf('System diverged. Abort at %.2f.\n', norm(x_sim, 2)); % 系统发散，终止于...
%             break
%         end
    end
    t_sol(i_sol) = t_sim;
    x_sol(i_sol, :) = x_sim;
    success = i_sol <= Tmax / Ts - params.Hp;
    
    t_sol = t_sol(1:i_sol, :);
    x_sol = x_sol(1:i_sol, :);
    u_sol = u_sol(1:i_sol-1, :);
    elapsed = elapsed(1:i_sol-1, :); %计算时间
end
