clear;
%�p�����[�^�ݒ�
SetParameter;

%�C���X�^���X����
SC1 = SpaceCraft(Time.stepPos,Time.stepAtt,massSC,I_SC,distSC);
M1  = Mirror(Time.stepPos,Time.stepAtt,massM,I_M,distM);

%�����l�ݒ�
Initialize;

%�Ƃ肠�����O�����p����1�b���ƂɍX�V
for i = 1:Time.simulationTime-1
  %�O���^���`�d
  UpdatePos(SC1,i,Time.dtPos);
  UpdatePos(M1,i,Time.dtAtt);

  %�p���^���`�d
  UpdateAtt(SC1,i,Time.dtAtt);
  UpdateAtt(M1,i,Time.dtAtt);

  %�ϑ�

  %����ʌv�Z

  %�́C�g���N�X�V
  SetForceTorque(SC1,i+1);
  SetForceTorque(M1,i+1);

end

%���ʂ��v���b�g
PlotResult;
