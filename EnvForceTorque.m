function [force,torque] = EnvForceTorque(X,i)
dist = X.dist;
% 0で初期化
zero = zeros(3,1);
fSR = zero; fAD = zero; fSG = zero; fMG = zero;
tSR = zero; tAD = zero; tGG = zero; tMD = zero;

% 地球重力(1)
fEG = EarthGravity(X,i,dist);
% 太陽輻射(2)
if dist(2) == 1
    [fSR,tSR] = SolarRadiation(X,i);
end
% 大気抵抗(3)
if dist(3) == 1
    [fAD,tAD] = AirDrag(X,i);
end
% 重力傾斜(4)
if dist(4) == 1
    tGG = GravityGradient(X,i);
end
% 太陽重力(5)
if dist(5) == 1
    fSG = SunGravity(X,i);
end
% 月重力(6)
if dist(6) == 1
    fMG = MoonGravity(X,i);
end
% 磁気外乱(7)
if dist(7) == 1
    tMD = MagDisturbance(X,i);
end

force  = fEG + fSR + fAD + fSG + fMG;
torque = tSR + tAD + tGG + tMD;
end

%% 地球重力(1)
function force = EarthGravity(X,i,dist)
GMe = 3.986004415E5; %地心重力定数 km3 s-2
Re = 6378.1363; %地球半径 km
J2 = 1082.264E-6; %J2
aJ2 = zeros(3,1);
x = (X.xPos(i,1:3))';
phi = atan(x(3)/sqrt(x(1)^2+x(2)^2)); %緯度 rad
aJ1 = -GMe/(norm(x)^3) * x;
if dist(1) == 1
    aJ2 = (Re + J2 + phi) * x;%J2項の式が入る
end
force = X.m *(aJ1+aJ2); %kg km s-2
end

%% 太陽輻射(2)
function [force,torque] = SolarRadiation(X,i)
AU = 1.495978707E8; %天文単位 km
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
sun_b = sun_i - (X.xPos(i,1:3))'; %機体座標系太陽方向ベクトル
sun_b = sun_b./norm(sun_b); %正規化
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

%% 大気抵抗(3)
function [force,torque] = AirDrag(X,i)
end
 
%% 重力傾斜(4)
function torque = GravityGradient(X,i)
GMe = 3.986004415E5; %地心重力定数 km3 s-2
r = q2DCM(X.xAtt(i,1:4))*(-X.xPos(i,1:3))'; %機体座標系における地球方向ベクトル
e = r./norm(r);
torque = 3.0*GMe/(norm(r)^3)*cross(e,X.I*e);
end

%% 太陽重力(5)
function force = SunGravity(X,i)
end

%% 月重力(6)
function force = MoonGravity(X,i)
end

%% 磁気外乱(7)
function torque = MagDisturbance(X,i)
end