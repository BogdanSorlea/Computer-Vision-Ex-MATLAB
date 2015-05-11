close all;
clear all;
clc;

load('CamMotionData.mat');

sigma = 3;

[f1, d1] = vl_sift(Im1, 'FirstOctave', 1);
[f2, d2] = vl_sift(Im2, 'FirstOctave', 1);
[f3, d3] = vl_sift(Im3, 'FirstOctave', 1);

[M12,E12,R12,t12] = MatchImagePair(f1,d1,f2,d2,K,sigma);
[M23,E23,R23,t23] = MatchImagePair(f2,d2,f3,d3,K,sigma);

[~,Idx12,Idx23] = intersect(M12(2,:), M23(1,:));

q1 = [f1(1:2,M12(1,Idx12)); ones(1,size(Idx12,1))];
q2 = [f2(1:2,M12(2,Idx12)); ones(1,size(Idx12,1))];
q3 = [f3(1:2,M23(2,Idx23)); ones(1,size(Idx23,1))];
q1n = normalize2D(q1);
q2n = normalize2D(q2);
q3n = normalize2D(q3);

R1 = eye(3);
t1 = zeros(3,1);

P1 = K * [R1 t1];
P2 = K * [R12 t12];

Q = [];

for i=1:size(q1,2)
    Q = [Q ...
        homogenize(triangulate(P1, P2, q1n(:,i), q2n(:,i)))]; %#ok<AGROW>
end;

P3 = resectioning(Q, q3n);
q3p = P3 * Q;

n = [];
for i=1:size(q3,2)
    n = [n norm(q3(:,i) - q3p(:,i))]; %#ok<AGROW>
end;

n = n-30;
idx = sign(n);
n(idx==1) = 0;
n(idx==-1) = 1;
n(idx==0) = 0;

disp('All seem to have an error > 30.');

























