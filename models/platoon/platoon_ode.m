function dydt = platoon_ode(t, y, u)
    dydt = platoon(y, u);
end