% プラントと重みの定義
s = tf('s');
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'rad/s';
opts.MagUnits = 'abs';
opts.MagScale = 'log';
opts.Grid = 'on';
opts.Title.String = 'Weighting Functions';
opts.xlim = [1e-2,1e6];
opts.ylim = [1e-1,1e4];

P = 3.87e7/s^2;
W1 = (s+125.7)/(s+1e-4)*0.5;
W2 = ((s^2+1e4*s+5.7e7)/(s^2+1.2e4*s+4.04e8))^2*23.9;
W3 = 0.1;
W4 = (s+2.5e4)/(s+5.0e5)*10;

figure('Name','Weighting Functions')
bodemag(W1,opts,'k-')
hold on
bodemag(W2,opts,'k--')
bodemag(W4,opts,'k:')
legend()
hold off

% 一般化プラントを作成
Psys = ss(P);
W1sys = ss(W1);
W2sys = ss(W2);
W3sys = ss(W3);
W4sys = ss(W4);

systemnames = 'Psys W1sys W2sys W3sys W4sys';
inputvar  = '[w1; w2; u]';
outputvar = '[W1sys; W2sys; W4sys; w2+Psys]';
input_to_W3sys = '[w1]';
input_to_Psys  = '[W3sys + u]';
input_to_W1sys = '[Psys + w2]';
input_to_W2sys = '[Psys]';
input_to_W4sys = '[u]';
sysoutname = 'Gsys';
cleanupsysic = 'yes';
sysic;









