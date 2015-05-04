close all;
clear all;
clc;

sigma = 3;
im = imread("TestIm1.bmp");
k = 0.06;
%figure();
%image(im);
%colormap gray;

t = sigma * sigma;
x = -3 * ceil(sigma) : 3 * ceil(sigma);
g = exp(-x.*x./(2*t)) / sqrt(2*pi*t);
gx = (-x/t) .* exp(-x.*x ./ (2*t)) / sqrt(2*pi*t);
Ix = filter2(gx, im, 'same');
Ix = filter2(g', Ix, 'same');
Iy = filter2(g, im, 'same');
Iy = filter2(gx', Iy, 'same');

%{
figure();
image(Ix);
colormap gray;
figure();
image(Iy);
colormap gray;
%}

disp('4.Q1.1')
disp("What is rang?")
disp("Anyways, rank 1 - because of kernel structure (width given by sigma, cells adjacent)")

disp('4.Q1.2')
blurred = filter2(g, im, 'same');
blurred = filter2(g', blurred, 'same');

%{
figure();
image(blurred);
colormap gray;
%}

disp('4.Q1.3')
Ix2 = Ix * Ix;
Iy2 = Iy * Iy;
Ixy = Ix * Iy;

gIx2 = filter2(g, Ix2, 'same');
gIy2 = filter2(g, Iy2, 'same');
gIxy = filter2(g, Ixy, 'same');

disp('4.Q1.4')
for i=1:size(gIxy,1)
  for j=1:size(gIxy,2)
    R(i,j) = gIx2(i,j) * gIy2(i,j) - gIxy(i,j) * gIxy(i,j) - k * (gIx2(i,j) + gIy2(i,j)) * (gIx2(i,j) + gIy2(i,j));
  end;
end;
%{
figure();
image(R);
colormap gray;
%}

disp('4.Q1.5')
maxR = -Inf;
for i=1:size(gIxy,1)
  for j=1:size(gIxy,2)
    if R(i,j) > maxR
      maxR = R(i,j);
      maxRCoord = [i j];
    end;
  end;
end;
disp(maxR);
disp(maxRCoord);

disp('4.Q1.6')
tauRange = [0.2 0.4 0.6 0.8];
for tau = tauRange
  %figure();
  filteredR = zeros(size(R,1), size(R,2));
  for i=1:size(R,1)
    for j=1:size(R,2)
      if R(i,j) >= tau
        filteredR(i, j) = 255;
      end;
    end;
  end;
  %image(filteredR);
  %colormap gray;
end;

disp('4.Q1.7')
disp('4.Q1.8')
disp('4.Q1.9')

disp('4.Q2')
im = imread('TestIm1.bmp');
%figure();
%imshow(im);
%imshow(edge(im, 'Canny'));
%colormap gray;
