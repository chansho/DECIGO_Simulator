close all

s = tf('s');
opts = bodeoptions('cstprefs');
opts.FreqUnits = 'Hz';
opts.MagUnits = 'abs';
opts.MagScale = 'log';
opts.Grid = 'on';
opts.xlim = [1e-10, 1];
%opts.ylim = [1e-10, 1e-3];

W1 = 1/s^2;
W2 = 1/(s^2+4e-7);

bodemag(W1,opts)
hold on
bodemag(W2,opts)
legend()
hold off