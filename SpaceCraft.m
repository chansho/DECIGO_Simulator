classdef SpaceCraft < handle
%�q��(���܂܂Ȃ�)�̃N���X
    properties
        xPos %�ʒu�C���x�^�l km, km s-1
        xAtt %�p���C�p���x�^�l
        m %���� kg
        I %�����e���\�� kg m2
        F %�� kg km s-2
        T %�g���N kg m2 s-2
        dist %�O��ON/OFF�t���O
    end

    methods
        %�R���X�g���N�^
        function obj = SpaceCraft(stepPos,stepAtt,m,I,dist)
            obj.xPos = zeros(stepPos,6);
            obj.xAtt = zeros(stepAtt,7);
            obj.m = m;
            obj.I = I;
            obj.F = zeros(3,1);
            obj.T = zeros(3,1);
            obj.dist = dist;
        end
        %�ʒupropagation
        function UpdatePos(SC,i,dtPos)
            SC.xPos(i+1,:) = RungeKuttaPos(SC,i,dtPos);
        end
        %�p��propagetion
        function UpdateAtt(SC,i,dtAtt)
            SC.xAtt(i+1,:) = RungeKuttaAtt(SC,i,dtAtt);
        end
        %�́C�g���N�X�V
        function SetForceTorque(SC,i)
            [force,torque] = EnvForceTorque(SC,i);
            SC.F = force;
            SC.T = torque;
        end
    end
end