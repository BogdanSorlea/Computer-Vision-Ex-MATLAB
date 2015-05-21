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
disp('All cameras are pointing in the same direction');
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
Q2n3 = Est3D(q21, P1, q23n, P3);
Q2n3 = Q2n3 / Q2n3(4,1);
disp('Q2n3:');
disp(Q2n3);

disp('3.Q1.3.4')
disp('Geometry, man!');
figure('Name', 'Camera and points');
plot3([t1(1) t2(1) t3(1)], [t1(2) t2(2) t3(2)], ...
    [t1(3) t2(3) t3(3)], '*');
hold on;
text(t1(1), t1(2), t3(3), 'cam 1 \rightarrow', ...
    'HorizontalAlignment','right')
text(t2(1), t2(2), t2(3), ...
    '\leftarrow cam 2', 'HorizontalAlignment','left')
text(t3(1), t3(2), t3(3), ...
    '\leftarrow cam 3', 'HorizontalAlignment','left')
plot3(Q2(1), Q2(2), Q2(3), 'sr');
text(Q2(1), Q2(2), Q2(3), 'Q1 \rightarrow', ...
    'HorizontalAlignment','right')
plot3(Q2n2(1), Q2n2(2), Q2n2(3), 'pr');
text(Q2n2(1), Q2n2(2), Q2n2(3), 'Q2n2 \rightarrow', ...
    'HorizontalAlignment','right')
plot3(Q2n3(1), Q2n3(2), Q2n3(3), 'hr');
text(Q2n3(1), Q2n3(2), Q2n3(3), 'Q2n3 \rightarrow', ...
    'HorizontalAlignment','right')
hold off;

disp('3.Q1.4')
clear all;
close all;
load TwoImageData.mat
P1 = A * [R1 T1];
P2 = A * [R2 T2];
fig1 = figure('Name', 'IM1');
imagesc(im1);
colormap gray;
fig2 = figure('Name', 'IM2');
imagesc(im2);
colormap gray;

[x2, y2] = ginput(1);
figure(fig1);
[x1, y1] = ginput(1);

x1 = x1 - A(1,3);
y1 = y1 - A(2,3);
x2 = x2 - A(1,3);
y2 = y2 - A(2,3);

%x1 = x1 / size(im1,1) / 2;
%y1 = y1 / size(im1,2) / 2;
%x2 = x2 / size(im2,1) / 2;
%y2 = y2 / size(im2,2) / 2;

disp('2::');
disp([x2 y2]);
disp('1::');
disp([x1 y1]);

Q = Est3D([x1; y1; 1], P1, [x2; y2; 1], P2);
disp('Q:');
Q = Q / Q(4,1);
disp(Q);

close all;
clear all;
disp('3.Q2')

imPeterGade = imread('petergade.png');
disp('Select the 4 extreme corners ...');
disp('     starting from the lower-left corner ...');
disp('     going clockwise.');
fig1 = figure('Name', 'Select the 4 corners, SW, CCW');
imagesc(imPeterGade);
colormap gray;
%[x1, y1] = ginput(4);


x1 = [57.0818; 60.7800; 209.4459; 269.3560];
y1 = [224.7105; 69.6228; 67.5175; 218.3947];
x2 = [0; 0; 6.1; 6.1];
y2 = [0; 13.4; 13.4; 0];

%q1 = normalize2D([x1'; y1'; ones(1,size(x1,1))]);
%q2 = normalize2D([x2'; y2'; ones(1,size(x2,1))]);
q1 = [x1'; y1'; ones(1,size(x1,1))];
q2 = [x2'; y2'; ones(1,size(x2,1))];
Hest = computeHomography(q2, q1);

disp('Annotate the first player.');
[x1, y1] = ginput(1);
player1 = Hest * [x1; y1; 1];
player1 = player1 / player1(3,1)

disp('Annotate the second player.');
[x1, y1] = ginput(1);
player2 = Hest * [x1; y1; 1];
player2 = player2 / player2(3,1)

figure('Name', 'Warped field');
Tr = maketform('projective', Hest');
WarpIm = imtransform(imPeterGade, Tr, 'YData', ...
    [0 255], 'XData', [0 255]);
imagesc(WarpIm);