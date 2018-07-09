function next_xAtt = UpdateAtt(X,i,dtAtt)
%姿勢運動伝搬 4次のルンゲクッタ
%xAtt,next_xAttは行ベクトル
x = (X.xAtt(i,:))';
I = X.I;
T = X.T;
k1 = DynamicsKinematics(x,I,T);
xk2 = x + (dtAtt/2.0) * k1;
k2 = DynamicsKinematics(xk2,I,T);
xk3 = x + (dtAtt/2.0) * k2;
k3 = DynamicsKinematics(xk3,I,T);
xk4 = x + dtAtt * k3;
k4 = DynamicsKinematics(xk4,I,T);
next_xAtt = (x + (dtAtt/6.0)*(k1+2.0*k2+2.0*k3+k4))';
%normalize quaternion
next_xAtt(1:4) = next_xAtt(1:4)./norm(next_xAtt(1:4));
end

function dxdt = DynamicsKinematics(xAtt,I,T)
q = xAtt(1:4);
omega = xAtt(5:7);
dq = 0.5 * Omega4Kinematics(omega) * q;
domega = inv(I)*(T - cross(omega,(I*omega)));
dxdt = [dq;domega];
end

function OMEGA = Omega4Kinematics(omega)
OMEGA = [   0.0   , omega(3),-omega(2), omega(1);
         -omega(3),   0.0   , omega(1), omega(2);
          omega(2),-omega(1),   0.0   , omega(3);
         -omega(1),-omega(2),-omega(3),   0.0   ];
end
