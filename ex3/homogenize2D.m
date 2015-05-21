function q1 = homogenize2D(q1)
%HOMOGENIZE2D homogenizes a vector of 2D coordinates

% homogenize
q1(1,:) = q1(1,:) ./ q1(3,:);
q1(2,:) = q1(2,:) ./ q1(3,:);
q1(3,:) = q1(3,:) ./ q1(3,:);

end

