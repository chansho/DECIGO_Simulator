clear;
%�p�����[�^�ݒ�
SetParameter;

%�C���X�^���X����
SC1 = SpaceCraft(stepPos,stepAtt,massSC,I_SC);
%SC2 = SpaceCraft(stepPos,stepAtt,massSC,I_SC);
M1 = Mirror(stepPos,stepAtt,massM,I_M);
%M2 = Mirror(stepPos,stepAtt,massM,I_M);

%�����l�ݒ�
Initialize;

%�Ƃ肠�����O�����p����1�b���ƂɍX�V
for i = 1:simulationTime-1
  %�O���^���`�d
  SC1.xPos(i+1,:) = UpdatePos(SC1,i,dtPos);
  %SC2.xPos(i+1,:) = UpdatePos(SC2,i,dtPos);
  M1.xPos(i+1,:) = UpdatePos(M1,i,dtPos);
  %M2.xPos(i+1,:) = UpdatePos(M2,i,dtPos);

  %�p���^���`�d
  SC1.xAtt(i+1,:) = UpdateAtt(SC1,i,dtAtt);
  %SC2.xAtt(i+1,:) = UpdateAtt(SC2,i,dtAtt);
  M1.xAtt(i+1,:) = UpdateAtt(M1,i,dtAtt);
  %M2.xAtt(i+1,:) = UpdateAtt(M2,i,dtAtt);

  %�ϑ�

  %����ʌv�Z

  %�́C�g���N�X�V
  SC1.F = EarthGravity(SC1,i)
  SC1.T = GravityGradient(SC1,i);
  M1.F = EarthGravity(M1,i);

end

%���ʂ��v���b�g
PlotResult;
