function next_xPos = RungeKuttaPos(X,i,dtPos)
%軌道運動伝播 4次のルンゲクッタ
%xPos，next_xPos,Fは行ベクトル
x = (X.xPos(i,:))';
m = X.m;
F = X.F;
k1 = DynamicsKinematics(x,m,F);
xk2 = x + (dtPos/2.0) * k1;
k2 = DynamicsKinematics(xk2,m,F);
xk3 = x + (dtPos/2.0) * k2;
k3 = DynamicsKinematics(xk3,m,F);
xk4 = x + dtPos * k3;
k4 = DynamicsKinematics(xk4,m,F);
next_xPos = (x + (dtPos/6.0)*(k1+2.0*k2+2.0*k3+k4))';
end

function dxdt = DynamicsKinematics(xPos,m,F)
dxdt = [xPos(4:6);F/m];
end
