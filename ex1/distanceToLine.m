function distance = distanceToLine(line, point)
%DISTANCETOLINE computes distance from a point to a line
%   line and point are each 3x1 matrices

    dimension_line = size(line);
    dimension_point = size(point);
    
    if dimension_line(1) == 3 && dimension_line(2) == 1 && ...
            dimension_point(1) == 3 && dimension_point(2) == 1 && ...
            round(line(1,1) * line(1,1) + line(2,1) * line(2,1)) == 1
        point = inhomogeneous(point);
        point = [point; 1];
        result = transpose(line) * point;
        distance = abs(result(1,1));
    end


end

