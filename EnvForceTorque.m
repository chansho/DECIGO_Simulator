function [force,torque] = EnvForceTorque(X,i)
dist = X.dist;
% 0�ŏ�����
zero = zeros(3,1);
fSR = zero; fAD = zero; fSG = zero; fMG = zero;
tSR = zero; tAD = zero; tGG = zero; tMD = zero;

% �n���d��(1)
fEG = EarthGravity(X,i,dist);
% ���z�t��(2)
if dist(2) == 1
    [fSR,tSR] = SolarRadiation(X,i);
end
% ��C��R(3)
if dist(3) == 1
    [fAD,tAD] = AirDrag(X,i);
end
% �d�͌X��(4)
if dist(4) == 1
    tGG = GravityGradient(X,i);
end
% ���z�d��(5)
if dist(5) == 1
    fSG = SunGravity(X,i);
end
% ���d��(6)
if dist(6) == 1
    fMG = MoonGravity(X,i);
end
% ���C�O��(7)
if dist(7) == 1
    tMD = MagDisturbance(X,i);
end

force  = fEG + fSR + fAD + fSG + fMG;
torque = tSR + tAD + tGG + tMD;
end

%% �n���d��(1)
function force = EarthGravity(X,i,dist)
GMe = 3.986004415E5; %�n�S�d�͒萔 km3 s-2
Re = 6378.1363; %�n�����a km
J2 = 1082.264E-6; %J2
aJ2 = zeros(3,1);
x = (X.xPos(i,1:3))';
phi = atan(x(3)/sqrt(x(1)^2+x(2)^2)); %�ܓx rad
aJ1 = -GMe/(norm(x)^3) * x;
if dist(1) == 1
    aJ2 = (Re + J2 + phi) * x;%J2���̎�������
end
force = X.m *(aJ1+aJ2); %kg km s-2
end

%% ���z�t��(2)
function [force,torque] = SolarRadiation(X,i)
AU = 1.495978707E8; %�V���P�� km
arm = [ 0.75,    0,    0;
       -0.75,    0,    0;
           0, 0.75,    0;
           0,-0.75,    0;
           0,    0, 0.75;
           0,    0,-0.75];
n = [ 1, 0  0;
     -1, 0, 0;
      0, 1, 0;
      0,-1, 0;
      0, 0, 1;
      0, 0,-1];
area = ones(6,1).*(0.75)^2;
reflectivity = [0.9;0.9;0.6;0.6;0.9;0.5];
specularity = [0.9;0.9;0.9;0.9;0.9;0.9];
sun_i = [-AU;0;0];
sun_b = sun_i - (X.xPos(i,1:3))'; %�@�̍��W�n���z�����x�N�g��
sun_b = sun_b./norm(sun_b); %���K��
[cos, sin] = CalcTheta;
[coef_n,coef_t] = CalcCoef;
force = zeros(3,1);
torque = zeros(3,1);
for i=1:6
    if(cos(i)>0)
        ncu = cross(sun_b,n(i,:)');
        if ncu == zeros(3,1)
            ncu = zeros(3,1);
        else
             ncu = ncu./norm(ncu);
        end
        s = cross(ncu,n(i,:)');
        fs = -1.0*coef_n(i)*n(i,:)'+coef_t(i)*s;
        force = force + fs;
        ts = cross(arm(i,:)',fs);
        torque = torque + ts;
    end
end

function [cos,sin] = CalcTheta
    cos = arm * sun_b;
    sin = sqrt(ones(6,1)-cos.*cos);
end

function [coef_n,coef_t] = CalcCoef
    c_ = 299792458.0;
    solar_constant_ = 1358.0;
    item = solar_constant_ / c_;
    coef_n = -area*item.*((1+reflectivity.*specularity).*cos.^2+2/3*reflectivity.*(1-specularity).*cos);
    coef_t = area*item.*(1-reflectivity.*specularity).*cos.*sin;
end

end

%% ��C��R(3)
function [force,torque] = AirDrag(X,i)
end
 
%% �d�͌X��(4)
function torque = GravityGradient(X,i)
GMe = 3.986004415E5; %�n�S�d�͒萔 km3 s-2
r = q2DCM(X.xAtt(i,1:4))*(-X.xPos(i,1:3))'; %�@�̍��W�n�ɂ�����n�������x�N�g��
e = r./norm(r);
torque = 3.0*GMe/(norm(r)^3)*cross(e,X.I*e);
end

%% ���z�d��(5)
function force = SunGravity(X,i)
end

%% ���d��(6)
function force = MoonGravity(X,i)
end

%% ���C�O��(7)
function torque = MagDisturbance(X,i)
end