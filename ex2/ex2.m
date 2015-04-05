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

disp('2.Q9')
disp('Qtild = R1 * Q + t1 => transp(R1) * | Qtild = R1 * Q + t1 => transp(R1) * Qtild = I * Q + transp(R1) * t1')
disp('Q = transp(R1) * Qtild - transp(R1) * t1')

disp('2.Q10')
disp('if global coordinate system same as camera one system then')
disp('R1=I, t1=0, Q=Qtilde, q2 = A * [R2 t2] * [Q; 1]')
disp('=> R2tilde = R2 * I = R2, t2tilde = t2 - R2 * I * 0 = t2')
disp('=> q2 = A * [R2tilde t2tilde] * [Qtilde; 1] = A * [R2 t2] * [Q; 1]')
disp('=> true')

disp('2.Q11')
load TwoImageData.mat
F = transpose(inv(A)) * CrossOp(T2) * R2 / A;
disp(F);

disp('2.Q12')
fig2 = figure('Name', 'IM2 - annotate IM1');
imshow(im2);
fig1 = figure('Name', 'IM1 - annotate IM1');
imshow(im1);
[x y] = ginput(1);
q1 = transpose([x y 1]);
disp("point in image 1 (q1): ");
disp(q1);
l2 = F * q1;
disp("line in image 2 (l2): ");
disp(l2);
figure(fig2);
DrawImageLine(size(im2, 1), size(im2, 2), transpose(l2));

disp('2.Q13')
fig1 = figure('Name', 'IM1 - annotate IM2');
imshow(im1);
fig2 = figure('Name', 'IM2 - annotate IM2');
imshow(im2);
[x y] = ginput(1);
q2 = transpose([x y 1]);
disp("point in image 2 (q2): ");
disp(q1);
l1 = transpose(q2) * F;
disp("line in image 1 (l1): ");
disp(l2);
figure(fig1);
DrawImageLine(size(im2, 1), size(im2, 2), l1);


disp('2.Q14')
Q = PointsInPlane();
R = Rot(0.2, -0.3, 0.1);
t = [0.8866; 0.5694; 0.1911];
A = [1000 0 300;0 1000 200; 0 0 1];
P = A * [R t];
q = P * [Q; ones(1, size(Q, 2))];
q1 = q;
q(1,:) = q(1,:)./q(3,:);
q(2,:) = q(2,:)./q(3,:);
q(3,:) = q(3,:)./q(3,:);
figure();
plot(q(1,:),q(2,:),'.');

disp('2.Q15')
disp('H is : ');
H = P * [1./sqrt(2) 0 1; 0 1 0.5; 1./sqrt(2) 0 5; 0 0 1];
disp(H);

disp('2.Q15')
disp('TODO');
%disp('reverse H is : ');
%disp(inv(H));
%qp = inv(H) * q1;
%H = inv(A) * [transpose(R) -t] * [1./sqrt(2) 0 1; 0 1 0.5; 1./sqrt(2) 0 5; 0 0 1];
%disp(H);
%qp = H * q1;
%disp('qp: ');
%disp(qp(1:3,1:3))
%disp('Q : ');
%disp(Q(1:3,1:3));