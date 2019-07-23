opts = bodeoptions('cstprefs');
opts.Title.String = 'Controller Bode Diagram';
opts.Grid = 'on';
opts.Xlim = [1e-2, 1e6];
opts.Ylim = {[1e-2,1e4],[50,250]};
opts.MagUnits = 'abs';
opts.MagScale = 'log';
opts.PhaseUnits = 'deg';

figure('Name','Controller')
bode(K,opts,'k')

systemnames='Psys K';
inputvar='[w; r]';
outputvar='[Psys+r; K]';
input_to_Psys='[K+w]';
input_to_K='[Psys+r]';
sysoutname='Clsys';
cleanupsysic='yes';
sysic;
