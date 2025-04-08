function [] = gen_nndata(params, data_path)
    hbar = waitbar(0, 'NN Data Generation'); % 创建图形进度条
    maxepoch = params.maxepoch;
    X = [];
    U = [];
    i = 1;
    for epoch = 1:maxepoch
        x0 = 2 * (rand(1, params.Nx) - 0.5) .* params.nnrange;
        x0 = [x0(1), 80/3.6+x0(2), x0(3), 0, 0, x0(4)+80/3.6, 0, 0, (x0(4)+80/3.6)/0.51, (x0(4)+80/3.6)/0.51];     
        disp('x0=');disp(x0)
        %e_x,vx_0,e_y,e_phi,Rho_Road,vx_1,vy_1,Yaw_Dot_1,AVz_L1,AVz_L2
        [~, x_sol, u_sol, ~, success] = run_mpc(x0, params); %%
        if success
            X = [X; x_sol(1:end-1, :)];
            U = [U; u_sol];
            i = i+1;
        else
            disp(x0); % 输出到命令行
            disp(x_sol);
        end
        waitbar(epoch/maxepoch, hbar); % 图像进度条
    end
    close(hbar);
    nndata_path = sprintf('%s/nndata', data_path);
    save(nndata_path, 'X', 'U');
end
