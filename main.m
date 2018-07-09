clear;
%パラメータ設定
SetParameter;

%インスタンス生成
SC1 = SpaceCraft(stepPos,stepAtt,massSC,I_SC);
%SC2 = SpaceCraft(stepPos,stepAtt,massSC,I_SC);
M1 = Mirror(stepPos,stepAtt,massM,I_M);
%M2 = Mirror(stepPos,stepAtt,massM,I_M);

%初期値設定
Initialize;

%とりあえず軌道も姿勢も1秒ごとに更新
for i = 1:simulationTime-1
  %軌道運動伝播
  SC1.xPos(i+1,:) = UpdatePos(SC1,i,dtPos);
  %SC2.xPos(i+1,:) = UpdatePos(SC2,i,dtPos);
  M1.xPos(i+1,:) = UpdatePos(M1,i,dtPos);
  %M2.xPos(i+1,:) = UpdatePos(M2,i,dtPos);

  %姿勢運動伝播
  SC1.xAtt(i+1,:) = UpdateAtt(SC1,i,dtAtt);
  %SC2.xAtt(i+1,:) = UpdateAtt(SC2,i,dtAtt);
  M1.xAtt(i+1,:) = UpdateAtt(M1,i,dtAtt);
  %M2.xAtt(i+1,:) = UpdateAtt(M2,i,dtAtt);

  %観測

  %制御量計算

  %力，トルク更新
  SC1.F = EarthGravity(SC1,i)
  SC1.T = GravityGradient(SC1,i);
  M1.F = EarthGravity(M1,i);

end

%結果をプロット
PlotResult;
