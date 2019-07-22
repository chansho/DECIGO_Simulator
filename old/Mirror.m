classdef Mirror < handle
%��(�e�X�g�}�X)�̃N���X
    properties
        xPos %�ʒu�C���x�^�l km, km s-1
        xAtt %�p���C�p���x�^�l
        m %���� kg
        I %�����e���\�� kg m2
        F %�� kg km s-2
        T %�g���N kg m2 s-2
        dist %�O��ON/OFF�̃t���O
    end

    methods
        function obj = Mirror(stepPos,stepAtt,m,I,dist)
            obj.xPos = zeros(stepPos,6);
            obj.xAtt = zeros(stepAtt,7);
            obj.m = m;
            obj.I = I;
            obj.F = zeros(3,1);
            obj.T = zeros(3,1);
            obj.dist = dist;
        end
        function UpdatePos(M,i,dtPos)
            M.xPos(i+1,:) = RungeKuttaPos(M,i,dtPos);
        end
        function UpdateAtt(M,i,dtAtt)
            M.xAtt(i+1,:) = RungeKuttaAtt(M,i,dtAtt);
        end
        function SetForceTorque(M,i)
            [force,torque] = EnvForceTorque(M,i);
            M.F = force;
            M.T = torque;
        end
    end
end
