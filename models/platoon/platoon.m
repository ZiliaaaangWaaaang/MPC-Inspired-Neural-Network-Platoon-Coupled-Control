function dxdt = platoon(x_sim, u_sim)
    Ts=0.1;

    Td = u_sim(1);
    delta = u_sim(2);

    e_x = x_sim(1);
    vx_des = x_sim(2);
    e_y = x_sim(3);
    e_phi = x_sim(4);
    curvature = x_sim(5);
    vx = x_sim(6);
    vy = x_sim(7);
    phi_dot = x_sim(8);
    wf = x_sim(9);
    wr = x_sim(10);
    
    PreLook=5;
    phi_dot_des=vx*curvature;
    
    %% 车辆参数
    lf = 3.5;         % 前轴至质心距离
    lr = 1.5;         % 后轴至质心距离
    m = 18000;        % 质量
    Iz = 130421.8;    % 车身绕Z轴转动惯量
    Jf = 24;          % 前轮转动惯量
    Jr = 48;          % 后轮转动惯量
    Re = 0.51;        % 车轮滚动半径
    
    %% 魔术公式参数
    % % 我
    % % ------------------------ 纵向 ------------------------
    % % 前轮
    % B_xf = 8;
    % C_xf = 1.8;
    % D_xf = 21380;
    % E_xf = 0.6009;
    % 
    % % 后轮
    % B_xr = 8;
    % C_xr = 1.8;
    % D_xr = 42020;
    % E_xr = 0.601;
    % 
    % % ------------------------ 横向 ------------------------
    % % 前轮
    % B_yf = 6.873;
    % C_yf = 1.601;
    % D_yf = 21380;
    % E_yf = -0.2952;
    % 
    % % 后轮
    % B_yr = 6.873;
    % C_yr = 1.601;
    % D_yr = 42030;
    % E_yr = -0.2951;
    
    % ------------------------ YONG ------------------------
    %% 道路附着系数0.85
%     % 纵向
%     % 前轮
%     B_xf = 8.61;
%     C_xf = 1.58;
%     D_xf = 22503;
%     E_xf = 0.5624;
%     % 后轮
%     B_xr = 8.61;
%     C_xr = 1.58;
%     D_xr = 44625;
%     E_xr = 0.5624;
%     
%     % 横向
%     % 前轮
%     B_yf = 6.59;
%     C_yf = 1.58;
%     D_yf = 22503;
%     E_yf = -0.3028;
%     % 后轮
%     B_yr = 6.59;
%     C_yr = 1.58;
%     D_yr = 44503;
%     E_yr = -0.3028;
    
    %% 道路附着系数0.60
%     % 纵向
%     % 前轮
%     B_xf = 10.48;
%     C_xf = 1.68;
%     D_xf = 15885;
%     E_xf = 0.5624;
%     % 后轮
%     B_xr = 10.48;
%     C_xr = 1.68;
%     D_xr = 31500;
%     E_xr = 0.5624;
%     
%     % 横向
%     % 前轮
%     B_yf = 8.02;
%     C_yf = 1.68;
%     D_yf = 15885;
%     E_yf = -0.3028;
%     % 后轮
%     B_yr = 8.02;
%     C_yr = 1.68;
%     D_yr = 31500;
%     E_yr = -0.3028;

    %% 道路附着系数0.35
    % 纵向
    % 前轮
    B_xf = 12.35;
    C_xf = 1.77;
    D_xf = 9266;
    E_xf = 0.5624;
    % 后轮
    B_xr = 12.35;
    C_xr = 1.77;
    D_xr = 18375;
    E_xr = 0.5624;
    
    % 横向
    % 前轮
    B_yf = 9.45;
    C_yf = 1.77;
    D_yf = 9266;
    E_yf = -0.3028;
    % 后轮
    B_yr = 9.45;
    C_yr = 1.77;
    D_yr = 18375;
    E_yr = -0.3028;
    
    % % ------------------------ 我 ------------------------
    % % 纵向
    % % 前轮
    % B_xf=7.667;
    % C_xf=1.7786;
    % D_xf=22716;
    % E_xf=0.6009;
    % % 后轮
    % B_xr=7.667;
    % C_xr=1.7786;
    % D_xr=44646;
    % E_xr=0.601;
    % 
    % % 横向
    % % 前轮
    % B_yf=6.5866;
    % C_yf=1.5819;
    % D_yf=22716;
    % E_yf=-0.2952;
    % % 后轮
    % B_yr=6.5866;
    % C_yr=1.5819;
    % D_yr=44657;
    % E_yr=-0.2951;
    % 
    % % ------------------------ QBZ ------------------------
    % % 纵向
    % % 前轮
    % B_xf=8.61;
    % C_xf=1.58;
    % D_xf=22503;
    % E_xf=0.5624;
    % % 后轮
    % B_xr=8.67;
    % C_xr=1.58;
    % D_xr=44625;
    % E_xr=0.5624;
    % 
    % % 横向
    % % 前轮
    % B_yf=6.59;
    % C_yf=1.58;
    % D_yf=22503;
    % E_yf=-0.3028;
    % % 后轮
    % B_yr=6.59;
    % C_yr=1.58;
    % D_yr=44625;
    % E_yr=-0.3028;
    
    %% 车辆模型
    % ------------------------ 四阶龙格库塔离散法 ------------------------
        % 方程表达式(+0.02)
