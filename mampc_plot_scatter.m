%% 此程序用于绘制样本图
clear
close all
load('data\platoon\nndata.mat');
row_X=size(X,1);

%% 横纵耦合
% for i=1:size(X,1)
%     i
%     scatter3(X(i,1),X(i,2),X(i,3),30,'.');
%     grid on;
%     xlabel('$e_x$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
%     ylabel('$e_y$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
%     zlabel('$e_{\psi}$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
%     hold on
%     
% end
figure
scatter3(X(:,1),X(:,3),X(:,2)-X(:,6),30,'.');
axis([-8 8 -0.5 0.5 -10 10]);
hold on
scatter3(X(:,1), X(:,3),-10*ones(row_X,1),10,'.','MarkerEdgeColor',[0.75 0.75 0.75],'MarkerFaceColor',[0.75 0.75 0.75]);
scatter3(X(:,1), 0.5*ones(row_X,1),X(:,2)-X(:,6),10,'.','MarkerEdgeColor',[0.75 0.75 0.75],'MarkerFaceColor',[0.75 0.75 0.75]);
scatter3(8*ones(row_X,1), X(:,3),X(:,2)-X(:,6),10,'.','MarkerEdgeColor',[0.75 0.75 0.75],'MarkerFaceColor',[0.75 0.75 0.75]);
xlabel('$e^x_i$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
ylabel('$e^y_i$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
zlabel('$e^v_i$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')

figure
scatter(U(:,1),U(:,2),30,'.')
xlim([-10000 10000]);ylim([-0.1*pi 0.1*pi]);
% xlim([-1 1]);ylim([-1 1]);
xlabel('$T^d_i$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
ylabel('$\delta_i$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')

% figure
% scatter3(X(:,1),X(:,2),X(:,3),30,'.');
% view(0,90);
% xlabel('$e_x$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% ylabel('$e_y$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% zlabel('$e_{\psi}$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% 
% figure
% scatter3(X(:,1),X(:,2),X(:,3),30,'.');
% view(0,0);
% xlabel('$e_x$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% ylabel('$e_y$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% zlabel('$e_{\psi}$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% 
% figure
% scatter3(X(:,1),X(:,2),X(:,3),30,'.');
% view(90,0);
% xlabel('$e_x$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% ylabel('$e_y$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
% zlabel('$e_{\psi}$', 'Interpreter', 'latex', 'FontSize', 16, 'FontWeight', 'bold')
