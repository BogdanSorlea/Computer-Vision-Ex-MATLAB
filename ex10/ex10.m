close all;
clear all;
clc;

disp('10.Q1');

Images = [];
ImagesRGB = [];
nIm = 100;
queryImNumber = 23;
disp(['Image for query is: ', num2str(queryImNumber)]);
clusters = 50;
noMostSimilarPairsToDisplay = 2;

for cIm=0:(nIm-1)
    if cIm < 10
        name = sprintf('ukbench_small/ukbench0000%d.jpg', ...
            cIm);
    elseif cIm < 100
        name = sprintf('ukbench_small/ukbench000%d.jpg', ...
            cIm);
    end;
    Images{cIm+1} = rgb2gray(imread(name)); %#ok<SAGROW>
    ImagesRGB{cIm+1} = imread(name); %#ok<SAGROW>
end;

SIFTdescr = [];

for cIm=1:nIm
    imwrite(Images{cIm}, 'HaaScript.pgm');
    [~, descrips, ~] = sift('HaaScript.pgm'); % image ~ locs
    SIFTdescr{cIm} = descrips; %#ok<SAGROW>
end;

SIFTdescrAll = [];

for cIm=1:nIm
    if cIm ~= queryImNumber
        SIFTdescrAll = [SIFTdescrAll; SIFTdescr{cIm}]; %#ok<AGROW>
    end;
end;

disp('10.Q2');

clust = kmeans(SIFTdescrAll, clusters);

histog = [];

for cIm=1:nIm
    histog{cIm} = zeros(clusters,1); %#ok<SAGROW>
    for i=1:size(SIFTdescr{cIm},1)
        word = bestWord(clust, SIFTdescr{cIm}(i,:));
        histog{cIm}(word) = histog{cIm}(word) + 1; %#ok<SAGROW>
    end; 
    %figure('Name', ['Word histogram for image ', num2str(cIm)]);
    %bar(histog{cIm});
end;

histDistance = Inf * ones(size(Images,2),1);
for cIm=1:nIm
    if cIm ~= queryImNumber
        histDistance(cIm) = compareHistograms(histog{cIm}, ...
            histog{queryImNumber});
    end;
end;

disp(histDistance);
[~, idx] = sort(histDistance);

figure('Name', ['Most similar images with image ', ...
    num2str(queryImNumber)]);

image = [ImagesRGB{queryImNumber} ImagesRGB{idx(1)}];

for i=1:size(ImagesRGB{1},2)
    for j=1:15
        image(j,i,1) = 255;
        image(j,i,2) = 0;
        image(j,i,3) = 0;
        image(size(ImagesRGB{1},1)+1-j,i,1) = 255;
        image(size(ImagesRGB{1},1)+1-j,i,2) = 0;
        image(size(ImagesRGB{1},1)+1-j,i,3) = 0;
    end;
end;

for i=1:size(ImagesRGB{1},1)
    for j=1:15
        image(i,j,1) = 255;
        image(i,j,2) = 0;
        image(i,j,3) = 0;
        image(i,size(ImagesRGB{1},2)+1-j,1) = 255;
        image(i,size(ImagesRGB{1},2)+1-j,2) = 0;
        image(i,size(ImagesRGB{1},2)+1-j,3) = 0;
    end;
end;

for i=1:noMostSimilarPairsToDisplay
    image = [image;
        ImagesRGB{idx(i*2)} ImagesRGB{idx(i*2+1)}]; %#ok<AGROW>
end;

imagesc(image);