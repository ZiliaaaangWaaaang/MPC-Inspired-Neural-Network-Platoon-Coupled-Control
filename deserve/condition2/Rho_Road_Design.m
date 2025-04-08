clear
clc
delta_t=32/(90/3.6)/0.1;
% delta_t=0;
for k=1:299+round(delta_t)
    Rho_Road_0(k)=0;
end
for k=300+round(delta_t):499+round(delta_t)
    Rho_Road_0(k)=1/600;
end
for k=500+round(delta_t):699+round(delta_t)
    Rho_Road_0(k)=-1/600;
end
for k=700+round(delta_t):1000
    Rho_Road_0(k)=0;
end