%         f_u =  @(t,x,u)(-[ -x(2,:).*x(3,:) - (1/m)*((2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)))))).*cos(u(1,:)) - (-2*D_yf*sin(C_yf*atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-E_yf*(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))))))).*sin(u(1,:)) + (2*D_xr*sin(C_xr*atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:)))+0.02)-E_xr*(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:)))+0.02)-atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:)))+0.02))))))) ;
%             x(1,:).*x(3,:) - (1/m)*((-2*D_yf*sin(C_yf*atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-E_yf*(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))))))).*cos(u(1,:)) + (2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)))))).*sin(u(1,:)) + (-2*D_yr*sin(C_yr*atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-E_yr*(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:))))))))) ;
%             (-1/Iz)*(lf*((2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)))))).*sin(u(1,:)) + (-2*D_yf*sin(C_yf*atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-E_yf*(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))))))).*cos(u(1,:)))-lr*(-2*D_yr*sin(C_yr*atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-E_yr*(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))))))));
%             (1/Jf)*(-u(2,:) + Re * (2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))+0.02)))))));
%             (1/Jr)*(-u(2,:) + Re * (2*D_xr*sin(C_xr*atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:)))+0.02)-E_xr*(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:)))+0.02)-atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:)))+0.02)))))))]);

        % 方程表达式
    f_u =  @(t,x,u)(-[ -x(2,:).*x(3,:) - (1/m)*((2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))))))).*cos(u(1,:)) - (-2*D_yf*sin(C_yf*atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-E_yf*(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))))))).*sin(u(1,:)) + (2*D_xr*sin(C_xr*atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:))))-E_xr*(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:))))-atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:))))))))));
        x(1,:).*x(3,:) - (1/m)*((-2*D_yf*sin(C_yf*atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-E_yf*(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))))))).*cos(u(1,:)) + (2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))))))).*sin(u(1,:)) + (-2*D_yr*sin(C_yr*atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-E_yr*(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))))))));
        (-1/Iz)*(lf*((2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))))))).*sin(u(1,:)) + (-2*D_yf*sin(C_yf*atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-E_yf*(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))-atan(B_yf*(atan(((x(2,:)+lf*x(3,:)).*cos(u(1,:))-x(1,:).*sin(u(1,:)))./((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:)))))))))).*cos(u(1,:)))-lr*(-2*D_yr*sin(C_yr*atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-E_yr*(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))-atan(B_yr*(atan((x(2,:)-lr*(x(3,:)))./x(1,:)))))))));
        (1/Jf)*(-u(2,:) + Re * (2*D_xf*sin(C_xf*atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-E_xf*(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))-atan(B_xf*(((x(4,:)*Re-((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))./abs(((x(2,:)+lf*x(3,:)).*sin(u(1,:))+x(1,:).*cos(u(1,:))))))))))));
        (1/Jr)*(-u(2,:) + Re * (2*D_xr*sin(C_xr*atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:))))-E_xr*(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:))))-atan(B_xr*(((x(5,:)*Re-x(1,:))./abs(x(1,:))))))))))]);
    k1 = @(t,x,u) (f_u(t,x,u));
    k2 = @(t,x,u) (f_u(t + Ts/2, x + k1(t,x,u)*Ts/2, u));
    k3 = @(t,x,u) (f_u(t + Ts/2, x + k2(t,x,u)*Ts/2, u));
    k4 = @(t,x,u) (f_u(t + Ts, x + k3(t,x,u)*Ts, u));
    f_ud = @(t,x,u) (x + (Ts/6) * (k1(t,x,u) + 2*k2(t,x,u) + 2*k3(t,x,u) + k4(t,x,u)));

    % 初始点状态
    x0 = [vx;vy;phi_dot;wf;wr];
    % 状态更新
    x_new(:,1) = f_ud(0,x0,[delta;Td]);
    vx_new = x_new(1,1);
    vy_new = x_new(2,1);
    phi_dot_new = x_new(3,1);
    wf_new = x_new(4,1);
    wr_new = x_new(5,1);

    e_x = e_x+Ts*(vx_new-vx_des);
    e_y = e_y+Ts*(vx_new*e_phi-vy_new-PreLook*phi_dot_new);
    e_phi = e_phi+Ts*(phi_dot_des-phi_dot_new);

    % 变量更新输出
    dxdt = [e_x,vx_des,e_y,e_phi,curvature,vx_new,vy_new,phi_dot_new,wf_new,wr_new];
    % ------------------------ 后向欧拉法离散法 ------------------------
    % 速度转化
