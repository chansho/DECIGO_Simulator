figure(1);
plot3(SC1.xPos(:,1),SC1.xPos(:,2),SC1.xPos(:,3));

figure(2);
plot3(M1.xPos(:,1),M1.xPos(:,2),M1.xPos(:,3));

figure(3);hold on;
plot(SC1.xAtt(:,2));
plot(M1.xAtt(:,2));
hold off;
