% mCY
% XX^ N/ãHz
a = 2*pi*10^(-3)*6;
b = 2*pi*10^(-4)*1.5;
g = 10^(-7);
Wthr = g*((s+a)/(s+b))^2;
% ÃdZT m/ãHz
a = 2*pi*10^(-4)*3;
b = 2*pi*10^(-5)*1.15;
g = 10^(-9);
Wis = g*((s+a)/(s+b))^3;
% ÃdAN`G[^ N/ãHz
a = 2*pi*10^(-6)*6;
b = 2*pi*10^(-4)*3;
gp = 5*10^(-12);
ga = 5*10^(-13);
Wesp = gp*((s+b)/(s+a))^5/50;
Wesa = ga*((s+b)/(s+a))^3/50;
% ¾zçtË³
a = 2*pi*10^(-4)*2;
b = 2*pi*10^(-3)*3;
g = 10^(-9);
Wsrp = g*((s+b)/(s+a));
