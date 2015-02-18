close all;
clear all;
clc;

Q = Box3D;

disp('2.Q1')
disp('see figure 2.Q1')
R = Rot(0.2, -0.3, 0.1);
t = [0.8866; 0.5694; 0.1911];
A = [1000 0 300;0 1000 200; 0 0 1];
P = A * [R t];
q = P * [Q; ones(1, size(Q, 2))];
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('2.Q1');
disp('Effect: object rotated on all 3 axis')

disp('2.Q2')
disp('see figure 2.Q2')
Ap = [1000 0 0; 0 1000 0; 0 0 1];
Aq = [1 0 300; 0 1 200; 0 0 1];
pd = Ap * [R t] * [Q; ones(1, size(Q, 2))];
pd(1,:) = pd(1,:)./pd(3,:);
pd(2,:) = pd(2,:)./pd(3,:);
pd(3,:) = pd(3,:)./pd(3,:);
pc = zeros(size(pd(1:2,:)));
for i=1:1:size(pd, 2)
    r = sqrt(pd(1,i)^2 + pd(2,i)^2);
    pc(1:2,i) = pd(1:2,i) * (1 - 1e-6 * r^2 + 1e-12 * r^4);
end
q = Aq * [pc; ones(1, size(pc,2))];
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('2.Q2');
disp('Effect: radial distortion - barrel')

disp('2.Q3')
disp('see figure 2.Q3')
pc = zeros(size(pd(1:2,:)));
for i=1:1:size(pd, 2)
    r = sqrt(pd(1,i)^2 + pd(2,i)^2);
    pc(1:2,i) = pd(1:2,i) * (1 - 1e-6 * r^2);
end
q = Aq * [pc; ones(1, size(pc,2))];
figure();
plot(q(1,:),q(2,:),'.');
axis equal;
axis([0 640 0 480]);
title('2.Q3');
disp('Effect: radial distortion - barrel (less distort than 2.Q2)')

disp('2.Q4')
disp('done')

disp('2.Q5')
A = [100 0 300; 0 1000 200; 0 0 1];
R1 = eye(3);
t1 = zeros(3, 1);
R2 = Rot(-0.1,0.1,0);
t2 = [0.2; 2; 0.1];
Q = [1; 0.5; 4; 1];
q1 = A * [R1 t1] * Q;
q2 = A * [R2 t2] * Q;
q1 = [q1(1,1) ./ q1(3,1); q1(2,1) ./ q1(3,1)];
q2 = [q2(1,1) ./ q2(3,1); q2(2,1) ./ q2(3,1)];
disp('q1 = ')
disp(q1)
disp('q2 = ')
disp(q2)


disp('2.Q6')
F = transpose(inv(A)) * CrossOp(t2) * R2 / A; % replaced inv() with /
disp('F = ')
disp(F)

disp('2.Q7')
l2 = F * [q1; 1];
disp('line is')
disp(l2)

disp('2.Q8')
is_on_epipolar_line = transpose([q2; 1]) * l2;
disp(is_on_epipolar_line)
disp('if result is zero, then q2 is on the epipolar line in image 2')
disp('Observation: value is smaller than femto (10^15), so it is')
disp('  probably 0 - precision lost due to rounding to 4 decimal digits')
disp('Reason: a point is on a line if transpose(line) * point = 0')

