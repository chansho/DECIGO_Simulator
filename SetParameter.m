%% �V�~�����[�V��������
Time.simulationTime = 86400; %�V�~�����[�V�������� sec
Time.dtPos = 1; %�O���^���`�d�^�C���X�e�b�v sec
Time.dtAtt = 1; %�p���^���`�d�^�C���X�e�b�v sec
Time.stepPos = Time.simulationTime/Time.dtPos; %�O���^���^�C���X�e�b�v��
Time.stepAtt = Time.simulationTime/Time.dtAtt; %�p���^���^�C���X�e�b�v��

%% �q���E������
massSC = 600; %�F���@���� kg
I_SC = [((1.5)^2/4+(1.5)^2/12)*massSC, 0, 0;
        0, ((1.5)^2/4+(1.5)^2/12)*massSC, 0;
        0, 0, 1/2*massSC*(1.5)^2]; %�F���@�����e���\�� kg m2
massM = 30; %������ kg
I_M = (0.3^2+0.3^2)/3*massM*eye(3); %�������e���\�� kg m2

%% �e��O��ON/OFF
% ON �� 1, OFF �� 0
distSC = zeros(10,1);
distM  = zeros(10,1);
%%%%%%%%%%%%      SpaceCraft           Mirror
% J2��(1)    
                distSC(1) = 0;      distM(1) = 0;
% ���z�t��(2)
                distSC(2) = 0;      %%%%%%%%%%%%%
% ��C��R(3)
                distSC(3) = 0;      %%%%%%%%%%%%%
% �d�͌X��(4)
                distSC(4) = 0;      distM(4) = 0;
% ���z�d��(5)
                distSC(5) = 0;      distM(5) = 0;
% ���d��(6)
                distSC(6) = 0;      distM(6) = 0;
% ���C�O��(7)
                distSC(7) = 0;      distM(7) = 0;
