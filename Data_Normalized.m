%% 本程序用于对数据进行归一化（第二步）
clear;
% load('data\platoon\nndata.mat')
load('nndata.mat')
x1=X(:,1);x2=X(:,2);x3=X(:,3);x4=X(:,4);x5=X(:,5);
x6=X(:,6);x7=X(:,7);x8=X(:,8);x9=X(:,9);x10=X(:,10);

u1=U(:,1);u2=U(:,2);

%% 归一化（mapminmax）
[x1,Ps_x1]=mapminmax(x1',-1,1);x1=x1'; %归一化必须是行矩阵
[x2,Ps_x2]=mapminmax(x2',-1,1);x2=x2';
[x3,Ps_x3]=mapminmax(x3',-1,1);x3=x3';
[x4,Ps_x4]=mapminmax(x4',-1,1);x4=x4';
[x5,Ps_x5]=mapminmax(x5',-1,1);x5=x5';
[x6,Ps_x6]=mapminmax(x6',-1,1);x6=x6';
[x7,Ps_x7]=mapminmax(x7',-1,1);x7=x7';
[x8,Ps_x8]=mapminmax(x8',-1,1);x8=x8';
[x9,Ps_x9]=mapminmax(x9',-1,1);x9=x9';
[x10,Ps_x10]=mapminmax(x10',-1,1);x10=x10';
[u1,Ps_u1]=mapminmax(u1',-1,1);u1=u1';
[u2,Ps_u2]=mapminmax(u2',-1,1);u2=u2';
X=[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10];
U=[u1,u2];

%% 归一化（zscore）
% [x1,mu1,sigma1]=zscore(x1);[x2,mu2,sigma2]=zscore(x2);
% [x3,mu3,sigma3]=zscore(x3);[x4,mu4,sigma4]=zscore(x4);
% [x5,mu5,sigma5]=zscore(x5);[x6,mu6,sigma6]=zscore(x6);
% [x7,mu7,sigma7]=zscore(x7);[x8,mu8,sigma8]=zscore(x8);
% [x9,mu9,sigma9]=zscore(x9);[x10,mu10,sigma10]=zscore(x10);
% [u1,mu_u1,sigma_u1]=zscore(u1);[u2,mu_u2,sigma_u2]=zscore(u2);
% X=[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10];
% U=[u1,u2];

%% 标准化（x/xmax）
% x1=x1/10;x2=x2/30;x3=x3/0.7;x4=x4/0.07;
% x6=x6/30;x7=x7/0.7;x8=x8/0.7;x9=x9/100;x10=x10/100;
% u1=u1/10000;u2=u2/0.7;
% X=[x1,x2,x3,x4,x5,x6,x7,x8,x9,x10];U=[u1,u2];

%%
save('nndata.mat', 'X', 'U');
save('for_test/Ps_u1.mat', 'Ps_u1');save('for_test/Ps_u2.mat', 'Ps_u2');
save('for_test/Ps_x1.mat', 'Ps_x1');save('for_test/Ps_x2.mat', 'Ps_x2');
save('for_test/Ps_x3.mat', 'Ps_x3');save('for_test/Ps_x4.mat', 'Ps_x4');
save('for_test/Ps_x5.mat', 'Ps_x5');save('for_test/Ps_x6.mat', 'Ps_x6');
save('for_test/Ps_x7.mat', 'Ps_x7');save('for_test/Ps_x8.mat', 'Ps_x8');
save('for_test/Ps_x9.mat', 'Ps_x9');save('for_test/Ps_x10.mat', 'Ps_x10');
% save('for_test/mu1.mat', 'mu1');save('for_test/sigma1.mat', 'sigma1');
% save('for_test/mu2.mat', 'mu2');save('for_test/sigma2.mat', 'sigma2');
% save('for_test/mu3.mat', 'mu3');save('for_test/sigma3.mat', 'sigma3');
% save('for_test/mu4.mat', 'mu4');save('for_test/sigma4.mat', 'sigma4');
% save('for_test/mu5.mat', 'mu5');save('for_test/sigma5.mat', 'sigma5');
% save('for_test/mu6.mat', 'mu6');save('for_test/sigma6.mat', 'sigma6');
% save('for_test/mu7.mat', 'mu7');save('for_test/sigma7.mat', 'sigma7');
% save('for_test/mu8.mat', 'mu8');save('for_test/sigma8.mat', 'sigma8');
% save('for_test/mu9.mat', 'mu9');save('for_test/sigma9.mat', 'sigma9');
% save('for_test/mu10.mat', 'mu10');save('for_test/sigma10.mat', 'sigma10');
% save('for_test/mu_u1.mat', 'mu_u1');save('for_test/sigma_u1.mat', 'sigma_u1');
% save('for_test/mu_u2.mat', 'mu_u2');save('for_test/sigma_u2.mat', 'sigma_u2');