close all;
clear all;
clc;

disp('7.Q1');

q1 = rand(3,10);
Htrue = [10 0 -1; 1 10 20; .01 0 3];
q2 = Htrue * q1;

q1 = normalize2D(homogenize2D(q1));
q2 = normalize2D(homogenize2D(q2));

Hest = computeHomography(q1, q2);

q2est = Hest * q1;
%s = q2(1,1)/q2est(1,1);
%q2est = q2est * s;
q2est(1,:) = q2est(1,:) ./ q2est(3,:);
q2est(2,:) = q2est(2,:) ./ q2est(3,:);
q2est(3,:) = q2est(3,:) ./ q2est(3,:);

disp(['Norm for Htrue .01: ', num2str(norm(q2est - q2))]);

q1 = rand(3,10);
Htrue = [10 0 -1; 1 10 20; .02 0 3];
q2 = Htrue * q1;

q1 = normalize2D(homogenize2D(q1));
q2 = normalize2D(homogenize2D(q2));

Hest = computeHomography(q1, q2);

q2est = Hest * q1;
q2est(1,:) = q2est(1,:) ./ q2est(3,:);
q2est(2,:) = q2est(2,:) ./ q2est(3,:);
q2est(3,:) = q2est(3,:) ./ q2est(3,:);

disp(['Norm for Htrue .02: ', num2str(norm(q2est - q2))]);

disp('7.Q2');

Ia = imread('ImL.jpg');
Ib = imread('ImR.jpg');
[fa, da] = vl_sift(single(rgb2gray(Ia)));
[fb, db] = vl_sift(single(rgb2gray(Ib)));
[matches, scores] = vl_ubcmatch(da,db);
nMatch = size(matches, 2);

SIFTrun('Painting', 75, Ia, Ib);

disp('7.Q3');
ransacIterations = 100;
ransacThreshold = 1;
bestConsensus = -Inf;

for i=1:ransacIterations
    matchSel = randomNDraw(10, matches);
    
    q1 = fa(1:2,matchSel(1,:));
    q1 = [q1; ones(1,size(q1,2))]; %#ok<AGROW>
    q2 = fb(1:2,matchSel(2,:));
    q2 = [q2; ones(1,size(q2,2))]; %#ok<AGROW>
    q1 = normalize2D(homogenize2D(q1));
    q2 = normalize2D(homogenize2D(q2));

    Hest = computeHomography(q1, q2);
    [consensus, inliers] = computeHomographyConsensus(Hest, ...
        q1, q2, ransacThreshold);
    if consensus > bestConsensus
        bestModel = Hest;
        bestConsensus = consensus;
        bestInliers = inliers;
    end
end;

disp('7.Q4');
q1 = [inliers(1:2,:); ones(1,size(inliers,2))];
q2 = [inliers(3:4,:); ones(1,size(inliers,2))];
Hreest = computeHomography(q1, q2);
T = maketform('projective', Hreest'); %#ok<MTFP1>
ImH = imtransform(Ia, T); %#ok<DIMTRNS>
figure('Name','Q4: imtransform');
imagesc(ImH);
axis image;

disp('7.Q5');
figure('Name','Q5: WarpNView');
WarpNView(Hreest,Ia,Ib);










