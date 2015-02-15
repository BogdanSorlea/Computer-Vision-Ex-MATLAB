close all
clear all
clc

disp('1.Q1')
inhomogeneous([1;2;1])
inhomogeneous([4;2;2])
inhomogeneous([6;4;-1])
inhomogeneous([5;3;0.5])

disp('1.Q2')
inhomogeneous([1;10;-3;1])
inhomogeneous([2;-4;1.1;2])
inhomogeneous([0;0;-1;10])
inhomogeneous([-15;3;6;3])

disp('1.Q3')
disp([1;2;-3])

disp('1.Q4')
pointOnLine([3;0;1],[1;2;-3])
pointOnLine([6;0;2],[1;2;-3])
pointOnLine([1;1;2],[1;2;-3])
pointOnLine([1;1;1],[1;2;-3])
pointOnLine([110;-40;10],[1;2;-3])
pointOnLine([11;4;1],[1;2;-3])

disp('1.Q5')
linesIntersection([1;1;-1],[-1;1;-3])

disp('1.Q6')
disp('10*sx+2*s; 10*sy-3s; s')
disp('pinhole camera model with 10mm focal distance, ')
disp('no scaling/shearing and origo offset of [2;-3]')
disp(' ')

disp('1.Q7')
inhomogeneous(computePinhole([10 0 2; 0 10 -3; 0 0 1],[1;2;1]))
inhomogeneous(computePinhole([10 0 2; 0 10 -3; 0 0 1],[4;2;2]))
inhomogeneous(computePinhole([10 0 2; 0 10 -3; 0 0 1],[6;4;-1]))
inhomogeneous(computePinhole([10 0 2; 0 10 -3; 0 0 1],[5;3;0.5]))

disp('1.Q8')
distanceToLine([1/sqrt(2);1/sqrt(2);-1],[0;0;1])
distanceToLine([1/sqrt(2);1/sqrt(2);-1],[sqrt(2);sqrt(2);1])
distanceToLine([1/sqrt(2);1/sqrt(2);-1],[sqrt(2);sqrt(2);4])

disp('1.Q9')
distanceToLine([1/sqrt(2);1/sqrt(2);-1/2*sqrt(2)],[0;0;1])
distanceToLine([1/sqrt(2);1/sqrt(2);-1/2*sqrt(2)],[sqrt(2);sqrt(2);1])
distanceToLine([1/sqrt(2);1/sqrt(2);-1/2*sqrt(2)],[sqrt(2);sqrt(2);4])

Q = Box3D;

disp('1.Q10')
disp('see figure 1.Q10')
P = [1 0 0; 0 1 0; 0 0 1] * [1 0 0 0; 0 1 0 0; 0 0 1 0];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis([-0.3 0.3 -0.3 0.3]);
title('1.Q10');

disp('1.Q11')
disp('see figure 1.Q11')
P = [1 0 0; 0 1 0; 0 0 1] * ...
        [0.9397 0.3420 0 0; -0.3420 0.9397 0 0; 0 0 1.0 0];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis([-0.3 0.3 -0.3 0.3]);
title('1.Q11');
disp('Effect: 20 degrees rotation wrt. the z-axis')

disp('1.Q12')
disp('see figure 1.Q12')
P = [1 0 0; 0 1 0; 0 0 1] * ...
        [0.9397 0.3420 0 0; -0.3420 0.9397 0 0; 0 0 1.0 2];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis([-0.3 0.3 -0.3 0.3]);
title('1.Q12');
disp('Effect: 20 degrees rotation wrt. the z-axis + translation of 2 on z')

disp('1.Q13')
disp('see figure 1.Q13')
P = [1000 0 200; 0 1000 200; 0 0 1] * [1 0 0 0; 0 1 0 0; 0 0 1 0];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('1.Q13');
disp('Effect: origin moved by 200,200 towards the low-left corner, FOV decreased, zoom')

disp('1.Q14')
disp('see figure 1.Q14')
P = [1000 0 300; 0 1000 200; 0 0 1] * [1 0 0 0; 0 1 0 0; 0 0 1 0];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('1.Q14');
disp('Effect: origin moved by 300,200 towards the low-left corner')

disp('1.Q15')
disp('see figure 1.Q15')
P = [1200 0 300; 0 1200 200; 0 0 1] * [1 0 0 0; 0 1 0 0; 0 0 1 0];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('1.Q15');
disp('Effect: FOV further decreased, zoom')

disp('1.Q16')
disp('see figure 1.Q16')
P = [2000 0 300; 0 2000 200; 0 0 3] * [1 0 0 0; 0 1 0 0; 0 0 1 0];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('1.Q16');
disp('Effect: FOV further decreased, zoom, projection changed due to translation')