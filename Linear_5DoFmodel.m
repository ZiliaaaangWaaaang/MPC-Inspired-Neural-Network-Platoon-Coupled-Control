clear;clc;close all;
syms vx vy phi_dot wf wr Td delta

%% 车辆参数
lf = 3.5;         % 前轴至质心距离
lr = 1.5;         % 后轴至质心距离
m = 18000;        % 质量
Iz = 130421.8;    % 车身绕Z轴转动惯量
Jf = 24;          % 前轮转动惯量
Jr = 48;          % 后轮转动惯量
Re = 0.51;        % 车轮滚动半径

%% 道路附着系数0.85
% 纵向
% 前轮
B_xf = 8.61;C_xf = 1.58;D_xf = 22503;E_xf = 0.5624;
% 后轮
B_xr = 8.61;C_xr = 1.58;D_xr = 44625;E_xr = 0.5624;

% 横向
% 前轮
B_yf = 6.59;C_yf = 1.58;D_yf = 22503;E_yf = -0.3028;
% 后轮
B_yr = 6.59;C_yr = 1.58;D_yr = 44503;E_yr = -0.3028;

%% 速度转化
vx1 = vx;
vx2 = vx;
vy1 = vy+phi_dot*lf;
vy2 = vy-phi_dot*lr;

vxf = vx1*cos(delta)+vy1*sin(delta);
vyf = -vx1*sin(delta)+vy1*cos(delta);
vxr = vx2;
vyr = vy2;

% 轮胎模型
kf = (wf*Re-vxf)/(abs(vxf));   % 前轮滑移率
kr = (wr*Re-vxr)/(abs(vxr));   % 后轮滑移率
af = atan(vyf/vxf);            % 前轮侧偏角
ar = atan(vyr/vxr);            % 后轮侧偏角

%% 轮胎力
Flf = 2*D_xf*sin(C_xf*atan(B_xf*(kf+0.02)-E_xf*(B_xf*(kf+0.02)-atan(B_xf*(kf+0.02)))));
Flr = 2*D_xr*sin(C_xr*atan(B_xr*(kr+0.02)-E_xr*(B_xr*(kr+0.02)-atan(B_xr*(kr+0.02)))));
Fsf = -2*D_yf*sin(C_yf*atan(B_yf*af-E_yf*(B_yf*af-atan(B_yf*af))));
Fsr = -2*D_yr*sin(C_yr*atan(B_yr*ar-E_yr*(B_yr*ar-atan(B_yr*ar))));

dvx = vy*phi_dot+(Flf*cos(delta)-Fsf*sin(delta)+Flr)/m;
dvy = -vx*phi_dot+(Flf*sin(delta)+Fsf*cos(delta)+Fsr)/m;
dphi_dot = ((Flf*sin(delta)+Fsf*cos(delta))*lf-Fsr*lr)/Iz;
dwf = (Td-Re*Flf)/Jf;
dwr = (Td-Re*Flr)/Jr;

A=jacobian([dvx;dvy;dphi_dot;dwf;dwr],[vx;vy;phi_dot;wf;wr]);
B=jacobian([dvx;dvy;dphi_dot;dwf;dwr],[Td;delta]);

% 在平衡点处求值
A_lin=subs(A, {vx,vy,phi_dot,wf,wr,Td,delta}, {80/3.6,0,0,80/3.6/Re,80/3.6/Re,0,0});
B_lin=subs(B, {vx,vy,phi_dot,wf,wr,Td,delta}, {80/3.6,0,0,80/3.6/Re,80/3.6/Re,0,0});

A = double(A_lin);
B = double(B_lin);

Q=[0.1 0 0 0 0;    
  0 10 0 0 0;
  0 0 10 0 0;
  0 0 0 0.1 0;
  0 0 0 0 0.1;];
R=[0.0001   0;
    0      10];
[K,S,e]=lqr(A,B,Q,R);