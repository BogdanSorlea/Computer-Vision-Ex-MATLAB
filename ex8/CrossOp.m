function matrix = CrossOp( vector )
%CROSSOP Returns the matrix version of the vector for cross product mult.

    if size(vector, 1) == 3 && size(vector, 2) == 1
        matrix = zeros(3, 3);
        matrix(1,1) = 0;
        matrix(2,2) = 0;
        matrix(3,3) = 0;
        matrix(1,2) = -vector(3,1);
        matrix(1,3) = vector(2,1);
        matrix(2,1) = vector(3,1);
        matrix(2,3) = -vector(1,1);
        matrix(3,1) = -vector(2,1);
        matrix(3,2) = vector(1,1);
    end;

end

