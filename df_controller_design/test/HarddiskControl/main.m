% H������݌v�f���p
close all
clear variables
w = logspace(-2,6,100);

% ��ʉ��v�����g�̍쐬
gplant

% H�������̐݌v
[K,CL,gamma] = hinfsyn(Gsys,1,1);

% �����{�[�h���}�̕\��
contplot

% �V�~�����[�V����
%simu

