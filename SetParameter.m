simulationTime = 10000; %�V�~�����[�V��������
dtPos = 1; %�O���^���`�d�^�C���X�e�b�v sec
dtAtt = 1; %�p���^���`�d�^�C���X�e�b�v sec
stepPos = simulationTime/dtPos; %�O���^���^�C���X�e�b�v��
stepAtt = simulationTime/dtAtt; %�p���^���^�C���X�e�b�v��

massSC = 600; %�F���@���� kg
I_SC = [((1.5)^2/4+(1.5)^2/12)*massSC*10E-6, 0, 0;
        0, ((1.5)^2/4+(1.5)^2/12)*massSC, 0;
        0, 0, 1/2*massSC*(1.5)^2]; %�F���@�����e���\�� kg m2
massM = 30; %������ kg
I_M = (0.3^2+0.3^2)/3*massM*eye(3); %�������e���\�� kg m2
