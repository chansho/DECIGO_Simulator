%
tl     = log_att.time;
log.P1 = log_att.data(:,1);
log.Q1 = log_att.data(:,2);
log.R1 = log_att.data(:,3);
log.P2 = log_att.data(:,4);
log.Q2 = log_att.data(:,5);
log.R2 = log_att.data(:,6);
log.x1 = log_rel.data(:,1);
log.y1 = log_rel.data(:,2);
log.z1 = log_rel.data(:,3);
log.p1 = log_rel.data(:,4);
log.q1 = log_rel.data(:,5);
log.r1 = log_rel.data(:,6);
log.x2 = log_rel.data(:,7);
log.y2 = log_rel.data(:,8);
log.z2 = log_rel.data(:,9);
log.p2 = log_rel.data(:,10);
log.q2 = log_rel.data(:,11);
log.r2 = log_rel.data(:,12);

figure(1)
plot(log.P1)
hold on
plot(log.Q1)
plot(log.R1)
plot(log.P2)
plot(log.Q2)
plot(log.R2)
legend()

figure(2)
plot(log.x1)
hold on
plot(log.y1)
plot(log.z1)
plot(log.p1)
plot(log.q1)
plot(log.r1)

