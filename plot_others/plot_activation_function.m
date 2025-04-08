clear
close all
% figure(1)
% for x=-10:1:10
%     if x<=1 && x>=-1
%         y=x;
%     elseif x<10
%         y=1;
%     elseif x>-10
%         y=-1;
%     end
% end
% plot(y);

x=linspace(-10.0,10.0);
y=1./(1.0+exp(-1.0*x));
figure(1)
plot(x,y,'LineWidth',2.5)
xlabel('\fontname{Times new roman}x', 'FontSize', 14)
ylabel('\fontname{Times new roman}y', 'FontSize', 14)
% legend('sigmoid function','Location','best')
% legend boxoff
% title('sigmoid','Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold')
 
%% tanh function
y = tanh(x);
figure(2)
plot(x,y,'LineWidth',2.5) 
xlabel('\fontname{Times new roman}x', 'FontSize', 14)
ylabel('\fontname{Times new roman}y','FontSize', 14)
% legend('tanh function','Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
% legend boxoff
% title('tanh','Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold')
 
%% ReLU function
relu1=@(x)(x.*(x>=0)+0.*(x<0));
y = relu1(x);
figure(3)
plot(x,y,'LineWidth',2.5) 
xlabel('\fontname{Times new roman}x', 'FontSize', 14)
ylabel('\fontname{Times new roman}y', 'FontSize', 14)
% legend('relu function','Location','best')
% legend boxoff
% title('relu','Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold')


%% Leaky ReLU function
scale=0.1;
leakyrelu1=@(x,scale)(x.*(x>=0)+scale.*x.*(x<0));
y = leakyrelu1(x,scale);
figure(4)
plot(x,y,'k','LineWidth',2.5) 
xlabel('x','Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold')
ylabel('y','Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold')
% legend('leaky relu function','Location','best')
% legend boxoff
% title('leaky relu','Interpreter', 'latex', 'FontSize', 14, 'FontWeight', 'bold')