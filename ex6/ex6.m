close all;
clear all;
clc;

disp('6.Q1.1-2');
disp('Function to select a patch from an image,');
disp('     optimized, implemented in extractPatch.m');

disp('6.Q1.3');
disp('Function to compute cross-correlation between');
disp('     two patches is implemented in crossCorrelation.m');

disp('6.Q1.4');
disp('Function to find best correlated corner is');
disp('     implemented in findBestCorner.m');

sigma = 3;
k = .06;
fTh = .15;%.2;%.23;%.07%.05;
% smaller values of fTh are useless, for
% although it yields more corners,
% the number of matches stays about the same

im1 = imread('House1.bmp');
im2 = imread('House2.bmp');

corners1 = HarrisCorners(im1, sigma, k, fTh);
figure('Name', 'House 1 corners');
imagesc(im1);
colormap gray;
hold on;
plot(corners1(2,:), corners1(1,:), '.');
hold off;

corners2 = HarrisCorners(im2, sigma, k, fTh);
figure('Name', 'House 2 corners');
imagesc(im2);
colormap gray;
hold on;
plot(corners2(2,:), corners2(1,:), '.');
hold off;

disp('6.Q1.5');
bestCorners1 = [];
for i=1:size(corners1, 2)
    patch = extractPatch(im1, sigma, ...
        corners1(1,i), corners1(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im2, corners2);
    bestCorners1 = [bestCorners1 bestCorner]; %#ok<AGROW>
end;

disp('6.Q1.6');
bestCorners2 = [];
for i=1:size(corners2, 2)
    patch = extractPatch(im2, sigma, ...
        corners2(1,i), corners2(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im1, corners1);
    bestCorners2 = [bestCorners2 bestCorner]; %#ok<AGROW>
end;

disp('6.Q1.7');
disp('Marriage');
disp('     Uniqueness method not used, for we have a');
disp('     reduced number of matches as it is, no more wanted');

marriedCoordinates = [];
for i=1:size(corners1,2)
    if bestCorners2(1,bestCorners1(1,i)) == i
        marriedCoordinates = [marriedCoordinates ...
            [i;bestCorners1(1,i)]]; %#ok<AGROW>
    end;
end;

disp('6.Q1.8');

colors = {'y', 'm', 'c', 'r', 'b', 'g'};
markers = {'o', '+', '*', 'x', 's', 'd', 'p', 'h', '^', 'v', '<', '>'};
colorsMarkers = [];

for i=1:size(markers,2)
    for j=1:size(colors,2)
        colorsMarkers = [colorsMarkers strcat(markers(1,i), colors(1,j))]; %#ok<AGROW>
    end;
end;

figure('Name', 'House1');
imagesc(imread('House1.bmp'));
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners1(:,marriedCoordinates(1,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;

hold off;

figure('Name', 'House2');
imagesc(imread('House2.bmp'));
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners2(:,marriedCoordinates(2,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;
hold off;

close all;

disp('6.Q2');

a = 20 * pi / 180;
s = sin(a);
c = cos(a);
H = [c s 0; -s c 0; 0 0 1];
Tr = maketform('projective', H');
im2w20 = imtransform(imread('House2.bmp'),Tr);

corners2Warp20 = HarrisCorners(im2w20, sigma, k, fTh);
figure('Name', '20deg Warped House 2 corners');
imagesc(im2w20);
colormap gray;
hold on;
plot(corners2Warp20(2,:), corners2Warp20(1,:), '.');
hold off;

bestCorners1Warp20 = [];
for i=1:size(corners1, 2)
    patch = extractPatch(im1, sigma, ...
        corners1(1,i), corners1(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im2w20, corners2Warp20);
    bestCorners1Warp20 = [bestCorners1Warp20 bestCorner]; %#ok<AGROW>
end;

bestCorners2Warp20 = [];
for i=1:size(corners2Warp20, 2)
    patch = extractPatch(im2w20, sigma, ...
        corners2Warp20(1,i), corners2Warp20(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im1, corners1);
    bestCorners2Warp20 = [bestCorners2Warp20 bestCorner]; %#ok<AGROW>
end;

marriedCoordinates = [];
for i=1:size(corners1,2)
    if bestCorners2Warp20(1,bestCorners1Warp20(1,i)) == i
        marriedCoordinates = [marriedCoordinates ...
            [i;bestCorners1Warp20(1,i)]]; %#ok<AGROW>
    end;
end;

figure('Name', '20deg Warped House 1 corners');
imagesc(imread('House1.bmp'));
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners1(:,marriedCoordinates(1,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;

hold off;

figure('Name', '20deg Warped House 2 corners');
imagesc(im2w20);
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners2Warp20(:,marriedCoordinates(2,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;
hold off;

% 45deg

a = 45 * pi / 180;
s = sin(a);
c = cos(a);
H = [c s 0; -s c 0; 0 0 1];
Tr = maketform('projective', H');
im2w40 = imtransform(imread('House2.bmp'),Tr);

corners2Warp40 = HarrisCorners(im2w40, sigma, k, fTh);
figure('Name', '45deg Warped House 2 corners');
imagesc(im2w40);
colormap gray;
hold on;
plot(corners2Warp40(2,:), corners2Warp40(1,:), '.');
hold off;

bestCorners1Warp40 = [];
for i=1:size(corners1, 2)
    patch = extractPatch(im1, sigma, ...
        corners1(1,i), corners1(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im2w40, corners2Warp40);
    bestCorners1Warp40 = [bestCorners1Warp40 bestCorner]; %#ok<AGROW>
end;

bestCorners2Warp40 = [];
for i=1:size(corners2Warp40, 2)
    patch = extractPatch(im2w40, sigma, ...
        corners2Warp40(1,i), corners2Warp40(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im1, corners1);
    bestCorners2Warp40 = [bestCorners2Warp40 bestCorner]; %#ok<AGROW>
end;

marriedCoordinates = [];
for i=1:size(corners1,2)
    if bestCorners2Warp40(1,bestCorners1Warp40(1,i)) == i
        marriedCoordinates = [marriedCoordinates ...
            [i;bestCorners1Warp40(1,i)]]; %#ok<AGROW>
    end;
end;

figure('Name', '45deg Warped House 1 corners');
imagesc(imread('House1.bmp'));
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners1(:,marriedCoordinates(1,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;

hold off;

figure('Name', '45deg Warped House 2 corners');
imagesc(im2w40);
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners2Warp40(:,marriedCoordinates(2,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;
hold off;

% s=0.1, c=1 (or I3)

s = .1;
H = [1 s 0; -s 1 0; 0 0 1];
Tr = maketform('projective', H');
im2w1 = imtransform(imread('House2.bmp'),Tr);

corners2Warp1 = HarrisCorners(im2w1, sigma, k, fTh);
figure('Name', 'special Warped House 2 corners');
imagesc(im2w1);
colormap gray;
hold on;
plot(corners2Warp1(2,:), corners2Warp1(1,:), '.');
hold off;

bestCorners1Warp1 = [];
for i=1:size(corners1, 2)
    patch = extractPatch(im1, sigma, ...
        corners1(1,i), corners1(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im2w1, corners2Warp1);
    bestCorners1Warp1 = [bestCorners1Warp1 bestCorner]; %#ok<AGROW>
end;

bestCorners2Warp1 = [];
for i=1:size(corners2Warp1, 2)
    patch = extractPatch(im2w1, sigma, ...
        corners2Warp1(1,i), corners2Warp1(2,i));
    bestCorner = findBestCorner(patch, sigma, ...
        im1, corners1);
    bestCorners2Warp1 = [bestCorners2Warp1 bestCorner]; %#ok<AGROW>
end;

marriedCoordinates = [];
for i=1:size(corners1,2)
    if bestCorners2Warp1(1,bestCorners1Warp1(1,i)) == i
        marriedCoordinates = [marriedCoordinates ...
            [i;bestCorners1Warp1(1,i)]]; %#ok<AGROW>
    end;
end;

figure('Name', 'special Warped House 1 corners');
imagesc(imread('House1.bmp'));
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners1(:,marriedCoordinates(1,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;

hold off;

figure('Name', 'special Warped House 2 corners');
imagesc(im2w1);
colormap gray;
hold on;
for i=1:size(marriedCoordinates,2)
    corner = corners2Warp1(:,marriedCoordinates(2,i));
    icolors = i;
    if icolors > size(colorsMarkers,2)
        icolors = size(colorsMarkers,2);
    end;
    plot(corner(2,:), corner(1,:), char(colorsMarkers(1,i)));
end;
hold off;

disp('6.Q3');
disp('     See ex6p2.m');