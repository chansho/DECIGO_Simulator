simulationTime = 10000; %シミュレーション時間
dtPos = 1; %軌道運動伝播タイムステップ sec
dtAtt = 1; %姿勢運動伝播タイムステップ sec
stepPos = simulationTime/dtPos; %軌道運動タイムステップ数
stepAtt = simulationTime/dtAtt; %姿勢運動タイムステップ数

massSC = 600; %宇宙機質量 kg
I_SC = [((1.5)^2/4+(1.5)^2/12)*massSC*10E-6, 0, 0;
        0, ((1.5)^2/4+(1.5)^2/12)*massSC, 0;
        0, 0, 1/2*massSC*(1.5)^2]; %宇宙機慣性テンソル kg m2
massM = 30; %鏡質量 kg
I_M = (0.3^2+0.3^2)/3*massM*eye(3); %鏡慣性テンソル kg m2
