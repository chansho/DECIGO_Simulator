function torque = GravityGradient(X,i)
GMe = 3.986004415E5; %地心重力定数 km3 s-2
r = q2DCM(X.xAtt(i,1:4))*(-X.xPos(i,1:3))'; %機体座標系における地球方向ベクトル
e = r./norm(r);
torque = 3.0*GMe/(norm(r)^3)*cross(e,X.I*e);
end
