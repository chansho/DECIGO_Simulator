classdef Mirror < handle
%鏡(テストマス)のクラス
    properties
        xPos %位置，速度真値 km, km s-1
        xAtt %姿勢，角速度真値
        m %質量 kg
        I %慣性テンソル kg m2
        F %力 kg km s-2
        T %トルク kg m2 s-2
        dist %外乱ON/OFFのフラグ
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
