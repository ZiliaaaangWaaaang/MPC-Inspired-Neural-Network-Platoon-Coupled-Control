for k=1:700
    v(k)=80/3.6;
end
for k=700:900
    v(k)=1/72*k+900/72;
end
for k=900:1600
    v(k)=90/3.6;
end
for k=1600:1800
    v(k)=1/72*k+200/72;
end
for k=1800:2500
    v(k)=100/3.6;
end
for k=2500:3100
    v(k)=-1/72*k+4500/72;
end
for k=3100:3700
    v(k)=70/3.6;
end
for k=3700:3900
    v(k)=-1/72*k+5100/72;
end
for k=3900:4600
    v(k)=60/3.6;
end
figure
plot(v,'LineWidth',2.0,'Color',[0 0.4470 0.7410]);
xlim([0 4600])
xlabel('x(m)', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')
ylabel('$v_0(m/s)$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold')