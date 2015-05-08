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
fTh = .05;%.15;%.2;%.23;%.07;

im = imread('House1.bmp');
corners1 = HarrisCorners(im, sigma, k, fTh);
figure('Name', 'House 1 corners');
imagesc(im);
colormap gray;
hold on;
plot(corners1(2,:), corners1(1,:), '.');
hold off;

im = imread('House2.bmp');
corners2 = HarrisCorners(im, sigma, k, fTh);
figure('Name', 'House 2 corners');
imagesc(im);
colormap gray;
hold on;
plot(corners2(2,:), corners2(1,:), '.');
hold off;

exit;
close all;

disp('6.Q1.5');
bestCorners1 = [];
for i=1:size(corners1, 2)
    bestCorner = findBestCorner(corners1(:,i), sigma, ...
        im, corners2);
    bestCorners1 = [bestCorners1 bestCorner]; %#ok<AGROW>
end;

disp('6.Q1.6');
bestCorners2 = [];
for i=1:size(corners2, 2)
    bestCorner = findBestCorner(corners2(:,i), sigma, ...
        im, corners1);
    bestCorners2 = [bestCorners2 bestCorner]; %#ok<AGROW>
end;

disp('6.Q1.7');
disp('Marriage');

marriedCoordinates = [];
for i=1:size(corners1,2)
    %currenti = i
    %bestfor1 = bestCorners1(1,i)
    %bestfor2 = bestCorners2(1,bestCorners1(1,i))
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
    if icolors > size(colors,2)
        icolors = size(colors,2);
    end;
    plot(corner(2,:), corner(1,:), char(colors(1,i)));
end;
hold off;

%{
figure('Name', 'House1');
imagesc(imread('House1.bmp'));
colormap gray;
hold on;
plot(corners1(2,:), corners1(1,:), '.');

hold off;
%}
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');
disp('');