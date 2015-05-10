clear all;
close all;
clc;

disp('8.Q1');
load('Qtest.mat');
load('TwoImageData.mat');
% q1, q2, Q loaded

q1 = normalize2D(homogenize2D(q1));
q2 = normalize2D(homogenize2D(q2));

Fest = Fest_8point(q1, q2);

disp('F - estimated (from/for Qtest)');
disp(Fest);
disp('This matrix should be as close to 0 as possible.');
disp(q2' * Fest * q1);

Ftrue = transpose(inv(A)) * CrossOp(T2) * R2 / A;

disp('F - true (from/for TwoImageMat)');
disp(Ftrue);
disp('This matrix should be as close to 0 as possible.');
disp(q2' * Ftrue * q1);


[fa, da] = vl_sift(single(im1));
[fb, db] = vl_sift(single(im2));

[matches, scores] = vl_ubcmatch(da,db);
nMatch = size(matches,2);

disp('8.Q2');
SIFTrun('Features',75,im1,im2,0);

disp('8.Q3');
idx = randperm(nMatch);
idx = idx(1:8);
qa = [fa(1:2,matches(1,idx)); ones(1,8)];
qb = [fb(3:4,matches(2,idx)); ones(1,8)];
qa = normalize2D(homogenize2D(qa));
qb = normalize2D(homogenize2D(qb));
Fest = Fest_8point(qa, qb);
disp('F - estimated (from/for TwoImageMat)');
disp(Fest);

q1 = [fa(1:2,matches(1,:)); ones(1,nMatch)];
q2 = [fb(3:4,matches(2,:)); ones(1,nMatch)];
q1 = normalize2D(homogenize2D(q1));
q2 = normalize2D(homogenize2D(q2));
nIn = 0;

for cM=1:nMatch
    if FSampDist(Fest, q1(:,cM), q2(:,cM)) < 3.84*3^2
        nIn = nIn + 1;
    end;
end;
disp('Number of inliers');
disp(nIn);
disp('Not really sure what 3.84 * 3 ^ 2 means');
disp('     other than being a RANSAC threshold');

b = Ftrue(:);
a = Fest(:);
dist = a'*b/(norm(a)*norm(b));
disp('Distance between true and estimated F');
disp(dist);

disp('8.Q4');
disp('Number of inliers');
disp(nIn);
disp('Number of SIFT matches');
disp(nMatch);
disp('This means that Fest already optimal, given ...');
disp('     3.84*3^2 threshold.');









