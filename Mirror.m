classdef Mirror
%鏡(テストマス)のクラス
    properties
        xPos %位置，速度 km, km s-1
        xAtt %姿勢，角速度
        m %質量 kg
        I %慣性テンソル kg m2
        F %力 kg km s-2
        T %トルク kg m2 s-2
    end

    methods
        function obj = Mirror(stepPos,stepAtt,m,I)
            obj.xPos = zeros(stepPos,6);
            obj.xAtt = zeros(stepAtt,7);
            obj.m = m;
            obj.I = I;
            obj.F = zeros(3,1);
            obj.T = zeros(3,1);
        end
    end
end
