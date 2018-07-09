function torque = GravityGradient(X,i)
GMe = 3.986004415E5; %�n�S�d�͒萔 km3 s-2
r = q2DCM(X.xAtt(i,1:4))*(-X.xPos(i,1:3))'; %�@�̍��W�n�ɂ�����n�������x�N�g��
e = r./norm(r);
torque = 3.0*GMe/(norm(r)^3)*cross(e,X.I*e);
end
