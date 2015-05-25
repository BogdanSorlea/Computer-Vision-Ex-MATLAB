close all;
clear all;
clc;

%{
Options.Resize=false;
ObjectDetection('Images/1.jpg', ...
    'HaarCascades/haarcascade_frontalface_alt.mat', ...
    Options);
%}

sets = 40;
picsPerSet = 6;

% image sets that feature a female subject
females = [8, 12, 14, 15, 22, 30, 35];

Options.Resize=false;

for i=1:sets
    for j=1:picsPerSet
        if ismember(i, females)
            subject = 'f';
        else
            subject = 'm';
        end;
        if i < 10
            filename = sprintf('AAM_faces/0%d-%d%s.jpg', ...
                i, j, subject);
        else
            filename = sprintf('AAM_faces/%d-%d%s.jpg', ...
                i, j, subject);
        end;
        
        ObjectDetection(filename, ...
            'HaarCascades/haarcascade_frontalface_alt.mat', ...
            Options);
        
    end;
end;