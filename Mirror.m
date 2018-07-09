classdef Mirror
%��(�e�X�g�}�X)�̃N���X
    properties
        xPos %�ʒu�C���x km, km s-1
        xAtt %�p���C�p���x
        m %���� kg
        I %�����e���\�� kg m2
        F %�� kg km s-2
        T %�g���N kg m2 s-2
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
