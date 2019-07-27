close all
clear variables

omega_n = ureal('omega',1,'percent',20);
zeta = ureal('zeta',0.1,'percent',20);
s = tf('s');
P = omega_n^2/(s^2+2*zeta*omega_n*s+omega_n^2);
w = logspace(-2,2,100);
P_g = ufrd(P,w);
% 乗法的摂動
Dm_g = (P_g - P_g.nominal)/P_g.nominal;
% 加法的摂動
Da_g = P_g - P_g.nominal;

figure(1)
bodemag(P_g,'k',Dm_g,'k--')
legend('P','\Delta_m')
figure(2)
bodemag(P_g,'k',Dm_g,'k--')
legend('P','\Delta_a')
