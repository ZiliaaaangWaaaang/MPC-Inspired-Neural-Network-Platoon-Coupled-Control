function [] = gen_nn(params, data_path)
    load('nndata', 'X', 'U');
    X = X';
    U = U';
    net = feedforwardnet(params.nnarch); % 前馈神经网络 % 隐含层及各层神经元个数
    net = configure(net, X, U); % 配置NN输入及输出
    net.layers{1}.transferFcn='tansig';
    net.layers{2}.transferFcn='tansig';
    net.layers{3}.transferFcn='tansig';
    net = init(net); % 初始化
    nnmove_path = sprintf('%s/nnmove_%02d', data_path, 0);
    genFunction(net, nnmove_path); % 通过Neural Network自动生成NN仿真函数保存在nnmove_0中
    nn_path = sprintf('%s/nn_%02d', data_path, 0);
    save(nn_path, 'net'); % nn_0用于存储神经网络
    clear net;
    indices = params.ls:params.ls:length(X); % ls,2*ls,3*ls...
    iter_num = 1;
    for index = indices
        X_train = X(:, 1:index);
        U_train = U(:, 1:index);
        net = feedforwardnet(params.nnarch); % 创建神经网络结构
        net = configure(net, X_train, U_train); % 配置神经网络结构
        net = train(net, X_train, U_train); % 训练神经网络
        nnmove_path = sprintf('%s/nnmove_%02d', data_path, iter_num);
        genFunction(net, nnmove_path);
        nn_path = sprintf('%s/nn_%02d', data_path, iter_num);
        save(nn_path, 'net');
        clear net;
        iter_num = iter_num + 1;
    end
end

%% test
% nnmove = str2func(sprintf('nnmove_01'));
% u = nnmove(x_sim);