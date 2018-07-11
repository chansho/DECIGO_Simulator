%% シミュレーション時間
Time.simulationTime = 86400; %シミュレーション時間 sec
Time.dtPos = 1; %軌道運動伝播タイムステップ sec
Time.dtAtt = 1; %姿勢運動伝播タイムステップ sec
Time.stepPos = Time.simulationTime/Time.dtPos; %軌道運動タイムステップ数
Time.stepAtt = Time.simulationTime/Time.dtAtt; %姿勢運動タイムステップ数

%% 衛星・鏡特性
massSC = 600; %宇宙機質量 kg
I_SC = [((1.5)^2/4+(1.5)^2/12)*massSC, 0, 0;
        0, ((1.5)^2/4+(1.5)^2/12)*massSC, 0;
        0, 0, 1/2*massSC*(1.5)^2]; %宇宙機慣性テンソル kg m2
massM = 30; %鏡質量 kg
I_M = (0.3^2+0.3^2)/3*massM*eye(3); %鏡慣性テンソル kg m2

%% 各種外乱ON/OFF
% ON → 1, OFF → 0
distSC = zeros(10,1);
distM  = zeros(10,1);
%%%%%%%%%%%%      SpaceCraft           Mirror
% J2項(1)    
                distSC(1) = 0;      distM(1) = 0;
% 太陽輻射(2)
                distSC(2) = 0;      %%%%%%%%%%%%%
% 大気抵抗(3)
                distSC(3) = 0;      %%%%%%%%%%%%%
% 重力傾斜(4)
                distSC(4) = 0;      distM(4) = 0;
% 太陽重力(5)
                distSC(5) = 0;      distM(5) = 0;
% 月重力(6)
                distSC(6) = 0;      distM(6) = 0;
% 磁気外乱(7)
                distSC(7) = 0;      distM(7) = 0;
