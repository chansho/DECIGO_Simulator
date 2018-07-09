function force = EarthGravity(X,i)
GMe = 3.986004415E5; %地心重力定数 km3 s-2
x = (X.xPos(i,1:3))';
force = -GMe * X.m /(norm(x)^3) * x; %kg km s-2
end
