classdef SpaceCraft < handle
%衛星(鏡含まない)のクラス
    properties
        xPos %位置，速度真値 km, km s-1
        xAtt %姿勢，角速度真値
        m %質量 kg
        I %慣性テンソル kg m2
        F %力 kg km s-2
        T %トルク kg m2 s-2
        dist %外乱ON/OFFフラグ
    end

    methods
        %コンストラクタ
        function obj = SpaceCraft(stepPos,stepAtt,m,I,dist)
            obj.xPos = zeros(stepPos,6);
            obj.xAtt = zeros(stepAtt,7);
            obj.m = m;
            obj.I = I;
            obj.F = zeros(3,1);
            obj.T = zeros(3,1);
            obj.dist = dist;
        end
        %位置propagation
        function UpdatePos(SC,i,dtPos)
            SC.xPos(i+1,:) = RungeKuttaPos(SC,i,dtPos);
        end
        %姿勢propagetion
        function UpdateAtt(SC,i,dtAtt)
            SC.xAtt(i+1,:) = RungeKuttaAtt(SC,i,dtAtt);
        end
        %力，トルク更新
        function SetForceTorque(SC,i)
            [force,torque] = EnvForceTorque(SC,i);
            SC.F = force;
            SC.T = torque;
        end
    end
end