close all
clear variables

% 制御対象の定義
m1 = 0.8;
m2 = 0.2;
k1 = 100;
k2 = ureal('k2',300,'percent',20);
c1 = 1;
c2 = 0.3;
Ks = 100;
M = [m1,  0;
      0, m2];
C = [c1+c2, -c2;
       -c2,  c2];
K = [k1+k2, -k2;
       -k2,  k2];
F = [Ks;
      0];
Ap = [zeros(2,2), eye(2,2);
        -M\K    ,   -M\C  ];
Bp = [zeros(2,1);
        M\F    ];
Cp = [0 1 0 0];
Dp = 0;
P  = ss(Ap,Bp,Cp,Dp);

figure(1)
bode(P,'k',{1e0,1e2})

% 乗法的摂動の見積もり
w   = logspace(0,3,100);
P_g = ufrd(P,w);
Dm_g = (P_g - P_g.nominal)/P_g.nominal;
s = tf('s');
Wm = 3*s^2/(s^2+18*s+45^2);

figure(2)
bodemag(Dm_g,'k--',Wm,'m',w);
legend('\Delta_m','Wm')

% 一般化プラントの構成
Ws = 15/(s+1.5e-2);
Wt = Wm;
Weps = 5e-4;

figure(3)
bodemag(Ws,'k',Wt,'k--',w)
legend('Ws','Wt')

Pn = P.nominal;
systemnames = 'Pn Ws Wt Weps';
inputvar = '[w1; w2; u]';
outputvar = '[Ws; Wt; Pn+Weps]';
input_to_Pn = '[w1-u]';
input_to_Ws = '[w1-u]';
input_to_Wt = '[u]';
input_to_Weps = '[w2]';
G = sysic;
[K,clp,gamma_min,hinf_info] = hinfsyn(G,1,1,'display','on');

figure(4)
w = logspace(0,2,100);
bodemag(K,'k',P.nominal,'k--',w)
legend('K','P.nominal')

% 閉ループ特性の評価
L = P*K;
T = feedback(L,1);
S = feedback(1,L);
M = feedback(P,K);

figure(5)
bodemag(T.nominal,'k-',1/Wt,'k-',S.nominal,'k--',1/Ws,'k--',w)
legend('T.nominal','1/Wt','S.nominal','1/Ws')
figure(6)
step(T,2)
figure(7)
subplot(211),impulse(M,2)
subplot(212),impulse(Pn,2)





