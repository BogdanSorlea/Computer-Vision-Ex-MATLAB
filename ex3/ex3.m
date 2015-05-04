close all;
clear all;
clc;

disp('3.Q1.1.1')
R = eye(3);
t1 = [0;0;0];
t2 = [-5;0;2];
t3 = [0.1;0;0.1];
P1 = [R t1];
P2 = [R t2];
P3 = [R t3];
disp('P1:');
disp(P1);
disp('P2:');
disp(P2);
disp('P3:');
disp(P3);

disp('3.Q1.1.2')
Q1 = [2;4;10;1];
q11 = P1 * Q1;
q11 = q11 / q11(3,1);
q12 = P2 * Q1;
q12 = q12 / q12(3,1);
q13 = P3 * Q1;
q13 = q13 / q13(3,1);
disp('q11:');
disp(q11);
disp('q12:');
disp(q12);
disp('q13:');
disp(q13);

disp('3.Q1.1.3')
figure();
scatter3([t1(1) t2(1) t3(1)], [t1(2) t2(2) t3(2)], [t1(3) t2(3) t3(3)]);
disp('All cameras in the same plane, pointing in the same direction');
disp('Camera one and three very close together, camera two further away');

disp('3.Q1.2')
Q = Est3D(q11, P1, q12, P2);
Q = Q / Q(4,1);
disp('Q:');
disp(Q);
disp('Q1:');
disp(Q1);

disp('3.Q1.2.1')
q21 = [-0.1667; 0.3333; 1];
q22 = [-0.5000; 0.2857; 1];
Q2 = Est3D(q21, P1, q22, P2);
Q2 = Q2 / Q2(4,1);
disp('Q2:');
disp(Q2);

disp('3.Q1.2.2')
q23 = P3 * Q2;
q23 = q23 / q23(3,1);
disp('q23:');
disp(q23);

disp('3.Q1.3.1')
Q2 = [-2; 4; 12; 1];
q22 = P2 * Q2;
q22 = q22 / q22(3,1);
q23 = P3 * Q2;
q23 = q23 / q23(3,1);

q22n = q22 + [0.1; 0.1; 0];
q23n = q23 + [0.1; 0.1; 0];

disp('3.Q1.3.2')
Q2n2 = Est3D(q21, P1, q22n, P2);
Q2n2 = Q2n2 / Q2n2(4,1);
disp('Q2n2:');
disp(Q2n2);

disp('3.Q1.3.3')
Q2n3 = Est3D(q21, P1, q23n, P2);
Q2n3 = Q2n3 / Q2n3(4,1);
disp('Q2n3:');
disp(Q2n3);

disp('3.Q1.3.4')
disp('Geometry, man!');

disp('3.Q1.4')
clear all;
close all;
load TwoImageData.mat
P1 = A * [R1 T1];
P2 = A * [R2 T2];
fig1 = figure('Name', 'IM1');
imshow(im1);
fig2 = figure('Name', 'IM2');
imshow(im2);
%{
[x2 y2] = ginput(1);
figure(fig1);
[x1 y1] = ginput(1);
disp('2::');
disp([x2 y2]);
disp('1::');
disp([x1 y1]);
%}

%{
x2 = 406.71;
y2 = 306.39;
x1 = 401.87;
y1 = 308.00;
%}

x2 = (406.71 - 401.39) / 401.39;
y2 = (306.39 - 308.09) / 308.09;
x1 = (401.87 - 401.39) / 401.39;
y1 = (308.00 - 308.09) / 308.09;

disp(x1);
disp(y1);
disp(x2);
disp(y2);

Q = Est3D([x1; y1; 1], P1, [x2; y2; 1], P2);
disp('Q:');
Q = Q / Q(4,1);
disp(Q);

disp('3.Q2')

