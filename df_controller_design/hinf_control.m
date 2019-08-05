close all
% èdÇ›ä÷êî
% Ws
as = 100;
bs = 100000;
gs = M*0.88e-10;
Ws = gs*((s+bs)/(s+as));
% Wt
at = 100;
bt = 10;
gt = 0.005;
Wt = gt*((s+bt)/(s+at));

% HÅáêßå‰
P = ss(P); Ws = ss(Ws); Wt = ss(Wt); Wd = ss(Wthr); Wn = ss(Wis);
systemnames = 'P Ws Wt Wd Wn';
inputvar = '[w1;w2;u]';
outputvar = '[Ws;Wt;P+Wn]';
input_to_P = '[u+Wd]';
input_to_Ws = '[P]';
input_to_Wt = '[u]';
input_to_Wd = '[w1]';
input_to_Wn = '[w2]';
sysoutname = 'G';
cleanupsysic = 'yes';
sysic;
[K,CL,gamma] = hinfsyn(G,1,1);
K = tf(K);