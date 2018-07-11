clear;
%パラメータ設定
SetParameter;

%インスタンス生成
SC1 = SpaceCraft(Time.stepPos,Time.stepAtt,massSC,I_SC,distSC);
M1  = Mirror(Time.stepPos,Time.stepAtt,massM,I_M,distM);

%初期値設定
Initialize;

%とりあえず軌道も姿勢も1秒ごとに更新
for i = 1:Time.simulationTime-1
  %軌道運動伝播
  UpdatePos(SC1,i,Time.dtPos);
  UpdatePos(M1,i,Time.dtAtt);

  %姿勢運動伝播
  UpdateAtt(SC1,i,Time.dtAtt);
  UpdateAtt(M1,i,Time.dtAtt);

  %観測

  %制御量計算

  %力，トルク更新
  SetForceTorque(SC1,i+1);
  SetForceTorque(M1,i+1);

end

%結果をプロット
PlotResult;