%     vx1 = vx;
%     vx2 = vx;
%     vy1 = vy+phi_dot*lf;
%     vy2 = vy-phi_dot*lr;
%     
%     vxf = vx1*cos(delta)+vy1*sin(delta);
%     vyf = -vx1*sin(delta)+vy1*cos(delta);
%     vxr = vx2;
%     vyr = vy2;
%     
%     % 轮胎模型
%     kf = (wf*Re-vxf)/(abs(vxf));   % 前轮滑移率
%     kr = (wr*Re-vxr)/(abs(vxr));   % 后轮滑移率
%     af = atan(vyf/vxf);            % 前轮侧偏角
%     ar = atan(vyr/vxr);            % 后轮侧偏角
%     
%     % 纵向力(+0.02)
%     Flf = 2*D_xf*sin(C_xf*atan(B_xf*(kf+0.02)-E_xf*(B_xf*(kf+0.02)-atan(B_xf*(kf+0.02))))); % 前轮
%     Flr = 2*D_xr*sin(C_xr*atan(B_xr*(kr+0.02)-E_xr*(B_xr*(kr+0.02)-atan(B_xr*(kr+0.02))))); % 后轮
%     
%     %         % 纵向力
%     %         Flf = 2*D_xf*sin(C_xf*atan(B_xf*(kf)-E_xf*(B_xf*(kf)-atan(B_xf*(kf))))); % 前轮
%     %         Flr = 2*D_xr*sin(C_xr*atan(B_xr*(kr)-E_xr*(B_xr*(kr)-atan(B_xr*(kr))))); % 后轮
%     
%     % 横向力
%     Fsf = -2*D_yf*sin(C_yf*atan(B_yf*af-E_yf*(B_yf*af-atan(B_yf*af)))); % 前轮
%     Fsr = -2*D_yr*sin(C_yr*atan(B_yr*ar-E_yr*(B_yr*ar-atan(B_yr*ar)))); % 后轮
%     
%     % 状态更新
%     vx_new = vx+Ts*(vy*phi_dot+(Flf*cos(delta)-Fsf*sin(delta)+Flr)/m);
%     vy_new = vy+Ts*(-vx*phi_dot+(Flf*sin(delta)+Fsf*cos(delta)+Fsr)/m);
%     phi_dot_new = phi_dot+Ts*(((Flf*sin(delta)+Fsf*cos(delta))*lf-Fsr*lr)/Iz);
%     wf_new = wf+Ts*((Td-Re*Flf)/Jf);
%     wr_new = wr+Ts*((Td-Re*Flr)/Jr);
%     
%     % 误差值更新
%     e_x = e_x+Ts*(vx_new-vx_des);
%     e_y = e_y+Ts*(vx*e_phi-vy-PreLook*phi_dot);
%     e_phi = e_phi+Ts*(phi_dot_des-phi_dot);
% 
%     % 变量更新输出
%     dxdt=[e_x,vx_des,e_y,e_phi,0,vx_new,vy_new,phi_dot_new,wf_new,wr_new];
end