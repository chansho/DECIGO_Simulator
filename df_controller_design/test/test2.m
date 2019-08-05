close all
clear variables

% 5Å}3ÇÃçÏÇËï˚
a = ureal('a',5,'PlusMinus',[-3,3]);

% B-DECIGOÇÃê´î\Ç‹Ç∆Çﬂ
s = tf('s');
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
opts.MagUnits = 'abs';
opts.MagScale = 'log';
opts.Grid = 'on';
opts.xlim = [1e-5, 1e2];

Mn = 600; % kg
d = 1e-7; % N/Hz^1/2
n = 1e-9; % N/Hz^1/2
k = ureal('k',0,'plusminus',[-1e-6 1e-6]);
M = ureal('M',600,'percent',10);
Pn = 1/(Mn*s^2);
P  = 1/(M*s^2+k);
Dm_g = P - Pn;
xreq = 1e-9;
Sreq = xreq/(Pn*d);
Treq = xreq/n;

figure(1)
bodemag(Sreq,opts)
figure(2)
bodemag(Pn,P)
figure(3)
bodemag(Dm_g)