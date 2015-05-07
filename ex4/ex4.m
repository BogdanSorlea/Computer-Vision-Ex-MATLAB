close all;
clear all;
clc;

sigma = 2;
im = imread('TestIm1.bmp');
k = 0.06;
th = .2:.2:.8;
fTh = .05;
figure('Name', 'Original Image');
image(im);
colormap gray;

t = sigma * sigma;
x = -3 * ceil(sigma) : 3 * ceil(sigma);
g = exp(-x.*x./(2*t)) / sqrt(2*pi*t);
gx = (-x/t) .* exp(-x.*x ./ (2*t)) / sqrt(2*pi*t);

%{
figure('Name', 'horiz blur');
image(filter2(g, im, 'same'));
colormap gray;

figure('Name', 'vert blur');
image(filter2(g', im, 'same'));
colormap gray;

figure('Name', 'combined blur');
image(filter2(g, filter2(g', im, 'same'), 'same'));
colormap gray;
%}

figure('Name', 'y search - horizontal lines');
image(filter2(g, im, 'same'));
colormap gray;

figure('Name', 'Iy (differentiated)');
image(filter2(gx', filter2(g, im, 'same'), 'same'));
colormap gray;

% this works also as
%{ 
figure('Name', 'Iy (differentiated) - commutativity');
image(filter2(g, filter2(gx', im, 'same'), 'same'));
colormap gray;
%}

figure('Name', 'x search - vertical lines');
image(filter2(gx, im, 'same'));
colormap gray;

figure('Name', 'Ix (differentiated)');
image(filter2(g', filter2(gx, im, 'same'), 'same'));
colormap gray;

% this works also as
%{
figure('Name', 'Ix (differentiated) - commutativity');
image(filter2(gx, filter2(g', im, 'same'), 'same'));
colormap gray;
%}

Ix = filter2(g', filter2(gx, im, 'same'), 'same');
Iy = filter2(gx', filter2(g, im, 'same'), 'same');

Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;

a = filter2(g, Ix2, 'same');
b = filter2(g, Iy2, 'same');
c = filter2(g, Ixy, 'same');

figure('Name', 'C(x, y) component: a');
image(a);
colormap gray;

figure('Name', 'C(x, y) component: b');
image(b);
colormap gray;

figure('Name', 'C(x, y) component: c');
image(c);
colormap gray;

absum = a + b;
r = a .* b - c .* c - k * absum .* absum;

figure('Name', 'Harris score: r');
image(r);
colormap gray;

maxR = max(max(r));

for i=1:size(th,2)
    thR = r - th(1,i) * maxR;
    idx = sign(thR);
    thR(idx==1) = 255;
    thR(idx==-1) = 0;
    thR(idx==0) = 0;
    figure('Name', ['Thresholding for: ', num2str(th(1,i))]);
    image(thR);
    colormap gray;
end;

thR = r - fTh * maxR;
idx = sign(thR);
thR(idx==-1) = 0;
thR(idx==0) = 0;

for i=2:size(thR,1)-1
    for j=2:size(thR,2)-1
        if not(thR(i,j) > thR(i+1,j) && ...
                thR(i,j) >= thR(i-1,j) && ...
                thR(i,j) > thR(i,j+1) && ...
                thR(i,j) >= thR(i,j-1))
            thR(i,j) = 0;
        end;
    end;
end;

figure('Name', ['Thresholding + supression for: ', num2str(fTh)]);
image(thR);
colormap gray;

corners = [;];

for i=2:size(thR,1)-1
    for j=2:size(thR,2)-1
        if thR(i,j) > 0
            corners(:,end+1) = [i; j];  %#ok<SAGROW>
        end;
    end;
end;

figure('Name', 'Original image and Harris corners');
image(im);
colormap gray;
hold on;
plot(corners(2,:), corners(1,:), '.');
hold off;

% HOUSE 1
im = imread('House1.bmp');

Ix = filter2(g', filter2(gx, im, 'same'), 'same');
Iy = filter2(gx', filter2(g, im, 'same'), 'same');

Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;

a = filter2(g, Ix2, 'same');
b = filter2(g, Iy2, 'same');
c = filter2(g, Ixy, 'same');

absum = a + b;
r = a .* b - c .* c - k * absum .* absum;

maxR = max(max(r));

thR = r - fTh * maxR;
idx = sign(thR);
thR(idx==-1) = 0;
thR(idx==0) = 0;

for i=2:size(thR,1)-1
    for j=2:size(thR,2)-1
        if not(thR(i,j) > thR(i+1,j) && ...
                thR(i,j) >= thR(i-1,j) && ...
                thR(i,j) > thR(i,j+1) && ...
                thR(i,j) >= thR(i,j-1))
            thR(i,j) = 0;
        end;
    end;
end;

corners = [;];

for i=2:size(thR,1)-1
    for j=2:size(thR,2)-1
        if thR(i,j) > 0
            corners(:,end+1) = [i; j];  %#ok<SAGROW>
        end;
    end;
end;

figure('Name', 'HOUSE 1 and Harris corners');
image(im);
colormap gray;
hold on;
plot(corners(2,:), corners(1,:), '.');
hold off;

% HOUSE 2
im = imread('House2.bmp');

Ix = filter2(g', filter2(gx, im, 'same'), 'same');
Iy = filter2(gx', filter2(g, im, 'same'), 'same');

Ix2 = Ix .* Ix;
Iy2 = Iy .* Iy;
Ixy = Ix .* Iy;

a = filter2(g, Ix2, 'same');
b = filter2(g, Iy2, 'same');
c = filter2(g, Ixy, 'same');

absum = a + b;
r = a .* b - c .* c - k * absum .* absum;

maxR = max(max(r));

thR = r - fTh * maxR;
idx = sign(thR);
thR(idx==-1) = 0;
thR(idx==0) = 0;

for i=2:size(thR,1)-1
    for j=2:size(thR,2)-1
        if not(thR(i,j) > thR(i+1,j) && ...
                thR(i,j) >= thR(i-1,j) && ...
                thR(i,j) > thR(i,j+1) && ...
                thR(i,j) >= thR(i,j-1))
            thR(i,j) = 0;
        end;
    end;
end;

corners = [;];

for i=2:size(thR,1)-1
    for j=2:size(thR,2)-1
        if thR(i,j) > 0
            corners(:,end+1) = [i; j];  %#ok<SAGROW>
        end;
    end;
end;

figure('Name', 'HOUSE 2 and Harris corners');
image(im);
colormap gray;
hold on;
plot(corners(2,:), corners(1,:), '.');
hold off;

disp('4.Q1.1');
disp('What is rang?');
disp('Anyways, rank 1');
disp('    If filter width too small, then');
disp('    some small ridges (some due to noise)');
disp('    would appear as edges.');
disp('    Columns are linearly dependent on one');
disp('    another because the filter structure');
disp('    is in such a way that adjacent pixels');
disp('    are considered.');

disp('4.Q1.2');
disp('Gaussian blur is obtained by running');
disp('    image(filter2(g, filter2(g'', im, ''same''), ''same''))');
disp('    i.e. convolution after convolution,');
disp('    first bluring in one direction, then the other');

disp('4.Q1.3');
disp('Not sure what images we''re talking about...');
disp('    Displaying a, b and c.');

disp('4.Q1.4');
disp('Displaying the Harris score.');

disp('4.Q1.5');
disp('Max Harris score is:');
disp(['   ', num2str(maxR)]);

disp('4.Q1.6');
disp('Thresholding the Harris score image with');
disp(['    ', mat2str(th), ' of max Harris score']);  

disp('4.Q1.7');
disp('Chosen threshold: 0.2');

disp('4.Q1.8');
disp('Coordinates extracted and displayed');
disp('     How come image() and imagesc() display different');
disp('     images for the same input image?!');

disp('4.Q1.9');
disp('Images displayed');

disp('4.Q2.1')
figure();
imshow(edge(imread('TestIm1.bmp'), 'Canny'));
colormap gray;
figure();
imshow(edge(imread('TestIm2.bmp'), 'Canny'));
colormap gray;
figure();
imshow(edge(imread('House1.bmp'), 'Canny'));
colormap gray;
figure();
imshow(edge(imread('House2.bmp'), 'Canny'));
colormap gray;

disp('4.Q2.2')
figure();
imshow(edge(imread('TestIm2.bmp'), 'Canny', [0.7 0.9]));
colormap gray;
disp('Low and high threshold, based on which some gradients');
disp('  will be included/ignored if difference too small');
