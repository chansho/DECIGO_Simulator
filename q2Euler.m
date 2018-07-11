function theta = q2Euler(q)
dcm = q2DCM(q);
theta = [atan(dcm(2,3)/dcm(3,3)),atan(-dcm(1,3)/sqrt(dcm(2,3)^2+dcm(3,3)^2)),atan(dcm(1,2)/dcm(1,1))];
end