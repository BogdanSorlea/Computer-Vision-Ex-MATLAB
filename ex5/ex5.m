close all;
clear all;
clc;

%noOfHPeaks = 10;
%houghTh = .2;

noOfHPeaks = 10;
houghTh = .2;

imOriginal = imread('BookImage.jpg');
im = mean(imOriginal, 3);

figure('Name', 'BookImage, edge detection: Canny');
imshow(edge(im, 'Canny'));

figure('Name', 'BookImage, edge detection: Laplacian of Gaussian');
imshow(edge(im, 'log'));

figure('Name', 'BookImage, edge detection: Prewitt');
imshow(edge(im, 'Prewitt'));

figure('Name', 'BookImage, edge detection: Roberts');
imshow(edge(im, 'Roberts'));

figure('Name', 'BookImage, edge detection: Sobel');
imshow(edge(im, 'Sobel'));

figure('Name', 'BookImage, edge detection: zerocross');
imshow(edge(im, 'zerocross'));

disp('5.Q1.1');
disp('Running with default params (e.g. threshold):');
disp('     More noisy: Canny, LoG, zerocross');
disp('     Less noisy: Prewitt, Roberts, Sobel');
disp('     More continous edges: Canny, LoG, zerocross');
disp('     Less continous edges: Prewitt, Roberts, Sobel');
disp('     More eroded edges: LoG, zerocross');
disp('     Less eroded edges: Canny, Prewitt, Roberts, Sobel');

imSobel = edge(im, 'Sobel');
[H, T, R] = hough(imSobel);

disp('5.Q1.2');
disp('Interpretation of params:');
disp('     H - the Hough transform matrix');
disp('     T - (theta) the angle array over which the matrix is generated [-pi/2 to pi/2-1]');
disp('     R - (rho) the distance array over which the matrix is generated [-diag to +diag]');
disp('         where diag is equal to the length of the image diagonal, calculated using image W and H');

figure('Name', 'BookImage, Hough space for Sobel edges');
image(H);
colormap gray;

disp('5.Q1.3');
disp('Hough space displayed.');

H2 = H / max(H(:));
H2 = H2 .^ 0.5;

figure('Name', 'BookImage, Hough space (normalized) for Sobel edges');
image(H2 * 255);
colormap gray;

disp('5.Q1.4');
disp('The transformation normalizes the Hough matrix');
disp('     resulting in each element being <= 1');
disp('     and amplification of some values');
disp('     (the lower the more amplified).');
disp('     This is to give a chance to more lines to be');
disp('     considered, if that is what is intended here.');

peaks = houghpeaks(H, noOfHPeaks, 'Threshold', houghTh);

disp('5.Q1.5');
disp('The peaks are:');
disp(peaks);

figure('Name', 'BookImage, Hough space (Sobel) and peaks');
imagesc(H);
colormap gray;
hold on;
plot(peaks(:,2), peaks(:,1), '.');
hold off;

disp('5.Q1.6');
disp('Hough space and peaks displayed.');

% have sanitized DrawImageLine, for it yields
% error for some corner cases (e.g. peaks(3,:))
% which I feel are the ones at the edge of the
% Hough image (i.e. theta = pi/2)
figure('Name', 'BookImage, original and lines (Sobel)');
image(imOriginal);
for i=1:size(peaks,1)
    th = T(1,peaks(i,2));
    th = pi * th / 180;
    rh = R(1,peaks(i,1));
    DrawImageLine(480, 640, [cos(th), sin(th), -rh]);
end;

disp('5.Q1.7');
disp('Original image and lines');

imCanny = edge(im, 'Canny');
[H, T, R] = hough(imCanny);
peaks = houghpeaks(H, noOfHPeaks, 'Threshold', houghTh);
figure('Name', 'BookImage, original and lines (Canny)');
image(imOriginal);
for i=1:size(peaks,1)
    th = T(1,peaks(i,2));
    th = pi * th / 180;
    rh = R(1,peaks(i,1));
    DrawImageLine(480, 640, [cos(th), sin(th), -rh]);
end;

imPrewitt = edge(im, 'Prewitt');
[H, T, R] = hough(imPrewitt);
peaks = houghpeaks(H, noOfHPeaks, 'Threshold', houghTh);
figure('Name', 'BookImage, original and lines (Prewitt)');
image(imOriginal);
for i=1:size(peaks,1)
    th = T(1,peaks(i,2));
    th = pi * th / 180;
    rh = R(1,peaks(i,1));
    DrawImageLine(480, 640, [cos(th), sin(th), -rh]);
end;

disp('5.Q1.8');
disp('Same applied for Canny and Prewitt edge detection');

disp('5.Q2.1');
disp('Function to compute a line from 2 homogeneous points');
disp('     implemented in lineFromPoints.m');

disp('5.Q2.2');
disp('Function to detect inlier/outlier from line');
disp('     implemented in pointPositionToLine.m');

disp('5.Q2.3');
disp('Function to compute consensus');
disp('     implemented in computeConsensus.m');

disp('5.Q2.4');
disp('Function to randomly draw 2 2D points');
disp('     implemented in random2Draw.m');

ransacIterations = 25;
ransacThreshold = 0.08;
%inliers = 13;
%outliers = 22;
inliers = 20;
outliers = 10;

x = RanLine(inliers, outliers);
bestConsensus = -Inf;

for i=1:ransacIterations
    points = random2Draw(x);
    l = lineFromPoints(points(1,:), points(2,:));
    consensus = computeConsensus(l, x, ransacThreshold);
    if consensus > bestConsensus
        bestModel = l;
        bestConsensus = consensus;
        bestCoords = points;
    end
end;

figure('Name', 'RANSAC assembled');
hold on;
for i=1:size(x, 2)
    colorSpec = '.';
    if all(x(:,i) == bestCoords(:,1)) || ...
        all(x(:,i) == bestCoords(:,2))
            colorSpec = 'sr';
    end;
    plot(x(1,i), x(2,i), colorSpec);
    text(x(1,i), x(2,i), ['\leftarrow ', ...
        num2str(x(1,i)), ', ', num2str(x(2,i))], ...
        'HorizontalAlignment', 'left');
end;
hold off;

%DrawLine(bestModel);

disp('5.Q2.5-6');
disp('Algorithm assembled.');
disp('     Found th=0.04 @ 25 iterations to be acceptable.');

disp(['Best consensus is: ', num2str(bestConsensus)]);