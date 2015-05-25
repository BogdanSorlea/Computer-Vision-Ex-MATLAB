close all;
clear all;
clc;

noPics = 20;

%{
Options.Resize=false;
ObjectDetection('Images/1.jpg', ...
    'HaarCascades/haarcascade_frontalface_alt.mat', ...
    Options);
%}

Options.Resize=false;

for i=1:noPics
    filename = sprintf('experiment_faces/%d.JPG', ...
        i);

    ObjectDetection(filename, ...
        'HaarCascades/haarcascade_frontalface_alt.mat', ...
        Options);  
end;