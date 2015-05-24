close all;
clear all;
clc;

disp('6.Q3');

im1 = imread('House1.bmp');
im2 = imread('House2.bmp');

SIFTrun('0deg SIFT', im1, im2);

a = 20 * pi / 180;
s = sin(a);
c = cos(a);
H = [c s 0; -s c 0; 0 0 1];
Tr = maketform('projective', H');
im2w20 = imtransform(im2,Tr);

SIFTrun('20deg SIFT', im1, im2w20);

a = 45 * pi / 180;
s = sin(a);
c = cos(a);
H = [c s 0; -s c 0; 0 0 1];
Tr = maketform('projective', H');
im2w45 = imtransform(im2,Tr);

SIFTrun('45deg SIFT', im1, im2w45);

a = 90 * pi / 180;
s = sin(a);
c = cos(a);
H = [c s 0; -s c 0; 0 0 1];
Tr = maketform('projective', H');
im2w90 = imtransform(im2,Tr);

SIFTrun('90deg SIFT', im1, im2w90);

s = .1;
H = [1 s 0; -s 1 0; 0 0 1];
Tr = maketform('projective', H');
im2w1 = imtransform(im2,Tr);

SIFTrun('special SIFT', im1, im2w1);

disp('6.Q4');
load('TwoImageData.mat');

th = 10;

F = transpose(inv(A)) * CrossOp(T2) * R2 / A;
SIFTrunF('0deg SIFT epipolar', im1, im2, F, th);

F = transpose(inv(A)) * CrossOp(T2) * R2 ...
    * Rot(0,0,20 * pi / 180) / A;
SIFTrunF('20deg SIFT epipolar', im1, im2, F, th);

F = transpose(inv(A)) * CrossOp(T2) * R2 ...
    * Rot(0,0,45 * pi / 180) / A;
SIFTrunF('45deg SIFT epipolar', im1, im2, F, th);

F = transpose(inv(A)) * CrossOp(T2) * R2 ...
    * Rot(0,0,90 * pi / 180) / A;
SIFTrunF('45deg SIFT epipolar', im1, im2, F, th);