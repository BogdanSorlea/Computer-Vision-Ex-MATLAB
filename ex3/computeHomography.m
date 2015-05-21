function Hest = computeHomography(q1, q2)
%COMPUTEHOMOGRAPHY computes the homography best fitting
%   the two sets of corresponding 2D points

q1
q2
biT = [];
x = 1;
y = 2;

for i=1:size(q1,2)
    biT = [biT;
        0 -q2(x,i) q2(x,i)*q1(y,i) 0 -q2(y,i) ...
        q2(y,i)*q1(y,i) 0 -1 q1(y,i); ...
        q2(x,i) 0 -q2(x,i)*q1(x,i) q2(y,i) 0 ...
        -q2(y,i)*q1(x,i) 1 0 -q1(x,i); ...
        -q2(x,i)*q1(y,i) q2(x,i)*q1(x,i) 0 ...
        -q2(y,i)*q1(y,i) q2(y,i)*q1(x,i) 0 ...
        -q1(y,i) q1(x,i) 0]; %#ok<AGROW>
end;

%[eVec, ~] = eig(biT'*biT);
%Hest = reshape(eVec(:,1),3,3);
% alternatively

[~,~,eVec] = svd(biT);
Hest = reshape(eVec(:,end),3,3);

end

