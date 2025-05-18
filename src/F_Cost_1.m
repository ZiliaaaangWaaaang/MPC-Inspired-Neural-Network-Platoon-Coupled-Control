function J = F_Cost_1(u0,parameter_input)
%% 初始化
Ts=0.1;Np=7;Nc=3;

% parameter_input参数分配
u = parameter_input{1};
Q = parameter_input{2};
R1 = parameter_input{3};
R2 = parameter_input{4};
PreLook = parameter_input{5};
P=10*Q;

% 内存分配
e_vx = zeros(1,Np+1);
e_x = zeros(1,Np+1);
e_y = zeros(1,Np+1);
e_phi = zeros(1,Np+1);

% u参数分配
e_x(1) = u(1);
vx_des = u(2);
e_y(1) = u(3);
e_phi(1) = u(4);
curvature = u(5);
vx = u(6);
vy = u(7);
phi_dot = u(8);
wf = u(9);
wr = u(10);

% 期望横摆角速度
phi_dot_des = vx*curvature;

%% 迭代——预测未来Np步的误差向量
for k = 1:Np
    % ------------------------ 车道保持 (假定未来Np内，Vx不变) ------------------------
    e_vx(k) = vx(k) - vx_des;  
    e_x(k+1) = e_x(k) + Ts*(vx(k)-vx_des);
    e_y(k+1) = e_y(k)+Ts*(vx(k)*e_phi(k)-vy(k)-PreLook*phi_dot(k));
    e_phi(k+1) = e_phi(k)+Ts*(phi_dot_des-phi_dot(k));

    % ------------------------ 依据5DOF机理模型进行未来输出预测 ------------------------;
    % 更新输出
    if k<=Nc
        state = F_Model('long',u0(:,k),vx(k),vy(k),phi_dot(k),wf(k),wr(k));
    else
        state = F_Model('long',u0(:,Nc),vx(k),vy(k),phi_dot(k),wf(k),wr(k));
    end
    vx(k+1) = state(1);
    vy(k+1) = state(2);
    phi_dot(k+1) = state(3);
    wf(k+1) = state(4);
    wr(k+1) = state(5);
end
e_vx(Np+1) = vx(Np+1)-vx_des;

%% 计算未来Np步的代价
J = 0;
for k = 1:Np+1
    Y = [e_x(k),e_y(k),e_phi(k),e_vx(k)];
%     disp('Y=');disp(Y);
    if k<=Nc
        U = u0(:,k)';
        J = J + Y*Q*Y' + U*R1*U';
    elseif k>Nc && k<=Np
        U = u0(:,Nc)';
        J = J + Y*Q*Y' + U*R1*U';
    else
        J = J + Y*P*Y';
    end
end
end
