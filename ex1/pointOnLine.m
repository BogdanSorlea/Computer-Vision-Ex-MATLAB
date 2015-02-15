function isOnLine = pointOnLine(point, line)
%POINTONLINE Calculates whether point is located on line
%   Each input is a matrix with 3 lines and 1 column

    dimension_point = size(point);
    dimension_line = size(line);
    
    if dimension_point(1) == 3 && dimension_point(2) == 1 && ...
        dimension_line(1) == 3 && dimension_line(2) == 1
        
        product = transpose(line) * point;
        
        if product(1,1) == 0
            disp('is on line (TRUE)')
            isOnLine = true;
        else
            disp('is not on line (FALSE)')
            isOnLine = false;
        end
        
    end

end

