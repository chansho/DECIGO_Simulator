close all
clear variables

% ノミナルモデルの定義
s = tf('s');
M = 1;
Pn = 1/(M*s^2); % ノミナルモデル
% PD制御器
alpha = -0.5;
K1 = alpha^2*M - 2*alpha*M*s/(0.01*s+1);
alpha = -2.5;
K2 = alpha^2*M - 2*alpha*M*s/(0.01*s+1);
% ノミナルモデルに対する応答計算
Tn1 = feedback(Pn*K1,1);
Tn2 = feedback(Pn*K2,1);

figure(1)
step(Tn1,'k--',Tn2,'k',10)
ylim([0 1.4])
legend('\alpha = -0.5','\alpha = -2.5')
figure(2)
bodemag(Tn1,'k--',Tn2,'k')
legend('\alpha = -0.5','\alpha = -2.5')

% 摂動モデルの定義
m1 = ureal('m1',0.8,'percent',10);
m2 = M - m1;
k = ureal('k',300,'percent',10);
c = ureal('c',1,'percent',10);
P = (c*s+k)/(s^2*(m1*m2*s^2 + (m1+m2)*c*s + (m1+m2)*k));
% モデル集合の中から50通りのモデルを選択
P = usample(P,50);

figure(3)
bodemag(Pn,'k',P,'k--',{1e1,1e3});
legend('One mass system', 'Two mass system with perturbation')

% 摂動モデルに対する応答計算
T1 = feedback(P*K1,1);
T2 = feedback(P*K2,1);

figure(4)
step(T1,'k--',T2,'k',10)
ylim([0 1.4])
legend('\alpha = -0.5','\alpha = -2.5')
figure(5)
nyquist(P*K1,'k')
axis([-1.5 0.5 -1 1])
legend('\alpha = -0.5')
figure(6)
nyquist(P*K2,'k')
axis([-1.5 0.5 -1 1])
legend('\alpha = -2.5')
