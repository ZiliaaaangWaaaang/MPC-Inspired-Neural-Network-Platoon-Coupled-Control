function y = platoon_fsv(x, u)
    v_des=20;
    phi_des=0;
    L=5; %预瞄距离5m

    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    x4 = x(4);
    x5 = x(5);

    %% 横纵耦合
    y = zeros(3, 1);
    y(1) = x1-v_des;
    y(2) = x1*y(3)-x2-L*x3;
    y(3) = phi_des-x3;
end