close all;
clear all;
clc;

disp('9.1.Q1');
disp('Implemented erosion and dilation functions');
disp('     to filter out noise.');
disp('Threshold of 15 seems to work nice');
disp('     on what seems to be the blue channel');
disp('     of the image.');
disp('For the Right images we set all columns < 100');
disp('     to 0 to remove that creepy hand in the');
disp('     upper-left corner');

load('Ex9_PingData.mat');
th = 15;
positions3D = [];

for i=1:24
    imL = ImL{i};
    imR = ImR{i};
    
    channel = 3;
    % work with blue channel
    BaseLchannel = BaseL(:,:,channel);
    BaseRchannel = BaseR(:,:,channel);
    iLchannel = imL(:,:,channel);
    iRchannel = imR(:,:,channel);
    
    % on grayscale - not as optimal -
    % ball lost in image 24
    %{
    BaseLgray = rgb2gray(BaseL);
    BaseRgray = rgb2gray(BaseR);
    iL = rgb2gray(imL);
    iR = rgb2gray(imR);
    %}
    dL = BaseLchannel - iLchannel;
    dR = BaseRchannel - iRchannel;
    
    dL = dL - th;
    idx = sign(dL);
    dL(idx==1) = 255;
    dL(idx==-1) = 0;
    dL(idx==0) = 0;
    dL = setBordersToZero(dL);
    dL = dilation(dilation(erosion(erosion(dL))));
    
    dR = dR - th;
    idx = sign(dR);
    dR(idx==1) = 255;
    dR(idx==-1) = 0;
    dR(idx==0) = 0;
    dR = setBordersToZero(dR);
    dR = dilation(dilation(erosion(erosion(dR))));
    dR(:,1:100) = zeros(size(dR,1),100);
    
    centerL = centerOfMass(dL);
    centerR = centerOfMass(dR);
    
    Q = triangulate(CamL, CamR, ...
            [centerL;1], [centerR;1]);
    positions3D = [positions3D homogenize(Q)]; %#ok<AGROW>
    %{
    figure();
    imagesc(dL);
    colormap gray;
    hold on;
    center = centerOfMass(dL);
    plot(center(2,1), center(1,1), '.');
    hold off;
    %}
    
end;

figure('Name', 'Detected 3D positions.');
plot3(positions3D(1,:), positions3D(2,:), ... 
        positions3D(3,:), ':o');
cameratoolbar;





















