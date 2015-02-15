function point = linesIntersection(line1, line2)
%LINESINTERSECTION Computes the 2D intersection point of 2 lines
%   Both inputs are lines defined as a 3x1 matrix

    dimension_line1 = size(line1);
    dimension_line2 = size(line2);
    
    if dimension_line1(1) == 3 && dimension_line1(2) == 1 && ...
            dimension_line2(1) == 3 && dimension_line2(2) == 1
        disp([transpose(line1); transpose(line2)]);
        point = cross(line1, line2);
    end
end

