close all
clear variables
s = tf('s');
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
opts.MagUnits = 'abs';
opts.MagScale = 'log';
opts.Title.FontSize = 15;
opts.XLabel.FontSize = 15;
opts.YLabel.FontSize = 15;
opts.Grid = 'on';

% プラント
M = 600; % kg
m = 30;  % kg
Ix = 450;
Iy = 450;
Iz = 675;
Im = 1.8;
P = 1/(M*(s^2-1e-9));
pp = 1/(s^2-1e-9);
Pq = [            pp/M,  zeros(1,11);
               0, pp/M,  zeros(1,10);
      zeros(1,2), pp/M,  zeros(1,9);
      zeros(1,3), pp/Ix, zeros(1,8);
      zeros(1,4), pp/Iy, zeros(1,7);
      zeros(1,5), pp/Iz, zeros(1,6);
      zeros(1,6), pp/M,  zeros(1,5);
      zeros(1,7), pp/M,  zeros(1,4);
      zeros(1,8), pp/M,  zeros(1,3);
      zeros(1,9), pp/Ix, zeros(1,2);
      zeros(1,10),pp/Iy,          0;
      zeros(1,11),pp/Iz            ];
Pm = 1/Im/s^2*eye(6);

% ノイズモデル
noise_model

% H∞制御
hinf_control

% Controller
Kd = [K, 0, 0;
      0, K, 0;
      0, 0, K];
Paa = 0.5; Iaa = 0.1; Daa = 5; Naa = 10; % fix
Prp = 1.5; Irp = 0.5;  Drp = 20;   Nrp = 10;
Pra = 0.01; Ira = 0.0001;  Dra = 0.3;   Nra = 0.3;
PIDaa = Paa + Iaa/s + Daa*Naa/(1+Naa/s);
PIDrp = Prp + Irp/s + Drp*Nrp/(1+Nrp/s);
PIDra = Pra + Ira/s + Dra*Nra/(1+Nra/s);
Kaa = PIDaa*Im*eye(6);
Krp = PIDrp*m*eye(3);
Kra = PIDra*[Ix,0,0;0,Iy,0;0,0,Iz];

% ノイズ
% スラスタ
Wthrp = Wthr*eye(3);
Wthra = 0.75*Wthrp;
% 静電センサ
Wisp = Wis*eye(3);
Wisa = Wis*100*eye(3);
Wisq = [            Wisp, zeros(3,9);
        zeros(3,3), Wisa, zeros(3,6);
        zeros(3,6), Wisp, zeros(3,3);
        zeros(3,9), Wisa            ];
% 静電アクチュエータ
Wespp = [zeros(1,6);
         0,Wesp,zeros(1,4);
         zeros(1,6);
         zeros(1,6);
         zeros(1,4),Wesp,0;
         zeros(1,5),Wesp];
Wesaa = Wesa*eye(6);
% 太陽輻射圧
Wsrpp = Wsrp*eye(3);
Wsrpa = 0.75*Wsrpp;

% ダイナミクス
Z3 = zeros(3);
I3 = eye(3);
C1 = mylib.RotMatrix(deg2rad(30),'z');
C2 = mylib.RotMatrix(deg2rad(-30),'z');
rx1 = 0.195; ry1 =  0.325; rz1 = 0.0;
rx2 = 0.195; ry2 = -0.325; rz2 = 0.0;
O1 = [0, -rz1, ry1; rz1, 0, -rx1; -ry1, rx1, 0];
O2 = [0, -rz2, ry2; rz2, 0, -rx2; -ry2, rx2, 0];
B  = [-C1,  O1, I3, Z3, Z3, Z3;
       Z3, -C1, Z3, I3, Z3, Z3;
      -C2,  O2, Z3, Z3, I3, Z3;
       Z3, -C2, Z3, Z3, Z3, I3];
Cd = [-C1;-C2];
Ba = -(C1+C2)/2;
Bd = [1,0,0,0,0,0;0,0,1,0,0,0;0,0,0,1,0,0]*Cd;
invBd = inv(Bd);
invBe = eye(3);
invBa = inv(Ba);








